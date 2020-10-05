Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :users, only: [:show, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
