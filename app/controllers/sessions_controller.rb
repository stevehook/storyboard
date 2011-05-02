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

  def select
    release = Release.find(params[:id])
    if release
      # TODO: Set the session
      redirect_to release_path(release)
    else
      flash.now.alert = "Invalid release"
      redirect_to projects_path
    end
  end
end

