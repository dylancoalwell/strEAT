Rails.application.routes.draw do
  root 'users#index'

  post '/sessions' => 'sessions#create'
  get '/sessions'=> 'sessions#new', :as => 'new_session'
  delete '/sessions' => 'sessions#delete'

  get '/users/search' => 'users#search', :as => 'users_search'

  # resources :sessions

  resources :users do
    get 'friends' => 'friends#index', :as => 'friends'
    get 'friends/new' => 'friends#new', :as => 'new_friend'
  end

end


