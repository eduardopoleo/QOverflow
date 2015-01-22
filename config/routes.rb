Rails.application.routes.draw do

  root 'welcome#index'
  get 'ui(/:action)', controller: 'ui'
  resources :questions, only: [:new, :index, :create]
end
