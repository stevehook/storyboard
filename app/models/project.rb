class Project
  DEFAULT_SPRINT_LENGTH = 14
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :data_type => String
  field :sprint_length, :data_type => Integer, :default => DEFAULT_SPRINT_LENGTH
  field :description, :data_type => String
  field :start_date, :data_type => Date, :default => Time.new
  references_many :sprints

  validates :title, :presence => true
  validates :sprint_length, :presence => true
  
  before_save :before_save
  
  def add_sprint
    sprint = Sprint.create(:title => 'fill in sprint title', 
      :order => self.sprints.length + 1,
      :title => (self.sprints.length + 1).to_s,
      :start_date => self.start_date + (self.sprints.length * self.sprint_length * 2592000),
      :end_date => self.start_date + (((self.sprints.length + 1) * self.sprint_length - 1) * 2592000))
    self.sprints << sprint
    sprint
  end
  
  def end_date
    self.start_date + (self.sprints.length * self.sprint_length * 2592000)
  end
  
  def before_save
    if self.start_date_changed?
      self.sprints.each do |sprint|
        sprint.start_date = self.start_date + ((sprint.order - 1) * self.sprint_length * 2592000)
        sprint.end_date = self.start_date + (((sprint.order * self.sprint_length) - 1) * 2592000)
      end
    end
  end
end
