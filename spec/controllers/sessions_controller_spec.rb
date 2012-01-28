require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should be_redirect
      redirect_to root_url
    end
  end

  describe "GET 'select'" do
    before(:each) do
      user = stub()
      current_session = stub()
      current_session.stub(:current_user).and_return(user)
      current_session.stub(:set_current_project)
      controller.stub(:user_session).and_return(current_session)
      project = Project.new(:id => 1)
      release = Release.new(:id => 1)
      user.should_receive(:current_release=)
      user.should_receive(:current_project=)
      user.should_receive(:save!)
      Release.stub(:find).and_return(release)
      release.stub(:project).and_return(project)
    end
    
    it "save the user.project and user.release properties" do
      get 'select', :id => 1
      response.should be_redirect
    end
  end
end
