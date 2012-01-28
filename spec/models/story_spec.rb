require 'rubygems'
require 'spec_helper'

describe Story do
  before(:each) do
  end
  
  after(:each) do
  end

  context "when creating a new valid story" do
    before(:each) do
      @story = Story.new(:title => 'test title', :description => 'test description', :estimate => 2)
    end

    it "should be valid if mandatory attributes are specified" do
      @story.valid?.should be_true
      @story.errors[:title].none?.should be_true
      @story.errors[:description].none?.should be_true
      @story.errors[:estimate].none?.should be_true
    end
    
    it "should be able to save a valid story" do
      @story.save.should be_true
    end

    context "after save" do
      before(:each) do
        @story.before_save
      end

      it "should have a default priority of 10000" do
        @story.priority.should == 10000
      end
      
      it "should have a default status of open" do
        @story.status.should == :open
      end

      it "should have 1 history item" do
        @story.history.length.should == 1
      end

      it "first history item should have correct title" do
        @story.history[0].title.should == 'Story created'
      end
    end
  end

  context "when creating a new story without a title" do
    before(:each) do
      @story = Story.create(:description => 'test description', :estimate => 2)
    end

    it "should be invalid if title missing" do
      @story.invalid?.should be_true
      @story.errors[:title].any?.should be_true
      @story.errors[:description].none?.should be_true
      @story.errors[:estimate].none?.should be_true
    end

    it "should not be able to save an invalid story" do
      !@story.save.should be_false
    end
  end
 
  context "when creating a new story without an estimate" do 
    before(:each) do
      @story = Story.create(:title => 'test title', :description => 'test description')
    end

    it "should be invalid if estimate missing" do
      @story.invalid?.should be_true
      @story.errors[:title].none?.should be_true
      @story.errors[:description].none?.should be_true
      @story.errors[:estimate].any?.should be_true
    end
  end
  
  context "when creating a new story without an description" do 
    before(:each) do
      @story = Story.create(:title => 'test title', :estimate => 2)
    end

    it "should be invalid if description missing" do
      @story.invalid?.should be_true
      @story.errors[:title].none?.should be_true
      @story.errors[:description].any?.should be_true
    end
  end

  context "when creating a new story with an estimate of less than 1" do 
    before(:each) do
      @story = Story.create(:title => 'test title', :description => 'test description', :estimate => 0.99)
    end

    it "should be invalid if estimate is less than 1" do
      @story.invalid?.should be_true
      @story.errors[:estimate].any?.should be_true
    end
  end

  context "when creating a new story with an estimate of greater than 20" do 
    before(:each) do
      @story = Story.create(:title => 'test title', :description => 'test description', :estimate => 21)
    end

    it "should be invalid if estimate is greater than 20" do
      @story = Story.create(:title => 'test title', :description => 'test description', :estimate => 21)
      @story.invalid?.should be_true
      @story.errors[:estimate].any?.should be_true
    end
  end

  context "when a story is done" do
    before(:each) do
      @story = Story.create(:title => 'test title', :description => 'test description')
      @story.status = :done
      @story.before_save
    end
    
    it "should have a priority of 0" do
      @story.priority.should == 0
    end
    
    it "should have 2 history items" do
      @story.status_changed?.should == true
      @story.history.length.should == 2
    end
    
    it "second history item should have correct title" do
      # TODO: Can we rely on the status changed history item being the first?
      @story.history[1].title.should == 'Status changed to done'
    end
  end

  context "when a story has incomplete tasks" do
    before(:each) do
      @story = Story.create(:title => 'test title', :description => 'test description')
      @story.status = :committed
      @story.tasks << Task.new(:title => 'test task 1', :status => :done, :estimate => 7, :remaining => 0)
      @story.tasks << Task.new(:title => 'test task 2', :status => :not_started, :estimate => 7, :remaining => 7)
    end

    it "the story should not be complete" do
      @story.has_incomplete_tasks?.should == true
    end
  end

  context "when a story has 2 complete tasks" do
    before(:each) do
      @story = Story.create(:title => 'test title', :description => 'test description')
      @story.status = :committed
      @story.tasks << Task.new(:title => 'test task 1', :status => :done, :estimate => 7, :remaining => 0)
      @story.tasks << Task.new(:title => 'test task 2', :status => :done, :estimate => 7, :remaining => 0)
    end

    it "the story should be complete" do
      @story.has_incomplete_tasks?.should == false
    end
  end
  
  context "when a story is added to a sprint" do
    before(:each) do
      @release = Release.create(:title => 'Version 1.0')
      @sprint = Sprint.create(:title => '1', :release => @release)
      @story = Story.create(:title => 'test title', :description => 'test description')
      @story.sprint = @sprint
      @story.before_save
    end

    it "should have be allocated to the same release as the sprint" do
      @story.release.should_not be_nil
      @story.release.should == @release
    end

    it "should have 2 history items" do
      @story.history.length.should == 2
    end
    
    it "second history item should have correct title" do
      # TODO: Can we rely on the status changed history item being the first?
      @story.history[1].title.should == 'Added to sprint 1'
    end
  end

  context "when reading the project backlog" do
    before(:each) do
      @project1 = Project.create!(:title => 'Project 1')
      @project2 = Project.create!(:title => 'Project 2')
      @story11 = Story.create!(:title => 'story 1.1', :description => 'test', :project => @project1, :priority => 2, :estimate => 1, :status => :open)
      @story12 = Story.create!(:title => 'story 1.2', :description => 'test', :project => @project1, :priority => 1, :estimate => 1, :status => :ready)
      @story13 = Story.create!(:title => 'story 1.3', :description => 'test', :project => @project1, :priority => 10000, :estimate => 1, :status => :rejected)
      @story21 = Story.create!(:title => 'story 2.1', :description => 'test', :project => @project2, :estimate => 1)
    end
    
    it "the project backlog can be filtered by status" do
      filter = StoryFilter.new(:status => :ready)
      backlog = Story.product_backlog(@project1.id, filter)
      backlog.size.should == 1
      backlog[0].id.should == @story12.id
    end
    
    it "the project backlog for Project 1 contain only the Project 1 stories in priority order" do
      backlog = Story.product_backlog(@project1.id)
      backlog.size.should == 2
      backlog[0].id.should == @story12.id
      backlog[1].id.should == @story11.id
    end
    
    it "the project backlog for Project 2 contain only the Project 2 stories" do
      backlog = Story.product_backlog(@project2.id)
      backlog.size.should == 1
      backlog[0].id.should == @story21.id
    end
  end
end
