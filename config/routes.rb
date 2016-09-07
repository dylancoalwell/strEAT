Rails.application.routes.draw do
  root 'users#index'

  post '/sessions' => 'sessions#create'
  get '/sessions/new'=> 'sessions#new', :as => 'new_session'
  get '/sessions' => 'sessions#new'
  delete '/sessions' => 'sessions#delete'

  get '/users/search' => 'users#search', :as => 'users_search'
  post '/users/:id/favorite_locations' => 'favorite_locations#create'
  get '/users/:id/favorite_locations/new' => 'favorite_locations#new', :as => 'new_favorite'
  post '/users/:id/message' => 'users#message', :as => 'users_message'
  patch '/users/:id' => 'users#user_update'
  post '/users/:id' => 'users#update'

  get '/favorite_locations/:id' => 'favorite_locations#show'
  # resources :sessions
  # resources :favorite_locations

  # below is route to map initialization
  get '/directions/:id' => 'directions#new', :as => 'new_directions'

  post '/invitations' => 'invitations#create', :as => 'create_invitation'

  resources :users do
    get 'favorite_locations' => 'favorite_locations#index', :as => 'favorites'
      # resources :favorite_locations
    get 'friends' => 'friends#index', :as => 'friends'
    get 'friends/new' => 'friends#new', :as => 'new_friend'

    post 'friends' => 'friends#add_friend', :as => 'add_friend'
    delete 'friends' => 'friends#unfriend', :as => 'unfriend'
  end

end
