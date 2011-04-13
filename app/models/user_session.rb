class UserSession
  def initialize(session)
    @session = session
  end

  def logged_in?
    @session[:user_id]
  end

  def login(user)
    @session[:user_id] = user.id
  end

  def logout
    @session[:user_id] = nil
  end
end
