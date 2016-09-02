Rails.application.routes.draw do
  root 'users#show'

  # post '/sessions' => 'sessions#create'
  post '/users' => 'users#create'

  resources :users
  resources :sessions
end
