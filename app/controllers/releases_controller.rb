class ReleasesController < ApplicationController
  load_and_authorize_resource

  before_filter :set_tab

  def set_tab
    user_session.current_tab = :releases
  end

  # GET /releases
  # GET /releases.xml
  def index
    @releases = Release.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @releases }
    end
  end

  # GET /releases/1
  # GET /releases/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @release }
    end
  end

  # GET /releases/new
  # GET /releases/new.xml
  def new
    @project = Project.find(params[:parent])
    @release = Release.new
    @project.create_release(@release)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @release }
    end
  end

  # GET /releases/1/edit
  def edit
    @project = @release.project
  end

  # POST /releases
  # POST /releases.xml
  def create
    @release = Release.new(params[:release])
    @project = Project.find(@release.project_id)
    @project.create_release(@release)

    respond_to do |format|
      if @release.save
        format.html { redirect_to(@release, :notice => 'Release was successfully created.') }
        format.xml  { render :xml => @release, :status => :created, :location => @release }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /releases/1
  # PUT /releases/1.xml
  def update
    respond_to do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to(@release, :notice => 'Release was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.xml
  def destroy
    @release.destroy

    respond_to do |format|
      format.html { redirect_to(releases_url) }
      format.xml  { head :ok }
    end
  end
end
