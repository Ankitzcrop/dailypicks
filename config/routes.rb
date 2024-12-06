Rails.application.routes.draw do
  get 'products/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  root "articles#index"
  get "/articles", to: "articles#index"
  resources :products, only: [:index]
  resources :carts, only: [:create, :show]
  resources :cart, only: [:index] do
    collection do
      post :add
    end
  end
end
