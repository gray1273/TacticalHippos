Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  get 'assign', to: 'grader_assignment#index'
  get 'search', to: 'search#index'
  get 'my_applications', to: 'my_grader_applications#index'
  get 'apply', to: 'grader_application#index'
  post 'apply', to: 'grader_application#edit'
  root to: 'search#index'
  #devise_scope :user do
  #  root :to => "devise/sessions#new"
  #  get 
  #end
end
