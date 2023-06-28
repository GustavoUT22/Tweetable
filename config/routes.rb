Rails.application.routes.draw do
  root "tweets#index"
  # resources :likes
  # resources :tweets
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  devise_for :users, controllers: {
    omniauth_callbacks: :callbacks
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/profile", to: "users#show", as: "users"
end
