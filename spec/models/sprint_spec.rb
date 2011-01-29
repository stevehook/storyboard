require 'spec_helper'

describe Sprint do
  before(:each) do
   end

   after(:each) do
   end
   
  it "should be valid if mandatory attributes are specified" do
    sprint = Sprint.create(:title => 'test title', :description => 'test description', :estimate => 2)
    sprint.valid?.should be_true
    sprint.errors[:title].none?.should be_true
  end
  
end
