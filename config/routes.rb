Storyboard::Application.routes.draw do
  get 'sessions/logout' => 'sessions#destroy', :as => 'logout'
  get 'sessions/login' => 'sessions#new', :as => 'login'
  get 'sessions/preferences' => 'sessions#preferences', :as => 'preferences'
  get 'sessions/help' => 'sessions#help', :as => 'help'
  get 'sprints/:id/planning' => 'sprints#planning', :as => 'sprint_planning'
  get 'sprints/current_sprint' => 'sprints#current_sprint', :as => 'current_sprint'
  get 'sprints/current_sprint_tasks' => 'sprints#current_sprint_tasks', :as => 'current_sprint_tasks'
  get 'select/:id' => 'sessions#select', :as => 'select'
  get 'projects/select' => 'projects#select', :as => 'project_select'
  post 'stories/filter' => 'stories#filter', :as => 'filter_stories'
  resources :sessions

  resources :teams

  resources :stories do
    resources :tasks
    member do
      post 'reprioritise'
    end
  end

  resources :projects do
    resources :releases
  end
  resources :releases do
    resources :sprints
  end
  resources :sprints
  resources :releases
  resources :users

  get "say/hello"

  get "say/goodbye"

  match 'sprints/:id/taskboard' => 'sprints#taskboard', :as => :taskboard
  match 'stories/:story_id/tasks/:id/update_status' => 'tasks#update_status'

  root :to => "stories#index"
end
