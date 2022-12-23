# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[edit update destroy]
  resources :spaces do
    resources :users, only: %i[index new create edit update destroy], controller: 'spaces/users'
    resources :roles, controller: 'spaces/roles'
  end

  # Error pages
  %w[404 422 500].each do |code|
    get code, to: 'errors#show', code: code
  end

  # Defines the root path route ("/")
  root 'welcome#index'
  get '/about', to: 'welcome#about', as: 'about', constraints: AboutRouteConstraint.new
end
