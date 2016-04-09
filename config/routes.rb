Rails.application.routes.draw do
  resources :lists
  devise_for :users
  root 'home#index'
  get 'contact' => 'home#contact'
end
