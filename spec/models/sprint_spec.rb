require 'spec_helper'

describe Sprint do
  let(:release) { Release.create(:title => 'test release') }
  let(:sprint) { Sprint.create(:title => 'test sprint', :description => 'test description') }

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
    let(:story) { Story.create(:title => 'test story') }
  
    it "should associate the sprint with the story" do
      sprint.stories << story
      story.sprint.should_not be_nil
      story.sprint.should == sprint
    end
  end
end
