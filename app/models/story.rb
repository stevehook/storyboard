require 'rubygems'
require 'mongoid'

class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :data_type => String
  field :description, :data_type => String
  field :estimate, :data_type => Integer
  field :status, :data_type => String, :default => :open
  STATUSES = [:open, :ready, :committed, :done, :rejected]
  #key :title
  #referenced_in :status, :class_name => 'StoryStatus'
  referenced_in :project
  referenced_in :release
  referenced_in :sprint, :inverse_of => :stories

  validates :title, :presence => true
  validates :description, :presence => true
  validates :estimate, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 20 }, :presence => true
  #validates :title, :uniqueness => true
  
  # TODO: Remove this workaround - see https://github.com/mongoid/mongoid/issues/690
  before_save :before_save
  def before_save
    self.sprint_id = nil if self.sprint_id == ''
  end
end
