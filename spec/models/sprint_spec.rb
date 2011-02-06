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
end
