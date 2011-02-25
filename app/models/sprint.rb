class Sprint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :data_type => String
  field :description, :data_type => String
  field :order, :data_type => Integer
  field :start_date, :data_type => Date
  field :end_date, :data_type => Date
  field :story_count, :data_type => Integer, :default => 0
  field :points_count, :data_type => Integer, :default => 0
  # key :title
  references_many :stories, :inverse_of => :_sprint
  referenced_in :release

  attr_protected :story_count, :points_count

  validates :title, :presence => true
  validates :release, :presence => true
  validates :story_count, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true
  validates :points_count, :numericality => { :greater_than_or_equal_to => 0 }, :presence => true
  
  before_save :before_save
  def before_save
    refresh_counts
  end

  def refresh_counts
    self.story_count = self.stories.length
    self.points_count = self.stories.inject(0) { |n, story| story.estimate.to_i + n }
  end
end
