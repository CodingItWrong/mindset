Rails.application.routes.draw do
  devise_for :users
  resources :prayers, only: [:create, :destroy]
  root to: 'prayers#index'
end
