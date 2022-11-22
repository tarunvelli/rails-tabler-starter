Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[new create show edit update destroy]
  resources :spaces do
    resources :users, only: [:index]
    resources :roles
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#show'
end
