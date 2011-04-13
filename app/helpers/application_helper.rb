module ApplicationHelper
  def page_title
    # TODO: Use this in the head title - doesn't seem to work properly...
    (@content_for_title + " &mdash; " if @content_for_title).to_s + 'Storyboard'
  end

  def page_heading(text)
    content_for(:title, text)
  end

  def sub_heading(text)
    "<div class='subHeading'>#{text}</div>".html_safe
  end

  def status_badge(model)
    colour = case model.status.to_sym
      when :open then '#800'
      when :not_started then '#800'
      when :ready then '#E0981B'
      when :in_progress then '#E0981B'
      when :committed then '#080'
      when :done then '#008'
      when :rejected then '#888'
    end
    "<span class='statusBadge' style='background-color: #{colour};'>#{model.status.to_s.humanize}</span>".html_safe
  end

  def assignee_badge(model)
    "<span class='assigneeBadge'>#{model.assignee_name}</span>".html_safe
  end

  def estimate_badge(model)
    case model.class
    when Story: "<span class='priorityBadge'>#{model.estimate}</span>".html_safe
    when Task: "<span class='priorityBadge'>#{model.remaining}/#{model.estimate}</span>".html_safe
    else ''
    end
  end

  def login_or_logout_link
   if session['user_id']
     link_to 'Logout', logout_path
   else
     link_to 'Login', login_path
   end
  end
end
