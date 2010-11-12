Story.delete_all
StoryStatus.delete_all

open_status = StoryStatus.create(:title => 'Open')
StoryStatus.create(:title => 'Closed')
StoryStatus.create(:title => 'In Progress')

Story.create(:title => 'Story list should look good',
  :description => 'Stories should be displayed in a styled table',
  :estimate => 1,
  :status => open_status
)
Story.create(:title => 'Story form should look good',
  :description => 'Individual stories should be displayed in a styled form with appropriate controls. We need a date picker.',
  :estimate => 2,
  :status => open_status
)
Story.create(:title => 'Each page needs a consistent header and menu',
  :description => 'We need to implement a layout that contains a search box, branding logo and menu',
  :estimate => 3,
  :status => open_status
)
Story.create(:title => 'We need to set up controller tests',
  :description => 'Just get these started',
  :estimate => 1,
  :status => open_status
)
Story.create(:title => 'We need to set up model tests',
  :description => 'Just get these started',
  :estimate => 1,
  :status => open_status
)
