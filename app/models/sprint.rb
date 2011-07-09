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
  STATUSES = [:not_started, :in_progress, :finished]
  field :status, :data_type => String, :default => :not_started
  field :goal, :data_type => String
  
  # key :title
  references_many :stories, :inverse_of => :_sprint
  referenced_in :release, :inverse_of => :sprints

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

  def finish
    #TODO: Close off the stories and mark any unfinished ones as failed
    finish_all_stories
    refresh_counts
    self.release.finish_sprint_and_start_next(self)
  end

  def finish_all_stories
    self.stories.each do |story|
      if story.has_incomplete_tasks?
        story.status = :ready
        story.sprint = nil
        story.sprint_id = nil
        story.save
      else
        story.status = :done
        story.save
      end
    end
  end

  def can_delete?
    self.story_count == 0 && self.status == :not_started && self.release.sprints.length == self.order
  end

  def can_finish?
    self.status == :in_progress
  end
end
