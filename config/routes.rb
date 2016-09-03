Rails.application.routes.draw do
  root 'users#index'

  # post '/sessions' => 'sessions#create'
  # post '/users' => 'users#create'
  # delete '/sessions' => 'sessions#delete'
  # get '/users/:id' => 'users#show'

  resources :sessions

  resources :users do
    get 'friends' => 'friends#index', :as => 'friends'
  end

end


