require 'spec_helper'

describe "teams/index.html.erb" do
  before(:each) do
    assign(:teams, [
      stub_model(Team,
        :name => "Name"
      ),
      stub_model(Team,
        :name => "Name"
      )
    ])
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "div>span", :text => "Name".to_s, :count => 2
  end
end
