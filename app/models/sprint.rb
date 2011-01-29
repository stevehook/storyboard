class Sprint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :data_type => String
  field :description, :data_type => String
  field :order, :data_type => Integer
  field :start_date, :data_type => Date
  field :end_date, :data_type => Date
  references_many :stories
  referenced_in :project
  

  validates :title, :presence => true
end
