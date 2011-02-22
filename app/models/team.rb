class Team
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  references_many :members, :class_name => 'User', :inverse_of => :team
  referenced_in :product_owner, :class_name => 'User'
  referenced_in :scrum_master, :class_name => 'User'
  
  before_save :before_save
  def before_save
    self.scrum_master_id = nil if self.scrum_master_id == ''
    self.product_owner_id = nil if self.product_owner_id == ''
    self.scrum_master.team = self if self.scrum_master
  end
end
