require 'spec_helper'

describe "tasks/show.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :title => "",
      :description => "",
      :estimate => "",
      :remaining => 1
    ))
  end

  # it "renders attributes in <p>" do
  #   render
  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   rendered.should match(//)
  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   rendered.should match(//)
  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   rendered.should match(//)
  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   rendered.should match(/1/)
  # end
end
