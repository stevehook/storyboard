class SprintsController < ApplicationController
  load_and_authorize_resource

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
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sprint }
    end
  end

  # GET /sprints/1/planning
  def planning
    @story_filter = params[:story_filter] ? StoryFilter.new(params[:story_filter]) : StoryFilter.new
    @story_filter.page = params[:page]
    @stories = Story.product_backlog(user_session.current_project_id, @story_filter)
    respond_to do |format|
      format.html
      format.js { render :partial => 'planning_backlog' }
    end
  end

  def current_sprint
    if user_session.current_release_id
      current_release = Release.find(user_session.current_release_id)
      sprint = current_release.current_sprint || current_release.first_sprint
      return redirect_to(sprint) if sprint
    end
    throw 'No current sprint'
  end

  def current_sprint_tasks
    if user_session.current_release_id
      current_release = Release.find(user_session.current_release_id)
      sprint = current_release.current_sprint || current_release.first_sprint
      return redirect_to(:action => :taskboard, :id => sprint.id) if sprint
    end
    throw 'No current sprint'
  end

  # POST /sprints/1/finish
  def finish
    @sprint.finish
    redirect_to @sprint.release, :notice => 'Sprint was successfully finished'
  end

  # GET /sprints/1/edit
  def edit
    @release = @sprint.release
  end

  # PUT /sprints/1
  # PUT /sprints/1.xml
  def update
    respond_to do |format|
      if @sprint.update_attributes(params[:sprint])
        format.html { redirect_to(@sprint.release, :notice => 'Sprint was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @release.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /sprints/1/taskboard
  def taskboard
    user_session.current_tab = :tasks
    respond_to do |format|
      format.html # taskboard.html.haml
      format.xml  { render :xml => @sprint }
    end
  end

  def destroy
    release = @sprint.release
    @sprint.destroy

    respond_to do |format|
      format.html { redirect_to(release) }
      format.xml  { head :ok }
    end
  end
end
