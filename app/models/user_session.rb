class UserSession
  def initialize(session)
    @session = session
  end

  def logged_in?
    @session[:user_id]
  end

  def login(user)
    @session[:user_id] = user.id
    set_current_project(user)
  end

  def set_current_project(user)
    self.current_project = user.project
    self.current_release = user.release
  end

  def logout
    @session[:user_id] = nil
    @session[:project_title] = nil
    @session[:project_id] = nil
    @session[:release_title] = nil
    @session[:release_id] = nil
    @session[:tab] = :projects
  end

  def current_project_title
    @session[:project_title] || 'Storyboard'
  end

  def current_release_title
    @session[:release_title]
  end

  def current_project_id
    @session[:project_id]
  end

  def current_release_id
    @session[:release_id]
  end

  def current_project=(project)
    @session[:project_id] = project.nil? ? nil : project.id
    @session[:project_title] = project.nil? ? nil : project.title
  end

  def current_release=(release)
    @session[:release_id] = release.nil? ? nil : release.id
    @session[:release_title] = release.nil? ? nil : release.title
  end

  def current_tab
    @session[:tab]
  end

  def current_tab=(tab)
    @session[:tab] = tab
  end

  def current_user
    user_id = @session[:user_id]
    user_id.nil? ? nil : User.find(user_id)
  end
end
