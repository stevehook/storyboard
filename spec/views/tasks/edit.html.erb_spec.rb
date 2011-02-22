require 'spec_helper'

describe "tasks/edit.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :title => "",
      :description => "",
      :estimate => "",
      :remaining => 1
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => task_path(@task), :method => "post" do
      assert_select "input#task_title", :name => "task[title]"
      assert_select "input#task_description", :name => "task[description]"
      assert_select "input#task_estimate", :name => "task[estimate]"
      assert_select "input#task_remaining", :name => "task[remaining]"
    end
  end
end
