Rails.application.routes.draw do
  root 'welcome#index'

  get 'ui(/:action)', controller: 'ui'
  
  #session routes
  get '/signin', to: 'sessions#signin', as: :signin
  post '/login', to: 'sessions#login', as: :login
  get '/logout', to: 'sessions#logout', as: :logout


  #resources routes
  resources :questions, only: [:new, :index, :create, :show]
  post '/users', to: 'users#create', as: :create_user
  resources :users, except: [:create]
end
