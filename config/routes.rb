Rails.application.routes.draw do
  root 'users#index'

  post '/sessions' => 'sessions#create'
  get '/sessions'=> 'sessions#new', :as => 'new_session'
  delete '/sessions' => 'sessions#delete'

  # resources :sessions
  resources :favorite_locations

  resources :users do
    get 'friends' => 'friends#index', :as => 'friends'
  end

end


