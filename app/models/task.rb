class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :description, :type => String
  field :estimate, :type => Integer
  field :remaining, :type => Integer
  
  embedded_in :story, :inverse_of => :tasks
end
