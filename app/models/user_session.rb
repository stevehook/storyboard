class UserSession
  def initialize(session)
    @session = session
  end

  def logged_in?
    @session[:user_id]
  end
end
