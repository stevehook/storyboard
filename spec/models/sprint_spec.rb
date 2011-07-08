require 'spec_helper'

describe Sprint do
  let(:project) { Project.create(:title => 'test project') }
  let(:release) { Release.create(:title => 'test release', :project => project) }
  let(:sprint) { Sprint.create(:title => 'test sprint', :description => 'test description', :order => 1) }

  it "should be valid if mandatory attributes are specified" do
    sprint.release = release
    sprint.valid?.should be_true
    sprint.errors[:title].none?.should be_true
  end

  it "should be invalid if mandatory attributes are NOT specified" do
    sprint.valid?.should be_false
    sprint.errors[:release].any?.should be_true
  end
  
  context "when setting the sprint on a story" do
    let(:story) { Story.create(:title => 'test story') }
  
    it "should add the story to the sprint" do
      story.sprint = sprint
      sprint.stories.length.should == 1
    end
  end
  
  context "when adding a story to a sprint" do
    let(:story) { Story.create(:title => 'test story', :estimate => 5) }
  
    it "should associate the sprint with the story" do
      sprint.stories << story
      story.sprint.should_not be_nil
      story.sprint.should == sprint
    end
    
    it "should update the sprint#story_count" do
      sprint.stories << story
      sprint.refresh_counts
      sprint.story_count.should == 1
    end
    
    it "should update the sprint#points_count" do
      sprint.stories << story
      sprint.refresh_counts
      sprint.points_count.should == 5
    end
  end
  
  context "when a sprint is in_progress" do
    before(:each) do
      sprint.status = :in_progress
      sprint.release = release
    end

    it "should not be deletable" do
      sprint.can_delete?.should == false
    end

    it "should be finishable" do
      sprint.can_finish?.should == true
    end

    context "when finishing the sprint with incomplete stories" do
      let(:story) { Story.create(:title => 'test story', :estimate => 5, :status => :committed) }

      before(:each) do
        sprint.stories << story
        story.tasks << Task.new(:title => 'test task 2', :status => :in_progress, :estimate => 7, :remaining => 3)
        sprint.finish
      end

      it "the incomplete story should be removed from the sprint" do
        story.sprint.should be_nil
      end

      it "the incomplete story should be set back to the ready status" do
        story.status.should == :ready
      end

      it "the sprint should have status finished" do
        sprint.status.should == :finished
      end
    end

    context "when finishing the sprint with a complete story" do
      let(:story) { Story.create(:title => 'test story', :estimate => 5, :status => :committed) }

      before(:each) do
        sprint.stories << story
        story.tasks << Task.new(:title => 'test task 2', :status => :done, :estimate => 7, :remaining => 0)
        sprint.finish
      end

      it "the complete story should be remain in the sprint" do
        story.sprint_id.should == sprint.id
      end

      it "the complete story should be set to the done status" do
        story.status.should == :done
      end

      it "the sprint should have status finished" do
        sprint.status.should == :finished
      end
    end
  end
  
  context "when a sprint is not_started" do
    before(:each) do
      sprint.status = :not_started
      sprint.release = release
    end

    it "should be deletable" do
      sprint.can_delete?.should == true
    end

    it "should not be finishable" do
      sprint.can_finish?.should == false
    end
  end
  
  context "when a sprint is finished" do
    before(:each) do
      sprint.status = :finished
      sprint.release = release
    end

    it "should not be deletable" do
      sprint.can_delete?.should == false
    end

    it "should not be finishable" do
      sprint.can_finish?.should == false
    end
  end
end
