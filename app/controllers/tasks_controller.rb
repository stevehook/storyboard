class TasksController < ApplicationController
  load_and_authorize_resource :story
  load_and_authorize_resource :through => :story

  before_filter :set_tab

  def set_tab
    user_session.current_tab = :tasks
  end

  # GET /stories/1/tasks/1
  # GET /stories/1/tasks/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /stories/1/tasks/new
  # GET /stories/1/tasks/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /stories/1/tasks/1/edit
  def edit
  end

  # POST /stories/1/tasks
  # POST /stories/1/tasks.xml
  def create
    if params[:cancel]
      redirect_to(@story) 
    else
      respond_to do |format|
        if @story.save
          format.html { redirect_to(@story, :notice => 'task was successfully created.') }
          format.xml  { render :xml => @task, :status => :created, :location => @task }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /stories/1/tasks/1
  # PUT /stories/1/tasks/1.xml
  def update
    if params[:cancel]
      redirect_to(@story) 
    else
      respond_to do |format|
        if @task.update_attributes(params[:task])
          format.html { redirect_to(@story, :notice => 'Task was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def update_status
    @task.status = params[:status].to_sym
    @task.save
    render :partial => 'sprints/task_panel', :layout => false, :locals => { :task => @task }
  end

  # DELETE /stories/1/tasks/1
  # DELETE /stories/1/tasks/1.xml
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
