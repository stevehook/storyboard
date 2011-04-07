class Project
  DEFAULT_SPRINT_LENGTH = 14
  ONE_DAY = 86400
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :data_type => String
  field :sprint_length, :data_type => Integer, :default => DEFAULT_SPRINT_LENGTH
  field :description, :data_type => String
  #key :title
  references_many :releases
  references_many :users

  validates :title, :presence => true
  validates :sprint_length, :presence => true
  
  # before_save :before_save
  # 
  def create_release(release = nil)
    coerce_properties
    release ||= Release.create()
    release.order = self.releases.length + 1
    release.sprint_length = self.sprint_length
    release
  end
  
  def coerce_properties
    # Coerce data types - must be a better way to do this...
    self.sprint_length = self.sprint_length.to_i if self.sprint_length.class == String
  end
  # 
  # def add_sprint(sprint = nil)
  #   sprint = create_sprint(sprint)
  #   self.sprints << sprint
  #   sprint
  # end
  # 
  # def end_date
  #   coerce_properties
  #   self.start_date + (self.sprints.length * self.sprint_length * ONE_DAY) if self.start_date && self.start_date != ''
  # end
  # 
  # def before_save
  #   coerce_properties
  #   if self.start_date_changed?
  #     self.sprints.each do |sprint|
  #       sprint.start_date = self.start_date + ((sprint.order - 1) * self.sprint_length * ONE_DAY)
  #       sprint.end_date = self.start_date + (((sprint.order * self.sprint_length) - 1) * ONE_DAY)
  #     end
  #   end
  # end
end
