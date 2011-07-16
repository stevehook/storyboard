module StoriesHelper
  def priority_badge(story)
    content_tag :span, story.priority, { :class => 'priorityBadge' }
  end
  
  def sprint_badge(story)
    story.sprint.nil? ? "" : content_tag(:span, "sprint #{story.sprint.title}", { :class => 'priorityBadge' })
  end

  def points_badge(story)
    content_tag :span, "#{story.estimate} pts", { :class => 'priorityBadge' }
  end
end
