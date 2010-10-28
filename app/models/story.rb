class Story < ActiveRecord::Base
  validates :title, :description, :presence => true
  validates :estimate, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 20}
  validates :title, :uniqueness => true
  
  belongs_to :status, :class_name => 'StoryStatus', :foreign_key => 'story_status_id'
end
