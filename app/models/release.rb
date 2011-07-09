class Release
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :data_type => String
  field :order, :data_type => Integer
  field :sprint_length, :data_type => Integer, :default => Project::DEFAULT_SPRINT_LENGTH
  field :description, :data_type => String
  field :start_date, :data_type => Date, :default => Time.new

  # key :title
  references_many :sprints, :inverse_of => :release
  referenced_in :project
  references_many :users
  belongs_to :current_sprint, :class_name => 'Sprint'

  validates :title, :presence => true
  validates :project, :presence => true
  validates :sprint_length, :presence => true
  
  before_save :before_save
  
  def create_sprint(sprint = nil)
    coerce_properties
    sprint ||= Sprint.create()
    sprint.order = self.sprints.length + 1
    sprint.title = (self.sprints.length + 1).to_s
    sprint.start_date = self.start_date + (self.sprints.length * self.sprint_length * Project::ONE_DAY)
    sprint.end_date = self.start_date + (((self.sprints.length + 1) * self.sprint_length - 1) * Project::ONE_DAY)
    sprint
  end
  
  def add_sprint(sprint = nil)
    sprint = create_sprint(sprint)
    self.sprints << sprint
    sprint
  end
  
  def coerce_properties
    # Coerce date types
    # TODO: There must be a better way to do this... why don't mongoid/rails allow us to put string values into non-string fields?
    self.sprint_length = self.sprint_length.to_i if self.sprint_length.class == String
    self.start_date = Time.parse(self.start_date) if self.start_date.class == String    
  end

  def first_sprint
    self.sprints.min_by { |sprint| sprint.order }
  end

  def start_sprints
    starting_sprint = first_sprint   
    starting_sprint.status = :in_progress if starting_sprint
    self.current_sprint = starting_sprint
  end
  
  def finish_sprint_and_start_next(finishing_sprint)
    starting_sprint = self.sprints.select { |sprint| sprint.order == finishing_sprint.order + 1 }.first
    starting_sprint.status = :in_progress if starting_sprint
    finishing_sprint.status = :finished
    finishing_sprint.save
    starting_sprint.save if starting_sprint
    self.current_sprint = starting_sprint
    self.save
  end
  
  def end_date
    coerce_properties
    self.start_date + (self.sprints.length * self.sprint_length * Project::ONE_DAY) if self.start_date && self.start_date != ''
  end
  
  def before_save
    coerce_properties
    if self.start_date_changed?
      self.sprints.each do |sprint|
        sprint.start_date = self.start_date + ((sprint.order - 1) * self.sprint_length * Project::ONE_DAY)
        sprint.end_date = self.start_date + (((sprint.order * self.sprint_length) - 1) * Project::ONE_DAY)
      end
    end
  end
end
