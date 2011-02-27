require 'rubygems'
require 'mongoid'
require 'like_validator'

class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :data_type => String
  field :description, :data_type => String
  field :estimate, :data_type => Integer
  field :status, :data_type => String, :default => :open
  field :tasks_estimate, :data_type => Integer
  field :tasks_effort_remaining, :data_type => Integer
  field :priority, :data_type => Integer, :default => 10000
  STATUSES = [:open, :ready, :committed, :done, :rejected]
  #key :title
  referenced_in :category
  referenced_in :project
  referenced_in :release
  referenced_in :_sprint, :inverse_of => :stories, :class_name => 'Sprint'
  embeds_many :tasks
  
  attr_protected :tasks_effort_remaining, :tasks_estimate

  validates :title, :presence => true
  validates :description, :presence => true
  validates :estimate, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 20 }, :presence => true
  validates :priority, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10000 }, :presence => true
  validates :status, :like => { :in => Story::STATUSES }
  
  def reprioritise(new_priority)
    old_priority = self.priority
    self.priority = new_priority
    self.save
    
    # reorder the priorities of all the stories in the same project with priorities between priority and old_priority
    if new_priority < old_priority
      modified_stories = Story.where(:priority.gt => old_priority, :priority.lt => new_priority, :project_id => self.project_id).ascending(:priority)
      modified_stories.each { |story| story.increment_priority }
    else 
      modified_stories = Story.where(:priority.gt => new_priority, :priority.lt => old_priority, :project_id => self.project_id).ascending(:priority)
      modified_stories.each { |story| story.decrement_priority }
    end
  end
  
  def increment_priority
    unless self.priority == 10000 or self.priority == 0
      self.priority = self.priority + 1
      self.save
    end
  end
  
  def decrement_priority
    unless self.priority == 10000 or self.priority == 0
      self.priority = self.priority - 1
      self.save
    end
  end
  
  # Need to override the status attr_accessor so that priority gets updated as required
  def status=(val)
    write_attribute(:status, val)
    self.priority = 0 if self.status == :done
  end

  # Need to override the sprint attribute so that we can coordinate the release value
  # Is there a technique that we can use to generalise this?
  def sprint
    self._sprint
  end

  def sprint_id
    self._sprint_id
  end

  def sprint=(new_sprint)
    self._sprint = new_sprint
    self.release = new_sprint.release if new_sprint
  end

  def sprint_id=(id)
    self._sprint_id = id
    self.release = self.sprint.release if self.sprint
  end

  before_save :before_save
  def before_save
    # TODO: Remove this workaround - see https://github.com/mongoid/mongoid/issues/690
    self.sprint_id = nil if self.sprint_id == ''

    refresh_counts
  end
  
  def refresh_counts
    self.tasks_effort_remaining = self.tasks.inject(0) { |n, task| n + task.remaining.to_i }
    self.tasks_estimate = self.tasks.inject(0) { |n, task| n + task.estimate.to_i }
  end
  
  def update_sprint_and_save(attributes = nil)
    self.attributes = attributes if attributes
    if self.sprint
      self.sprint.refresh_counts
      self.sprint.save!
    end
    self.save
  end
end
