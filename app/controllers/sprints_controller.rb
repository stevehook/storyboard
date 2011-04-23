class SprintsController < ApplicationController
  before_filter :set_tab

  def set_tab
    user_session.current_tab = :sprints
  end

  # GET /sprints/new
  # GET /sprints/new.xml
  def new
    @release = Release.find(params[:parent])
    @sprint = Sprint.new 
    @release.create_sprint(@sprint)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sprint }
    end
  end
  
  # POST /sprints
  # POST /sprints.xml
  def create
    @sprint = Sprint.new(params[:sprint])
    @release = Release.find(@sprint.release_id)
    @release.create_sprint(@sprint)

    respond_to do |format|
      if @sprint.save
        format.html { redirect_to(@release, :notice => 'Sprint was successfully created.') }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /sprints/1
  # GET /sprints/1.xml
  def show
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/1/taskboard
  def taskboard
    user_session.current_tab = :tasks
    @sprint = Sprint.find(params[:id])

    respond_to do |format|
      format.html # taskboard.html.haml
      format.xml  { render :xml => @sprint }
    end
  end
end
