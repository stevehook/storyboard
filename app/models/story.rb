class Story < ActiveRecord::Base
  validates :title, :description, :presence => true
  validates :estimate, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 20}
  validates :title, :uniqueness => true
end
