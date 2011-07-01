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
  embeds_many :history, :class_name => 'StoryHistoryItem'

  scope :in_project, lambda { |project_id| where(:project_id => project_id) }
  
  attr_protected :tasks_effort_remaining, :tasks_estimate

  validates :title, :presence => true
  validates :description, :presence => true
  validates :estimate, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 20 }, :presence => true
  validates :priority, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10000 }, :presence => true
  validates :status, :like => { :in => Story::STATUSES }
  
  def self.product_backlog(project_id, filter = nil)
    #TODO: Will need to refactor to generalise the filter handling code to deal with many filter parameters
    hash = {}
    if filter && filter.status
      hash[:status] = filter.status
    else
      hash[:status.nin] = [:done, :rejected]
    end
    Story.in_project(project_id).where(hash).ascending(:priority)
  end
  
  def reprioritise(new_priority)
    old_priority = self.priority
    
    # reorder the priorities of all the stories in the same project with priorities between priority and old_priority
    if new_priority < old_priority
      modified_stories = Story.where(:id.ne => self.id, :priority.lt => old_priority, :priority.gte => new_priority, 
        :project_id => self.project_id).ascending(:priority)
      modified_stories.each_with_index do |story, index| 
        story.priority  = (1 + index + new_priority) if story.priority_writable?
        story.save
      end
    else 
      modified_stories = Story.where(:id.ne => self.id, :priority.lte => new_priority, :priority.gt => old_priority, 
        :project_id => self.project_id).ascending(:priority)
      modified_stories.each_with_index do |story, index| 
        story.priority  = (old_priority + index) if story.priority_writable?
        story.save
      end
    end

    self.priority = new_priority
    self.save
  end
  
  def priority_writable?
    (self.priority != 10000 and self.priority != 0)
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
    self._sprint_id = id.blank? ? nil : id
    self.release = self.sprint.release if self.sprint
  end

  before_save :before_save
  def before_save
    # TODO: Remove this workaround - see https://github.com/mongoid/mongoid/issues/690
    self.sprint_id = nil if self.sprint_id == ''
    refresh_counts
    write_history
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

  def write_history
    # Have to set the created_at time explicitly - workaround for mongoid issue 922 
    if self.new_record?
      self.history << StoryHistoryItem.new(:title => "Story created", :user => User.current, :created_at => Time.now.utc)
    end

    if self.status_changed?
      self.history << StoryHistoryItem.new(:title => "Status changed to #{self.status}", :user => User.current)
    end
    
    if !self._sprint.nil? && self._sprint_id_changed? 
      self.history << StoryHistoryItem.new(:title => "Added to sprint #{self.sprint.title}", :user => User.current)
    end
  end
end
