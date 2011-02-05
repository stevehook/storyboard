class SprintsController < ApplicationController

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.find(params[:project_id])
    @sprint = Sprint.new :project => @project

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end
  
  # POST /projects
  # POST /projects.xml
  def create
    @sprint = Sprint.new(params[:sprint])

    respond_to do |format|
      if @sprint.save
        format.html { redirect_to(@sprint, :notice => 'Sprint was successfully created.') }
        format.xml  { render :xml => @sprint, :status => :created, :location => @sprint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sprint.errors, :status => :unprocessable_entity }
      end
    end
  end
end
