Rails.application.routes.draw do
  root 'users#show'

  resources :users
  resources :sessions

  post '/users' => 'users#create'
end
