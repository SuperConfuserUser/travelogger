Rails.application.routes.draw do

  get '/auth/facebook/callback', to: 'sessions#create', constraints: { protocol: /https/ }

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy' #should this be post instead?

  resources :entries
  resources :trips
  resources :users, only: ['index', 'show', 'new', 'create', 'edit', 'update'] do
    resources :trips
  end

  root 'static#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
