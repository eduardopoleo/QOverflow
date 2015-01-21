Rails.application.routes.draw do

  root 'welcome#index'
  get 'ui/new_question', to: 'ui#new_question' 
end
