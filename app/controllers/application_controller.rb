class ApplicationController < ActionController::Base
  def set_current_user
    User.current = current_user
  end

  protect_from_forgery

  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session

  # required by cancan
  def current_user
    user_session.current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You are not allowed to do that."
    redirect_to login_url if !current_user
  end
end
