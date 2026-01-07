Rails.application.routes.draw do
  get 'products/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'sellers/sign_up', to: 'users/registrations#new', defaults: { seller: true }, as: :seller_sign_up
  end  
  namespace :admin do
    resources :products
  end

  root "articles#index"
  get "/articles", to: "articles#index"
  resources :products
  resources :products, only: [:index] do
    member do
      get :details
    end
  end
  resources :carts, only: [:create, :show]
  resources :cart, only: [:index] do
    collection do
      post :add
      post :buy_now
      delete :remove
    end
  end
  resources :cart, only: [:index] do
    collection do
      post :add
    end
  end
  resources :checkout, only: [:index] do
    collection do
      post :place_order
    end
  end

  resources :orders, only: [:index, :show]
  namespace :admin do
    resources :orders, only: [:index, :show, :update]
  end
end
