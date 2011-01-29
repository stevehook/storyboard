require 'spec_helper'

describe Project do
  before(:each) do
  end

  after(:each) do
  end
   
  it "should be valid if mandatory attributes are specified" do
    project = Project.create(:title => 'test title', :description => 'test description')
    project.valid?.should be_true
    project.errors[:title].none?.should be_true
  end
  
  context "after creating new Project with one sprint" do
    before(:each) do
      @project = Project.create(:title => 'test project')
      @sprint = @project.add_sprint
    end
    
    it "should have 1 sprint in the collection" do
      @project.sprints.length.should == 1
    end
    
    it "should have 1 sprint in the collection" do
      @sprint.order.should == 1
    end
  end
end
