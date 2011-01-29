class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :data_type => String
  field :description, :data_type => String
  references_many :sprints

  validates :title, :presence => true
end
