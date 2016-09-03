Rails.application.routes.draw do
  root 'users#index'

  resources :users do
    resources :favorite_locations
  end
end
