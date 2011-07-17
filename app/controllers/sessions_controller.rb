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
    redirect_to login_url, :notice => "Logged out!"
  end

  def select
    release = Release.find(params[:id])
    if release
      user = user_session.current_user
      if user
        user.project = release.project
        user.release = release
        user.save!
        user_session.set_current_project(user)
      end
      redirect_to release_path(release.id)
    else
      flash.now.alert = "Invalid release"
      redirect_to project_select_path
    end
  end

  def help
  end

  def preferences
  end
end

