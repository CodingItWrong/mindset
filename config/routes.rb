Rails.application.routes.draw do
  devise_for :users
  resources :prayers, only: [:new, :create, :edit, :update, :destroy]
  root to: 'prayers#index'
end
