require 'spec_helper'

describe 'Teams', :type => :request do
  describe 'GET /teams' do
    before(:each) do
      Team.create(:name => 'Team 1')
    end

    it 'shows the list of teams' do
      visit teams_path
      page.should have_content('Team List')
    end

    it 'shows Team 1' do
      visit teams_path
      page.should have_content('Team 1')
    end

    it 'does not show Team 2' do
      visit teams_path
      page.should_not have_content('Team 2')
    end
  end
end
