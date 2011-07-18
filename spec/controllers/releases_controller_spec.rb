require 'spec_helper'

describe ReleasesController do
  describe "GET index" do 
    before(:each) do
      controller.stub(:current_user).and_return(User.new)
    end
    let(:release) { Release.new(:title => 'Mock Release 1') }
    
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should render the index view" do
      get :index
      response.should render_template(:index)
    end
    
    it "assigns all releases as @releases" do
      Release.stub(:all) { [release] }
      get :index
      assigns(:releases).should == [release]
    end
  end
end
