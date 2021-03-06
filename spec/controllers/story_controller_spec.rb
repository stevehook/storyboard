require 'spec_helper'

describe StoriesController do
  context "When logged in" do
    before(:each) do
      # TODO: Setup current_user so that authorisation rules pass
      @new_story_attributes = { :title => 'test title', :description => 'test description', :estimate => 2 }
      controller.stub(:current_user).and_return(User.new)
    end

    describe "GET index" do
      before(:each) do
        get :index
      end

      it "should succeed and set stories to a non-nil value" do
        response.should be_success
        assigns[:stories].should_not be_nil
      end
    end

    describe "GET new" do
      it "should succeed and set story to a non-nil value" do
        get :new
        response.should be_success
        assigns[:story].should_not be_nil
      end
    end

    describe "POST create" do
      it "should succeed and create a new story" do 
        original_count = Story.count
        post :create, :story => @new_story_attributes
        response.should be_redirect
        (original_count + 1).should == Story.count
        # TODO: Assert redirect location
      end
    end

    describe "GET show" do
      before(:each) do
        @story = Story.new
        Story.stub(:find).and_return(@story)
      end

      it "should succeed and show a story" do
        get :show, :id => @story.id
        response.should be_success
        assigns[:story].should_not be_nil
      end
    end

    describe "GET edit" do
      before(:each) do
        @story = Story.new
        Story.stub(:find).and_return(@story)
      end

      it "should succeed and show a story" do
        get :edit, :id => @story.id
        response.should be_success
        assigns[:story].should_not be_nil
      end
    end
  end

  context "When NOT logged in" do
    before(:each) do
      controller.stub(:current_user).and_return(nil)
    end

    describe "GET index" do
      before(:each) do
        get :index
      end

      it "should redirect to logon page" do
        response.should be_redirect
        flash.should_not be_empty
      end
    end

    describe "GET edit" do
      before(:each) do
        @story = Story.new
        Story.stub(:find).and_return(@story)
      end

      it "should redirect" do
        get :edit, :id => @story.id
        response.should be_redirect
        flash.should_not be_empty
      end
    end
  end

  # TODO: Need to work out how to do fixtures/mock the database with rspec to complete the remaining tests

  # it "should update story" do
  #   put :update, :id => @story.to_param, :story => @new_story_attributes
  #   assert_redirected_to story_path(assigns(:story))
  # end
  # 
  # it "should destroy story" do
  #   assert_difference('Story.count', -1) do
  #     delete :destroy, :id => @story.to_param
  #   end
  # 
  #   assert_redirected_to stories_path
  # end
end
