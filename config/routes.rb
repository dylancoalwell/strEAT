Rails.application.routes.draw do
  root 'users#show'

  # post '/sessions' => 'sessions#create'
  post '/users' => 'users#create'
  delete '/sessions' => 'sessions#delete'

  resources :sessions

  resources :users do
    get 'friends' => 'friends#index', :as => 'friends'
  end
    root 'users#index'
end


