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
      helper.sub_heading('test text').should have_selector('div.subHeading', :text => 'test text')
    end
    
    it "should show heading with ID" do
      helper.sub_heading('test text', 'testID').should have_selector('div.subHeading#testID', :text => 'test text')
    end
  end

  context "status badge" do
    it "should display a green badge for done stories" do
      story = stub('Story', :status => :done)
      helper.status_badge(story).should have_selector('span.statusBadge', :text => 'Done', :style => "background-color: #008;")
    end

    it "should display a blue badge for committed stories" do
      story = stub('Story', :status => :committed)
      helper.status_badge(story).should have_selector('span.statusBadge', :text => 'Committed', :style => "background-color: #080;")
    end

    it "should display an amber badge for ready stories" do
      story = stub('Story', :status => :ready)
      helper.status_badge(story).should have_selector('span.statusBadge', :text => 'Ready', :style => "background-color: #E0981B;")
    end

    it "should display a red badge for open stories" do
      story = stub('Story', :status => :open)
      helper.status_badge(story).should have_selector('span.statusBadge', :text => 'Open', :style => "background-color: #800;")
    end

    it "should display a grey badge for rejected stories" do
      story = stub('Story', :status => :rejected)
      helper.status_badge(story).should have_selector('span.statusBadge', :text => 'Rejected', :style => "background-color: #888;")
    end

    it "should display a green badge for finished tasks" do
      task = stub('Task', :status => :finished)
      helper.status_badge(task).should have_selector('span.statusBadge', :text => 'Finished', :style => "background-color: #008;")
    end

    it "should display an amber badge for in_progress tasks" do
      task = stub('Task', :status => :in_progress)
      helper.status_badge(task).should have_selector('span.statusBadge', :text => 'In progress', :style => "background-color: #E0918B;")
    end

    it "should display a red badge for not_started tasks" do
      task = stub('Task', :status => :not_started)
      helper.status_badge(task).should have_selector('span.statusBadge', :text => 'Not started', :style => "background-color: #800;")
    end
  end

  context "assignee badge" do
    it "should show 'Unassigned' for a unassigned tasks" do
      task = stub('Task', :assignee_name => nil)
      helper.assignee_badge(task).should have_selector('span.assigneeBadge', :text => 'Unassigned')
    end
    
    it "should show assignee name for a assigned tasks" do
      task = stub('Task', :assignee_name => 'Fred')
      helper.assignee_badge(task).should have_selector('span.assigneeBadge', :text => 'Fred')
    end
  end

  context "estimate badge" do
    it "should show the estimate for a story" do
      story = stub('Story', :class => Story, :estimate => 12)
      helper.estimate_badge(story).should have_selector('span.priorityBadge', :text => '12')
    end

    it "should show the estimate for a task" do
      task = stub('Task', :class => Task, :estimate => 8, :remaining => 4)
      helper.estimate_badge(task).should have_selector('span.priorityBadge', :text => '4/8')
    end
  end
end
