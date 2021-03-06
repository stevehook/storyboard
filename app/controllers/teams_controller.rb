class TeamsController < ApplicationController
  before_filter :set_tab

  def set_tab
    user_session.current_tab = :admin
  end

  # GET /teams
  # GET /teams.xml
  def index
    @teams = Team.all
    @unallocated_users = User.unallocated_users

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.xml
  def show
    @team = Team.find(params[:id])
    render 'edit'
  end

  # GET /teams/new
  # GET /teams/new.xml
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.xml
  def create
    if params[:commit]
      @team = Team.new(params[:team])

      respond_to do |format|
        if @team.save
          format.html { redirect_to(teams_url, :notice => 'Team was successfully created.') }
          format.xml  { render :xml => @team, :status => :created, :location => @team }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(teams_url)
    end
  end

  # PUT /teams/1
  # PUT /teams/1.xml
  def update
    if params[:commit]
      @team = Team.find(params[:id])

      respond_to do |format|
        if @team.update_attributes(params[:team])
          format.html { redirect_to(teams_url, :notice => 'Team was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(teams_url)
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.xml
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(teams_url) }
      format.xml  { head :ok }
    end
  end
end
