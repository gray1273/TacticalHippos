Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  get 'assign', to: 'grader_assignment#index'
  get 'search', to: 'search#index'
  get 'view', to: 'view_sections#index'
  get 'all_sections', to: 'grader_sections#get_all_sections'
  get 'apply', to: 'grader_application#index'
  post 'users/sign_up', to: 'users_controller#create'
  post 'apply', to: 'grader_application#edit'
  post 'create', to: 'grader_sections#create'
  post 'create_many', to: 'grader_sections#create_many'
  get '/grader_application/edit', to: 'grader_application#edit'
  get 'recommendations', to: 'recommendations#index'
  get 'recommendations/show', to: 'recommendations#show'
  get 'recommendations/new', to: 'recommendations#new'
  post 'recommendations', to: 'recommendations#create'
  get 'recommendations/destroy', to: 'recommendations#destroy'
  root to: 'search#index'
  #devise_scope :user do
  #  root :to => "devise/sessions#new"
  #  get
  #end
end
