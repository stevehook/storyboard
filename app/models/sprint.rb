class Sprint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :data_type => String
  field :description, :data_type => String
  references_many :stories

  validates :title, :presence => true
end
