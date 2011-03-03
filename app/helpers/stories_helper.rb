module StoriesHelper
  def status_badge(story)
    colour = case story.status.to_sym
      when :open then '#800'
      when :ready then '#E0981B'
      when :committed then '#080'
      when :done then '#008'
      when :rejected then '#888'
    end
    "<span class='statusBadge' style='background-color: #{colour};'>#{story.status}</span>"
  end
  
  def priority_badge(story)
    "<span class='priorityBadge'>#{story.priority}</span>"
  end
end
