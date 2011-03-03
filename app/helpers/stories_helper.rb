module StoriesHelper
  def status_badge(story)
    colour = case story.status.to_sym
      when :open then '#800'
      when :ready then '#E0981B'
      when :committed then '#080'
      when :done then '#008'
      when :rejected then '#888'
    end
    "<span class='statusBadge' style='background-color: #{colour};'>#{story.status}</span>".html_safe
  end
  
  def priority_badge(story)
    "<span class='priorityBadge'>#{story.priority}</span>".html_safe
  end
  
  def sprint_badge(story)
    story.sprint.nil? ? "" : "<span class='priorityBadge'>sprint #{story.sprint.title}</span>".html_safe
  end
end
