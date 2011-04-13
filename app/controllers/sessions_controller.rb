class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      user_session.login(user)
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid user name or password"
      render "new"
    end
  end

  def destroy
    user_session.logout
    redirect_to root_url, :notice => "Logged out!"
  end
end

