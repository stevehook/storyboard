class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :data_type => String
  field :email, :data_type => String
  referenced_in :team, :inverse_of => :members

  validates :name, :email, :presence => true
  
  before_save :before_save
  def before_save
    self.team_id = nil if self.team_id == ''
  end
end
