Rails.application.routes.draw do
  get 'products/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'sellers/sign_up', to: 'users/registrations#new', defaults: { seller: true }, as: :seller_sign_up
  end  
  root "articles#index"
  get "/articles", to: "articles#index"
  resources :products
  resources :carts, only: [:create, :show]
  resources :cart, only: [:index] do
    collection do
      post :add
    end
  end
end
