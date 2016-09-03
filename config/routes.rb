Rails.application.routes.draw do


  resources :users do
    get 'friends' => 'friends#index', :as => 'friends'
  end
    root 'users#index'
end


