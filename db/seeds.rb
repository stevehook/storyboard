Story.delete_all

Story.create(:title => 'Story list should look good',
  :description => 'Stories should be displayed in a styled table',
  :estimate => 1  
)
Story.create(:title => 'Story form should look good',
  :description => 'Individual stories should be displayed in a styled form with appropriate controls. We need a date picker.',
  :estimate => 2
)
Story.create(:title => 'Each page needs a consistent header and menu',
  :description => 'We need to implement a layout that contains a search box, branding logo and menu',
  :estimate => 3
)
Story.create(:title => 'We need to set up controller tests',
  :description => 'Just get these started',
  :estimate => 1  
)
Story.create(:title => 'We need to set up model tests',
  :description => 'Just get these started',
  :estimate => 1  
)
