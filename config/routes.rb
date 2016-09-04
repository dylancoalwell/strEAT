Rails.application.routes.draw do
  root 'users#index'

  post '/sessions' => 'sessions#create'
  get '/sessions'=> 'sessions#new', :as => 'new_session'
  delete '/sessions' => 'sessions#delete'

  get '/users/search' => 'users#search', :as => 'users_search'
  post '/users/:id/message' => 'users#message', :as => 'users_message'

  # resources :sessions

  resources :users do
    get 'friends' => 'friends#index', :as => 'friends'
    get 'friends/new' => 'friends#new', :as => 'new_friend'

    post 'friends' => 'friends#add_friend', :as => 'add_friend'
    delete 'friends' => 'friends#unfriend', :as => 'unfriend'
  end

end


