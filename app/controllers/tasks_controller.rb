class TasksController < ApplicationController
  # GET /stories/1/tasks
  # GET /stories/1/tasks.xml
  def index
    story = Story.find(params[:story_id])
    @tasks = story.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /stories/1/tasks/1
  # GET /stories/1/tasks/1.xml
  def show
    story = Story.find(params[:story_id])
    @task = story.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /stories/1/tasks/new
  # GET /stories/1/tasks/new.xml
  def new
    story = Story.find(params[:story_id])
    @task = Task.new(:story => story)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /stories/1/tasks/1/edit
  def edit
    story = Story.find(params[:story_id])
    @task = story.tasks.find(params[:id])
  end

  # POST /stories/1/tasks
  # POST /stories/1/tasks.xml
  def create
    story = Story.find(params[:story_id])
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1/tasks/1
  # PUT /stories/1/tasks/1.xml
  def update
    story = Story.find(params[:story_id])
    @task = story.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1/tasks/1
  # DELETE /stories/1/tasks/1.xml
  def destroy
    story = Story.find(params[:story_id])
    @task = story.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
