require 'rubygems'
require 'mongoid'

class StoryStatus
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :data_type => String

  validates :title, :presence => true
  validates :title, :uniqueness => true
end