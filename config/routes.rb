Rails.application.routes.draw do
  devise_for :users
  root "top#index"
  resources :items do
        resources :orders, only: [:index, :create], path: "orders"
        resources :comments, only: :create
        collection do
                    get 'search'
        end
        member do
                    post 'increment_view_count'
        end
  end
  resources :users, only: :show
end