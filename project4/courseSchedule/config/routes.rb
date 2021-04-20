Rails.application.routes.draw do
  get 'search', to: 'search#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :user
  devise_scope :user do
    root :to => "devise/sessions#new"
  end
end
