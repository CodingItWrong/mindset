Rails.application.routes.draw do
  devise_for :users
  resources :prayers, only: [:create]
  root to: 'prayers#index'
end
