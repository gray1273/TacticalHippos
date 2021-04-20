Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  get 'assign', to: 'grader_assignment#index'
  get 'search', to: 'search#index'
  root to: 'search#index'
  #devise_scope :user do
  #  root :to => "devise/sessions#new"
  #  get 
  #end
end
