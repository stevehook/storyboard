class SprintsController < ApplicationController

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.find(params[:parent])
    @sprint = Sprint.new 
    Rails.logger.info 'Adding sprint...'
    @project.create_sprint(@sprint)
    Rails.logger.info 'Added sprint.'

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sprint }
    end
  end
  
  # POST /projects
  # POST /projects.xml
  def create
    @sprint = Sprint.new(params[:sprint])
    @project = Project.find(@sprint.project_id)
    @project.create_sprint(@sprint)

    respond_to do |format|
      if @sprint.save
        format.html { redirect_to(@project, :notice => 'Sprint was successfully created.') }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end
end
