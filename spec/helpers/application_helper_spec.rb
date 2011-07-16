require 'spec_helper'

describe ApplicationHelper do
  context "page title" do
    before(:each) { @content_for_title = nil }

    it "should display the correct title when the current project is nil" do
      helper.page_title.should == 'Storyboard'
    end

    it "should display the correct title when there is a current project" do
      @content_for_title = 'Test Project'
      helper.page_title.should == 'Test Project &mdash; Storyboard'
    end
  end

  # context "page heading" do
  #   it "should ..." do
  #     helper.page_heading(nil).should == ''
  #   end
  # end

  context "sub heading" do
    it "should show heading without ID" do
      helper.sub_heading('test text').should == '<div class="subHeading">test text</div>'
    end
    
    it "should show heading with ID" do
      helper.sub_heading('test text', 'testID').should == '<div class="subHeading" id="testID">test text</div>'
    end
  end

  context "status badge" do
    it "should display a green badge for done stories" do
      story = stub('Story', :status => :done)
      helper.status_badge(story).should == '<span class="statusBadge" style="background-color: #008;">Done</span>'
    end

    it "should display a blue badge for committed stories" do
      story = stub('Story', :status => :committed)
      helper.status_badge(story).should == '<span class="statusBadge" style="background-color: #080;">Committed</span>'
    end

    it "should display an amber badge for ready stories" do
      story = stub('Story', :status => :ready)
      helper.status_badge(story).should == '<span class="statusBadge" style="background-color: #E0981B;">Ready</span>'
    end

    it "should display a red badge for open stories" do
      story = stub('Story', :status => :open)
      helper.status_badge(story).should == '<span class="statusBadge" style="background-color: #800;">Open</span>'
    end

    it "should display a grey badge for rejected stories" do
      story = stub('Story', :status => :rejected)
      helper.status_badge(story).should == '<span class="statusBadge" style="background-color: #888;">Rejected</span>'
    end

    it "should display a green badge for finished tasks" do
      task = stub('Task', :status => :finished)
      helper.status_badge(task).should == '<span class="statusBadge" style="background-color: #008;">Finished</span>'
    end

    it "should display an amber badge for in_progress tasks" do
      task = stub('Task', :status => :in_progress)
      helper.status_badge(task).should == '<span class="statusBadge" style="background-color: #E0981B;">In progress</span>'
    end

    it "should display a red badge for not_started tasks" do
      task = stub('Task', :status => :not_started)
      helper.status_badge(task).should == '<span class="statusBadge" style="background-color: #800;">Not started</span>'
    end
  end

  context "assignee badge" do
    it "should show 'Unassigned' for a unassigned tasks" do
      task = stub('Task', :assignee_name => nil)
      helper.assignee_badge(task).should == '<span class="assigneeBadge">Unassigned</span>'
    end
    
    it "should show assignee name for a assigned tasks" do
      task = stub('Task', :assignee_name => 'Fred')
      helper.assignee_badge(task).should == '<span class="assigneeBadge">Fred</span>'
    end
  end

  context "estimate badge" do
    it "should show the estimate for a story" do
      story = stub('Story', :class => Story, :estimate => 12)
      helper.estimate_badge(story).should == '<span class="priorityBadge">12</span>'
    end

    it "should show the estimate for a task" do
      task = stub('Task', :class => Task, :estimate => 8, :remaining => 4)
      helper.estimate_badge(task).should == '<span class="priorityBadge">4/8</span>'
    end
  end
end
