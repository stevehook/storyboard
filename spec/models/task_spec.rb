require 'spec_helper'

describe Task do
  let(:story) { Story.create(:title => 'test title', :description => 'test description', :estimate => 2) }
  
  context "when adding a task to a story" do
    before(:each) do
      @task = Task.new(:title => 'test task', :estimate => 7, :remaining => 7)
      story.tasks << @task
      story.before_save;      
    end
    
    it "should be embedded" do
      @task.story.should == story
      story.tasks.length.should == 1
    end
    
    it "story#tasks_effort_remaining should be correct" do
      story.tasks_effort_remaining.should == 7
    end
    
    it "story#tasks_estimate should be correct" do
      story.tasks_estimate.should == 7
    end
  end
  
  context "when adding multiple tasks to a story" do
    before(:each) do
      @task1 = Task.new(:title => 'test task 1', :estimate => 7, :remaining => 7)
      @task2 = Task.new(:title => 'test task 2', :estimate => 14, :remaining => 14)
      @task3 = Task.new(:title => 'test task 3', :estimate => 4, :remaining => 4)
      story.tasks << [@task1, @task2, @task3]
      story.before_save;      
    end
    
    it "should be embedded" do
      @task1.story.should == story
      @task2.story.should == story
      @task3.story.should == story
      story.tasks.length.should == 3
    end
    
    it "story#tasks_effort_remaining should be correct" do
      story.tasks_effort_remaining.should == 25
    end
    
    it "story#tasks_estimate should be correct" do
      story.tasks_estimate.should == 25
    end
  end
end
