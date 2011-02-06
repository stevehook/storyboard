require 'spec_helper'

describe Release do
  START_DATE = Time.utc(2011, 'jan', 1)
  NEW_START_DATE = Time.utc(2011, 'feb', 12)
  
  let(:project) { Project.create(:title => 'test project') }
  let(:release) { Release.create(:title => 'test release', :start_date => START_DATE) }

  it "should be valid if mandatory attributes are specified" do
    release.project = project
    release.valid?.should be_true
    release.errors[:title].none?.should be_true
  end

  it "should be invalid if mandatory attributes are NOT specified" do
    release.valid?.should be_false
    release.errors[:project].none?.should be_false
  end
  
  context "after adding one sprint" do
    let!(:sprint) { release.add_sprint }
    
    it "should have 1 sprint in the collection" do
      release.sprints.length.should == 1
    end
    
    it "sprint should have order 1" do
      sprint.order.should == 1
    end
    
    it "sprint should have title '1'" do
      sprint.title.should == '1'
    end
    
    it "sprint should have correct start date" do
      sprint.start_date.should == START_DATE
    end
    
    it "sprint should have correct end date" do
      sprint.end_date.should == START_DATE + ((Project::DEFAULT_SPRINT_LENGTH - 1) * Project::ONE_DAY)
    end
    
    context "after adding second sprint" do
      let!(:sprint2) { release.add_sprint }
    
      it "should have 2 sprint in the collection" do
        release.sprints.length.should == 2
      end
  
      it "sprint 2 should have order 2" do
        sprint2.order.should == 2
      end
  
      it "sprint 2 should have title '2'" do
        sprint2.title.should == '2'
      end
    
      it "sprint 2 should have correct start date" do
        sprint2.start_date.should == START_DATE + (Project::DEFAULT_SPRINT_LENGTH * Project::ONE_DAY)
      end
    
      it "sprint 2 should have correct end date" do
        sprint2.end_date.should == START_DATE + (((Project::DEFAULT_SPRINT_LENGTH * 2) - 1) * Project::ONE_DAY)
      end
    end
  end
  
  context "after changing start date of release with two sprints" do
    let!(:sprint1) { release.add_sprint }
    let!(:sprint2) { release.add_sprint }
    
    before(:each) do
      release.start_date = NEW_START_DATE
      release.before_save
    end
    
    it "sprint 1 start_date should be adjusted correctly" do
      sprint1.start_date.should == NEW_START_DATE
    end
    
    it "sprint 1 end_date should be adjusted correctly" do
      sprint1.end_date.should == NEW_START_DATE + ((Project::DEFAULT_SPRINT_LENGTH - 1) * Project::ONE_DAY)
    end
    
    it "sprint 2 start_date should be adjusted correctly" do
      sprint2.start_date.should == NEW_START_DATE + (Project::DEFAULT_SPRINT_LENGTH * Project::ONE_DAY)
    end
    
    it "sprint 2 end_date should be adjusted correctly" do
      sprint2.end_date.should == NEW_START_DATE + (((Project::DEFAULT_SPRINT_LENGTH * 2) - 1) * Project::ONE_DAY)
    end
  end
end
