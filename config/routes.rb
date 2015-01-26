Rails.application.routes.draw do
  root 'sessions#signin'

  get 'ui(/:action)', controller: 'ui'
  
  #session routes
  get '/signin', to: 'sessions#signin', as: :signin
  post '/login', to: 'sessions#login', as: :login
  get '/logout', to: 'sessions#logout', as: :logout

  #resources routes
  resources :questions, only: [:new, :index, :create, :show] do
    member do
      post :vote
    end

    resources :answers, only: [:create] do
      member do
        post :vote
      end
    end
  end

  post '/users', to: 'users#create', as: :create_user
  resources :users, except: [:create]
end
