class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :description, :type => String
  field :estimate, :type => Integer
  field :remaining, :type => Integer
  field :status, :data_type => String, :default => :not_started
  STATUSES = [:not_started, :in_progress, :done]
  
  validates :status, :like => { :in => Task::STATUSES.collect { |sym| sym.to_s } }
  validates :title, :presence => true
  validates :estimate, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 35 }, :presence => true
  validates :remaining, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 35 }, :presence => true
  
  embedded_in :story, :inverse_of => :tasks
  
  before_save :before_save
  def before_save
    self.remaining = self.estimate if self.remaining.nil?
    Rails.logger.info "before save #{self.remaining}"
    self.story.refresh_counts
    self.story.save
  end
end
