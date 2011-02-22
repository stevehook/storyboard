require 'spec_helper'

describe "tasks/new.html.erb" do
  before(:each) do
    assign(:task, stub_model(Task,
      :title => "",
      :description => "",
      :estimate => "",
      :remaining => 1
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path, :method => "post" do
      assert_select "input#task_title", :name => "task[title]"
      assert_select "input#task_description", :name => "task[description]"
      assert_select "input#task_estimate", :name => "task[estimate]"
      assert_select "input#task_remaining", :name => "task[remaining]"
    end
  end
end
