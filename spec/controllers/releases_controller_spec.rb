require 'spec_helper'

describe ReleasesController do
  describe "GET index" do 
    let(:release) { Release.new(:title => 'Mock Release 1') }
    
    it "assigns all releases as @releases" do
      Release.stub(:all) { [release] } 
      get :index 
      assigns(:releases).should eq([release])
    end 
  end
end
