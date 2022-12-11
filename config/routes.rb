Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :users, only: %i[edit update destroy]
  resources :spaces do
    resources :users, only: %i[index new create edit update destroy], controller: 'spaces/users'
    resources :roles, controller: 'spaces/roles'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
end
