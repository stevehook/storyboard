class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :data_type => String
  field :email, :data_type => String

  validates :name, :email, :presence => true
end
