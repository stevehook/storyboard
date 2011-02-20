Story.delete_all
Sprint.delete_all
Release.delete_all
Project.delete_all

project_x = Project.create(:title => 'Project X')

release10 = Release.create(:title => 'Version 1.0', :order => 1, :start_date => Time.utc(2010, 'feb', 12), :project => project_x)
release11 = Release.create(:title => 'Version 1.1', :order => 2, :start_date => Time.utc(2010, 'jun', 25), :project => project_x)
release12 = Release.create(:title => 'Version 1.2', :order => 3, :start_date => Time.utc(2010, 'sep', 2), :project => project_x)
release20 = Release.create(:title => 'Version 2.0', :order => 4, :start_date => Time.utc(2011, 'jan', 3), :project => project_x)
release30 = Release.create(:title => 'Version 3.0', :order => 5, :start_date => Time.utc(2011, 'oct', 4), :project => project_x)

sprint1 = Sprint.create(:release => release20, :title => '1', :order => 1, :start_date => Time.utc(2011, 'jan', 3), :end_date => Time.utc(2011, 'jan', 15))
sprint2 = Sprint.create(:release => release20, :title => '2', :order => 2, :start_date => Time.utc(2011, 'jan', 17), :end_date => Time.utc(2011, 'jan', 28))
sprint3 = Sprint.create(:release => release20, :title => '3', :order => 3, :start_date => Time.utc(2011, 'jan', 31), :end_date => Time.utc(2011, 'feb', 11))
sprint4 = Sprint.create(:release => release20, :title => '4', :order => 4, :start_date => Time.utc(2011, 'feb', 14), :end_date => Time.utc(2011, 'feb', 25))
sprint5 = Sprint.create(:release => release20, :title => '5', :order => 5, :start_date => Time.utc(2011, 'feb', 28), :end_date => Time.utc(2011, 'mar', 11))
sprint6 = Sprint.create(:release => release20, :title => '6', :order => 6, :start_date => Time.utc(2011, 'mar', 14), :end_date => Time.utc(2011, 'mar', 25))
sprint7 = Sprint.create(:release => release20, :title => '7', :order => 7, :start_date => Time.utc(2011, 'mar', 28), :end_date => Time.utc(2011, 'apr', 8))
sprint8 = Sprint.create(:release => release20, :title => '8', :order => 8, :start_date => Time.utc(2011, 'apr', 11), :end_date => Time.utc(2011, 'apr', 22))
sprint9 = Sprint.create(:release => release20, :title => '9', :order => 9, :start_date => Time.utc(2011, 'apr', 25), :end_date => Time.utc(2011, 'may', 6))

Story.create(:title => 'Story list should look good',
  :description => 'Stories should be displayed in a styled table',
  :estimate => 1,
  :status => :done,
  :project => project_x,
  :release => release20,
  :sprint => sprint1
)
Story.create(:title => 'Home page should display the project backlog',
  :description => '/ URL should display backlog',
  :estimate => 1,
  :status => :done,
  :project => project_x,
  :release => release20,
  :sprint => sprint1
)
Story.create(:title => 'User can open a story form from the story list',
  :description => 'Left clicking anywhere in the story row should navigate to that list',
  :estimate => 1,
  :status => :done,
  :project => project_x,
  :release => release20,
  :sprint => sprint1
)
Story.create(:title => 'Story form should look good',
  :description => 'Individual stories should be displayed in a styled form with appropriate controls. We need a date picker.',
  :estimate => 2,
  :status => :done,
  :project => project_x,
  :release => release20,
  :sprint => sprint1
)
Story.create(:title => 'User should be able to create new stories',
  :description => 'Individual stories should be displayed in a styled form with appropriate controls. We need a date picker.',
  :estimate => 3,
  :status => :done,
  :project => project_x,
  :release => release20,
  :sprint => sprint1
)
Story.create(:title => 'User should be able to update existing stories',
  :description => 'Individual stories should be displayed in a styled form with appropriate controls. We need a date picker.',
  :estimate => 3,
  :status => :done,
  :project => project_x,
  :release => release20,
  :sprint => sprint1
)
Story.create(:title => 'Each page needs a consistent header and menu',
  :description => 'We need to implement a layout that contains a search box, branding logo and menu',
  :estimate => 5,
  :status => :committed,
  :project => project_x,
  :release => release20,
  :sprint => sprint2
)
Story.create(:title => 'User should be able to pick the current project from the menu bar',
  :description => 'As a user I need to be able to switch between different projects that are managed by the system',
  :estimate => 3,
  :status => :committed,
  :project => project_x,
  :release => release20,
  :sprint => sprint2
)
Story.create(:title => 'Switch release from the menu bar',
  :description => 'As a user I should easily be able to switch between different releases of the selected project',
  :estimate => 3,
  :status => :committed,
  :project => project_x,
  :release => release20,
  :sprint => sprint2
)
Story.create(:title => 'The release drop-down in the menu bar should only display the releases for the selected project',
  :description => '',
  :estimate => 3,
  :status => :committed,
  :project => project_x,
  :release => release20,
  :sprint => sprint2
)
Story.create(:title => 'We need to set up controller tests',
  :description => 'Just get these started',
  :estimate => 1,
  :status => :ready,
  :project => project_x
)
Story.create(:title => 'We need to set up model tests',
  :description => 'Just get these started',
  :estimate => 5,
  :status => :ready,
  :project => project_x
)
Story.create(:title => 'Implement a release dashboard',
  :description => 'Should display the sprints for the given release and the status of each one',
  :estimate => 10,
  :status => :open,
  :project => project_x
)
Story.create(:title => 'Task model',
  :description => 'As a sprint team member I need to be able to create tasks for each story during the sprint planning phase.',
  :estimate => 10,
  :status => :open,
  :project => project_x
)
Story.create(:title => 'Project/Release burndown chart',
  :description => 'As a sprint team member I need to be able to see a burndown chart for the release that I am working on to get an idea of project status.',
  :estimate => 10,
  :status => :open,
  :project => project_x
)
Story.create(:title => 'Sprint burndown chart',
  :description => 'As a sprint team member I need to be able to see a burndown chart for the sprint that I am working on to get an idea of sprint status.',
  :estimate => 10,
  :status => :open,
  :project => project_x
)