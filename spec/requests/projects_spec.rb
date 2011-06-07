require 'spec_helper'

describe 'Projects', :type => :request do
  describe 'GET /projects' do
    before(:each) do
      project = Project.create(:title => 'Project X')
      Project.create(:title => 'Project Y')
      Project.create(:title => 'Project Z')

      # We need to 'grant' permissions UserSession#current_user in order to bypass authorisation rules
      # (Note: this will only work with the RackTest driver)
      release = Release.create(:title => 'Version 1.0', :order => 1, :start_date => Time.utc(2010, 'feb', 12), :project => project)
      user = User.create!(:name => 'Bob', :email => 'bob@nocompany.com', :password => 'secret', :release => release, :project => project)
      session = UserSession.new({})
      session.login(user)
      UserSession.stub(:new).and_return(session)

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
      visit project_path(@project)
    end

    it 'shows the project' do
      page.status_code.should == 200
      page.should have_content('Project - Project X')
    end
  end
end
