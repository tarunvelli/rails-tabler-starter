Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[new create show edit update destroy]
  resources :spaces do
    resources :users, only: %i[index edit new create], controller: 'spaces/users' do
      member do
        post :user_role, as: 'role'
      end
    end
    resources :roles
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
end
