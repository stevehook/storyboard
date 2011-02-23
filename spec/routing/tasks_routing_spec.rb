require "spec_helper"

describe TasksController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/stories/1/tasks" }.should route_to(:controller => "tasks", :action => "index", :story_id => "1")
    end

    it "recognizes and generates #new" do
      { :get => "/stories/1/tasks/new" }.should route_to(:controller => "tasks", :action => "new", :story_id => "1")
    end

    it "recognizes and generates #show" do
      { :get => "/stories/1/tasks/1" }.should route_to(:controller => "tasks", :action => "show", :id => "1", :story_id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/stories/1/tasks/1/edit" }.should route_to(:controller => "tasks", :action => "edit", :id => "1", :story_id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/stories/1/tasks" }.should route_to(:controller => "tasks", :action => "create", :story_id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/stories/1/tasks/1" }.should route_to(:controller => "tasks", :action => "update", :id => "1", :story_id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/stories/1/tasks/1" }.should route_to(:controller => "tasks", :action => "destroy", :id => "1", :story_id => "1")
    end

  end
end
