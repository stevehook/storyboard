require 'rubygems'
require 'mongoid'

class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :data_type => String
  field :description, :data_type => String
  field :estimate, :data_type => Integer
  referenced_in :status, :class_name => 'StoryStatus'

  validates :title, :presence => true
  validates :description, :presence => true
  validates :estimate, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 20}, :presence => true
  #validates :title, :uniqueness => true
  
  #belongs_to :status, :class_name => 'StoryStatus', :foreign_key => 'story_status_id'
end
