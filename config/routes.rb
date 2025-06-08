Rails.application.routes.draw do
  devise_for :users

  authenticate :user, ->(user) { user.admin? } do
    mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[edit update destroy]

  resources :spaces do
    resources :users, only: %i[index new create edit update destroy], controller: "spaces/users"
    resources :roles, controller: "spaces/roles"
    resources :subscriptions, controller: "spaces/subscriptions"
  end

  resource :setup, only: %i[edit update]

  # Error pages
  %w[404 422 500].each do |code|
    get code, to: "errors#show", code:
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "application#landing"
end
