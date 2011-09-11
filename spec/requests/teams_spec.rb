require 'spec_helper'

describe 'Teams', :type => :request do
  describe 'GET /teams' do
    before(:each) do
      # TODO: Need to convert this to use Factory Girl...
      team = Team.create(:name => 'Team 1')
      User.create!(:name => 'Bob', :email => 'bob@nocompany.com', :password => 'secret', :password_confirmation => 'secret')
      User.create!(:name => 'Alice', :email => 'alice@nocompany.com', :password => 'secret', :password_confirmation => 'secret')
      User.create!(:name => 'Derek', :email => 'derek@nocompany.com', :password => 'secret', :password_confirmation => 'secret', :team_id => team.id)
      visit teams_path
    end

    it 'shows the list of teams' do
      page.should have_content('Team List')
    end

    it 'shows Team 1' do
      page.should have_content('Team 1')
    end

    it 'does not show Team 2' do
      page.should_not have_content('Team 2')
    end

    it 'shows Bob and Alice in the Unallocated Users section' do
      unallocate_users_div = page.find('#unallocatedUsersPanel')
      unallocate_users_div.should_not be_nil
      unallocate_users_div.should have_content('Bob')
      unallocate_users_div.should have_content('Alice')
      unallocate_users_div.should_not have_content('Derek')
    end

    it 'shows Derek in the Team 1 panel' do
      teams_div = page.find('#teamsPanel')
      teams_div.should_not be_nil
      teams_div.should_not have_content('Bob')
      teams_div.should_not have_content('Alice')
      teams_div.should have_content('Derek')
    end
  end

  describe 'POST /teams' do
    before(:each) do
      visit new_team_path
    end

    it 'creates a new team' do
      fill_in 'team_name', :with => 'Team 2'
      click_button 'team_submit'
      new_team = Team.where(:name => 'Team 2').first
      new_team.should_not be_nil
      new_team.name.should == 'Team 2'
    end
  end

  describe 'PUT /teams' do
    before(:each) do
      @new_team = Team.create(:name => 'Team 3')
      visit team_path(@new_team)
    end

    it 'shows the correct form title' do
      page.should have_content('Team - Team 3')
    end

    it 'updates the form name' do
      fill_in 'team_name', :with => 'Team 4'
      click_button 'team_submit'
      team = Team.find(@new_team.id)
      team.should_not be_nil
      team.name.should == 'Team 4'
    end
  end

  describe 'DELETE /teams' do
    before(:each) do
      @new_team = Team.create(:name => 'Team 3')
    end

    it 'deletes the team' do
      delete team_path(@new_team.id)
      team = Team.where(:id => @new_team.id).first
      team.should be_nil
    end
  end
end
