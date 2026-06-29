Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :items do
        resources :orders, only: [:index, :create], path: "orders"
        resources :comments, only: :create
  end
end