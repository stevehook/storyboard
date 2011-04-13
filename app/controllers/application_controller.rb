class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session
end
