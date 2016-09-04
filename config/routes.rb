Rails.application.routes.draw do
  root 'users#index'

  post '/sessions' => 'sessions#create'
  get '/sessions'=> 'sessions#new', :as => 'new_session'
  delete '/sessions' => 'sessions#delete'
  post '/favorite_locations' => 'favorite_locations#create'

  # resources :sessions
  # resources :favorite_locations

  resources :users do
    get 'favorite_locations' => 'favorite_locations#index', :as => 'favorite_locations'
    get 'friends' => 'friends#index', :as => 'friends'
  end

end


