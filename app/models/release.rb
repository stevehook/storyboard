class Release
  DEFAULT_SPRINT_LENGTH = 14
  ONE_DAY = 86400
  
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
  
  def create_sprint(sprint = nil)
    coerce_properties
    sprint ||= Sprint.create()
    sprint.order = self.sprints.length + 1
    sprint.title = (self.sprints.length + 1).to_s
    sprint.start_date = self.start_date + (self.sprints.length * self.sprint_length * ONE_DAY)
    sprint.end_date = self.start_date + (((self.sprints.length + 1) * self.sprint_length - 1) * ONE_DAY)
    sprint
  end
  
  def add_sprint(sprint = nil)
    sprint = create_sprint(sprint)
    self.sprints << sprint
    sprint
  end
  
  def coerce_properties
    # Coerce date types - must be a better way to do this...
    self.sprint_length = self.sprint_length.to_i if self.sprint_length.class == String
    self.start_date = Time.parse(self.start_date) if self.start_date.class == String    
  end
  
  def end_date
    coerce_properties
    self.start_date + (self.sprints.length * self.sprint_length * ONE_DAY) if self.start_date && self.start_date != ''
  end
  
  def before_save
    coerce_properties
    if self.start_date_changed?
      self.sprints.each do |sprint|
        sprint.start_date = self.start_date + ((sprint.order - 1) * self.sprint_length * ONE_DAY)
        sprint.end_date = self.start_date + (((sprint.order * self.sprint_length) - 1) * ONE_DAY)
      end
    end
  end
end
