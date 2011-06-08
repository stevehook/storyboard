require 'spec_helper'
require 'requests/request_spec_helpers'

describe 'Projects', :type => :request do
  include RequestSpecHelpers

  describe 'GET /projects' do
    before(:each) do
      project = Project.create(:title => 'Project X')
      Project.create(:title => 'Project Y')
      Project.create(:title => 'Project Z')
      release = Release.create(:title => 'Version 1.0', :order => 1, :start_date => Time.utc(2010, 'feb', 12), :project => project)
      logon(project, release)
      visit projects_path
    end

    it 'shows the list of projects' do
      page.should have_content('Project List')
    end

    it 'shows projects X, Y and Z' do
      page.should have_content('Project X')
      page.should have_content('Project Y')
      page.should have_content('Project Z')
    end

    it "shows an 'Add Project' link" do
      link = find_link('addProject')
      link.click
      page.should have_content('New Project')
    end
  end

  describe 'GET /projects/:id' do
    before(:each) do
      @project = Project.create(:title => 'Project X')
      Project.create(:title => 'Project Y')
      Project.create(:title => 'Project Z')
      Release.create(:title => 'Version 1.0', :order => 1, :start_date => Time.utc(2010, 'feb', 12), :project => @project)
      @release = Release.create(:title => 'Version 2.0', :order => 2, :start_date => Time.utc(2011, 'jan', 3), :project => @project)
      Release.create(:title => 'Version 3.0', :order => 3, :start_date => Time.utc(2011, 'oct', 4), :project => @project)
      logon(@project, @release)
      visit project_path(@project)
    end

    it 'shows the project' do
      page.status_code.should == 200
      page.should have_content('Project - Project X')
    end

    it 'shows the releases' do
      page.status_code.should == 200
      page.should have_content('Version 1.0')
      page.should have_content('Version 2.0')
      page.should have_content('Version 3.0')
      page.should_not have_content('Version 4.0')
    end

    it 'clicking on a release link should open the release#show' do
      page.status_code.should == 200
      link = find_link('Version 2.0')
      link.click
      page.should have_content('Release - Version 2.0')
    end

    it 'clicking on the New Release link should open a new release form' do
      page.status_code.should == 200
      link = find_link('addRelease')
      link.click
      page.should have_content('New Release')
    end
  end
end
