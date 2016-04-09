Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'contact' => 'home#contact'

  namespace :api do
    resources :static, only: [:index]
    resources :lists, only: [:index]
  end

  resources :lists do
    member do
      resource :list_items
    end
  end
end
