class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :data_type => String
  field :description, :data_type => String
  field :start_date, :data_type => Date
  references_many :sprints

  validates :title, :presence => true
  
  def add_sprint
    sprint = Sprint.create(:title => 'fill in sprint title', :order => self.sprints.length + 1)
    self.sprints << sprint
    sprint
  end
end
