class UsersController < ApplicationController
  before_filter :set_tab
  respond_to :html

  def set_tab
    user_session.current_tab = :admin
  end

  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    respond_with @users
  end
  
  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    render 'edit'
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    respond_with @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    respond_with @user
  end

  # POST /users
  # POST /users.xml
  def create
    if params[:commit]
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          format.html { redirect_to(teams_url, :notice => 'User was successfully created.') }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(teams_url)
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    if params[:commit]
      @user = User.find(params[:id])
      logger.info params['user[image]']
      logger.info @user.image

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to(teams_url, :notice => 'User was successfully created.') }
          format.xml  { head :ok }
          format.json  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
          format.json  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(teams_url)
    end
  end
end
