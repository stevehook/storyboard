class Project
  DEFAULT_SPRINT_LENGTH = 14
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :data_type => String
  field :sprint_length, :data_type => Integer, :default => DEFAULT_SPRINT_LENGTH
  field :description, :data_type => String
  field :start_date, :data_type => Date
  references_many :sprints

  validates :title, :presence => true
  validates :sprint_length, :presence => true
  
  def add_sprint
    sprint = Sprint.create(:title => 'fill in sprint title', 
      :order => self.sprints.length + 1,
      :title => (self.sprints.length + 1).to_s,
      :start_date => self.start_date + (self.sprints.length * self.sprint_length * 2592000),
      :end_date => self.start_date + (((self.sprints.length + 1) * self.sprint_length - 1) * 2592000))
    self.sprints << sprint
    sprint
  end
end
