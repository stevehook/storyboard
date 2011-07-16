module ApplicationHelper
  def page_title
    # TODO: Use this in the head title - doesn't seem to work properly...
    (@content_for_title + " &mdash; " if @content_for_title).to_s + 'Storyboard'
  end

  def page_heading(text)
    content_for(:title, text)
  end

  def sub_heading(text, id = nil)
    content_tag(:div, text, { :id => id, :class => 'subHeading'})
  end

  def status_badge(model)
    colour = case model.status.to_sym
      when :open then '#800'
      when :not_started then '#800'
      when :ready then '#E0981B'
      when :in_progress then '#E0981B'
      when :committed then '#080'
      when :done then '#008'
      when :finished then '#008'
      when :rejected then '#888'
    end
    content_tag :span, model.status.to_s.humanize, { :class => 'statusBadge', :style => "background-color: #{colour};" }
  end

  def assignee_badge(model)
    content_tag :span, model.assignee_name.nil? ? 'Unassigned' : model.assignee_name, { :class => 'assigneeBadge' }
  end

  def estimate_badge(model)
    case model.class
    when Story 
      content_tag :span, model.estimate, { :class => 'priorityBadge' }
    when Task
      content_tag :span, "#{model.remaining}/#{model.estimate}", { :class => 'priorityBadge' }
    else ''
    end
  end

  def login_or_logout_link
   if user_session.logged_in?
     link_to 'Logout', logout_path
   else
     link_to 'Login', login_path
   end
  end

  def project_header_title
    if user_session.current_release_title.nil? 
      user_session.current_project_title
    else
      "#{ user_session.current_project_title } - #{ user_session.current_release_title }"
    end
  end

  def current_project_path
    project_path(user_session.current_project_id)
  end

  def current_release_path
    release_path(user_session.current_release_id)
  end

  def current_backlog_path
    # TODO: Restrict the set of stories to the current project
    stories_path
  end
end
