Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  get 'assign', to: 'grader_assignment#index'
  get 'search', to: 'search#index'
  get 'my_applications', to: 'my_grader_applications#index'
  get 'my_sections', to: 'grader_sections#get_grader_sections'
  get 'all_sections', to: 'grader_sections#get_all_sections'
  get 'apply', to: 'grader_application#index'
  post 'users/sign_up', to: 'users_controller#create'
  post 'apply', to: 'grader_application#edit'
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
