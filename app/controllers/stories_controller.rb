class StoriesController < ApplicationController
  load_and_authorize_resource
  before_filter :set_tab
  before_filter :set_current_user

  def set_tab
    user_session.current_tab = :backlog
  end

  # GET /stories
  # GET /stories.xml
  def index
    @story_filter = params[:story_filter] ? StoryFilter.new(params[:story_filter]) : StoryFilter.new
    @story_filter.page = params[:page]
    @stories = Story.product_backlog(user_session.current_project_id, @story_filter)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # POST /stories/filter
  def filter
    @story_filter = StoryFilter.new(params[:story_filter])
    filter_params = @story_filter.attributes
    redirect_to stories_path({:story_filter => filter_params})
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/new
  # GET /stories/new.xml
  def new
    @story = Story.new(:project_id => user_session.current_project_id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories
  # POST /stories.xml
  def create
    respond_to do |format|
      if @story.update_sprint_and_save
        format.html { redirect_to(@story, :notice => 'Story was successfully created.') }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # POST /stories/:id/commit?sprint_id=:sprint_id
  def commit
    @story.commit(params[:sprint_id])
    @stories = @story.sprint.stories
    @points_count = @story.sprint.points_count
    render :layout => false, :template => 'stories/commit.html.haml'
  end
  
  # POST /stories/:id/uncommit
  def uncommit
    sprint = @story.sprint
    @story.uncommit
    @stories = Story.product_backlog(user_session.current_project_id)
    @points_count = sprint.points_count
    render :layout => false, :template => 'stories/uncommit.html.haml'
  end
  
  # POST /stories/1/reprioritise?priority=1
  def reprioritise
    @story.reprioritise(params[:priority].to_i)
    @stories = Story.product_backlog(user_session.current_project_id)
    render :layout => false, :template => 'stories/reprioritise.html.haml'
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    respond_to do |format|
      if @story.update_sprint_and_save(params[:story])
        format.html { redirect_to(@story, :notice => 'Story was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(stories_url) }
      format.xml  { head :ok }
    end
  end
end
