Rails.application.routes.draw do
  root 'users#show'

  # post '/sessions' => 'sessions#create'
  post '/users' => 'users#create'
  delete '/sessions' => 'sessions#delete'

  resources :users
  resources :sessions
end
