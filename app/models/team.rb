class Team
  include Mongoid::Document
  field :name, :type => String
  references_many :users
  referenced_in :product_owner, :class_name => 'User'
  referenced_in :scrum_master, :class_name => 'User'
end
