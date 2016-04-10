Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :lists
    resources :list_items
    root to: "users#index"
  end

  devise_for :users
  root 'home#index'
  get 'contact' => 'home#contact'

  namespace :api do
    resources :static, only: [:index]
    resources :lists, only: [:index, :show, :create, :update]
    resources :list_items, only: [:create]
  end

  resources :lists do
    member do
      resource :list_items do 
        member do
          get :add_to_basket
        end
      end
    end
  end

end
