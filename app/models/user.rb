class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Paperclip

  attr_accessible :name, :email, :password, :password_confirmation, :team_id, :profile, :image, :current_project_id, :current_project, :current_release_id, :current_release 
  attr_accessor :password
  field :name, :data_type => String
  field :email, :data_type => String
  field :profile, :data_type => String
  has_mongoid_attached_file :image
  field :password_hash,  :data_type => String
  field :password_salt, :data_type => String
  referenced_in :team, :inverse_of => :members
  referenced_in :current_project, :class_name => 'Project'
  referenced_in :current_release, :class_name => 'Release'

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
    encrypt_password
    self.team_id = nil if self.team_id == ''
  end

  def self.authenticate(input, password)
    user = User.find_by_email(input) || User.find_by_name(input)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.find_by_name(name)
    User.where(:name => name).first
  end

  def self.find_by_email(email)
    User.where(:email => email).first
  end
  
  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end  
end
