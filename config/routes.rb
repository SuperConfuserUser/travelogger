Rails.application.routes.draw do

  get '/auth/facebook/callback', to: 'sessions#create', constraints: { protocol: /https/ }


  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  resources :entries
  resources :trips
  resources :users, only: ['index', 'show', 'new', 'create', 'edit', 'update']

  get 'static/index'
  root 'static#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
