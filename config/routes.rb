Rails.application.routes.draw do
  resources :trips
  resources :users, only: ['index', 'show', 'new', 'create', 'edit', 'update']
  root 'static#index'
  get 'static/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
