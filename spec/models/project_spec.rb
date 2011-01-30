require 'spec_helper'

describe Project do
  let(:project) { Project.create(:title => 'test project', :start_date => Time.new) }
   
  it "should be valid if mandatory attributes are specified" do
    project.valid?.should be_true
    project.errors[:title].none?.should be_true
  end
  
  context "after creating new Project with one sprint" do
    let!(:sprint) { project.add_sprint }
    
    it "should have 1 sprint in the collection" do
      project.sprints.length.should == 1
    end
    
    it "sprint should have order 1" do
      sprint.order.should == 1
    end
    
    it "sprint should have correct start time" do
      # TODO
    end
  end
end
