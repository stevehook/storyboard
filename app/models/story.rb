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
  STATUSES = [:open, :ready, :committed, :done, :rejected]
  #key :title
  #referenced_in :status, :class_name => 'StoryStatus'
  referenced_in :project
  referenced_in :release
  referenced_in :sprint, :inverse_of => :stories
  embeds_many :tasks

  validates :title, :presence => true
  validates :description, :presence => true
  validates :estimate, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 20 }, :presence => true
  #validates :title, :uniqueness => true
  validates :status, :like => { :in => Story::STATUSES }
  
  # TODO: Remove this workaround - see https://github.com/mongoid/mongoid/issues/690
  before_save :before_save
  def before_save
    self.sprint_id = nil if self.sprint_id == ''
    self.tasks_effort_remaining = self.tasks.inject(0) { |n, task| n + task.remaining.to_i }
    self.tasks_estimate = self.tasks.inject(0) { |n, task| n + task.estimate.to_i }
  end
end
