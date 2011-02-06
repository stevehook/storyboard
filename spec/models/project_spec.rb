require 'spec_helper'

describe Project do
  START_DATE = Time.utc(2011, 'jan', 1)
  NEW_START_DATE = Time.utc(2011, 'feb', 12)
  
  let(:project) { Project.create(:title => 'test project') }
   
  it "should be valid if mandatory attributes are specified" do
    project.valid?.should be_true
    project.errors[:title].none?.should be_true
  end
  
  # context "after adding one sprint" do
  #   let!(:sprint) { project.add_sprint }
  #   
  #   it "should have 1 sprint in the collection" do
  #     project.sprints.length.should == 1
  #   end
  #   
  #   it "sprint should have order 1" do
  #     sprint.order.should == 1
  #   end
  #   
  #   it "sprint should have title '1'" do
  #     sprint.title.should == '1'
  #   end
  #   
  #   it "sprint should have correct start date" do
  #     sprint.start_date.should == START_DATE
  #   end
  #   
  #   it "sprint should have correct end date" do
  #     sprint.end_date.should == START_DATE + ((Project::DEFAULT_SPRINT_LENGTH - 1) * Project::ONE_DAY)
  #   end
  #   
  #   context "after adding second sprint" do
  #     let!(:sprint2) { project.add_sprint }
  #   
  #     it "should have 2 sprint in the collection" do
  #       project.sprints.length.should == 2
  #     end
  # 
  #     it "sprint 2 should have order 2" do
  #       sprint2.order.should == 2
  #     end
  # 
  #     it "sprint 2 should have title '2'" do
  #       sprint2.title.should == '2'
  #     end
  #   
  #     it "sprint 2 should have correct start date" do
  #       sprint2.start_date.should == START_DATE + (Project::DEFAULT_SPRINT_LENGTH * Project::ONE_DAY)
  #     end
  #   
  #     it "sprint 2 should have correct end date" do
  #       sprint2.end_date.should == START_DATE + (((Project::DEFAULT_SPRINT_LENGTH * 2) - 1) * Project::ONE_DAY)
  #     end
  #   end
  # end
  # 
  # context "after changing start date of project with two sprints" do
  #   let!(:sprint1) { project.add_sprint }
  #   let!(:sprint2) { project.add_sprint }
  #   
  #   before(:each) do
  #     project.start_date = NEW_START_DATE
  #     project.before_save
  #   end
  #   
  #   it "sprint 1 start_date should be adjusted correctly" do
  #     sprint1.start_date.should == NEW_START_DATE
  #   end
  #   
  #   it "sprint 1 end_date should be adjusted correctly" do
  #     sprint1.end_date.should == NEW_START_DATE + ((Project::DEFAULT_SPRINT_LENGTH - 1) * Project::ONE_DAY)
  #   end
  #   
  #   it "sprint 2 start_date should be adjusted correctly" do
  #     sprint2.start_date.should == NEW_START_DATE + (Project::DEFAULT_SPRINT_LENGTH * Project::ONE_DAY)
  #   end
  #   
  #   it "sprint 2 end_date should be adjusted correctly" do
  #     sprint2.end_date.should == NEW_START_DATE + (((Project::DEFAULT_SPRINT_LENGTH * 2) - 1) * Project::ONE_DAY)
  #   end
  # end
end
