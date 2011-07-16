require 'spec_helper'

describe ApplicationHelper do
   it "should display the correct title" do
     helper.page_title.should == 'Storyboard'
   end
end
