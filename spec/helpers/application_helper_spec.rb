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

  context "" do
    
  end
end
