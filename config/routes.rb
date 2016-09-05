Rails.application.routes.draw do
  root 'users#index'

  post '/sessions' => 'sessions#create'
  get '/sessions'=> 'sessions#new', :as => 'new_session'
  delete '/sessions' => 'sessions#delete'

  get '/users/search' => 'users#search', :as => 'users_search'
  post '/users/:id/favorite_locations' => 'favorite_locations#create'
  get '/users/:id/favorite_locations/new' => 'favorite_locations#new'
  post '/users/:id/message' => 'users#message', :as => 'users_message'

  get '/favorite_locations/:id' => 'favorite_locations#show'
  # resources :sessions
  # resources :favorite_locations

  # below is route to map initialization
  get '/directions/:id' => 'directions#new', :as => 'new_directions'

  resources :users do
    get 'favorite_locations' => 'favorite_locations#index', :as => 'favorites'
      # resources :favorite_locations
    get 'friends' => 'friends#index', :as => 'friends'
    get 'friends/new' => 'friends#new', :as => 'new_friend'

    post 'friends' => 'friends#add_friend', :as => 'add_friend'
    delete 'friends' => 'friends#unfriend', :as => 'unfriend'
  end

end
