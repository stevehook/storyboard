require 'spec_helper'

describe Project do
  let(:project) { Project.create(:title => 'test project') }
   
  it "should be valid if mandatory attributes are specified" do
    project.valid?.should be_true
    project.errors[:title].none?.should be_true
  end
end
