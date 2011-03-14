class User
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :name, :email, :password, :password_confirmation
  attr_accessor :password
  field :name, :data_type => String
  field :email, :data_type => String
  field :password_hash,  :data_type => String
  field :password_salt, :data_type => String
  referenced_in :team, :inverse_of => :members

  validates_presence_of :name, :email
  validates_presence_of :password, :on => :create

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  before_save :before_save
  def before_save
    self.team_id = nil if self.team_id == ''
  end
end
