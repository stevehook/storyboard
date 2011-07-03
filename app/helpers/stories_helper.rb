module StoriesHelper
  def priority_badge(story)
    "<span class='priorityBadge'>#{story.priority}</span>".html_safe
  end
  
  def sprint_badge(story)
    story.sprint.nil? ? "" : "<span class='priorityBadge'>sprint #{story.sprint.title}</span>".html_safe
  end

  def points_badge(story)
    "<span class='priorityBadge'>#{story.estimate} pts</span>".html_safe
  end
end
