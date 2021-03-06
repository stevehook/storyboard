require 'rubygems'
require 'mongoid'

class StoryHistoryItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title
  referenced_in :user
  embedded_in :story
end
