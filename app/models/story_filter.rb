class StoryFilter
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :status, :page

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def attributes
    { :status => self.status }
  end

  def persisted?
    false
  end  
end
