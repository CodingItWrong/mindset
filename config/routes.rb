Rails.application.routes.draw do
  devise_for :users
  resources :prayers, only: [:new, :create, :edit, :update, :destroy]
  authenticated do
    root to: 'prayers#index'
  end
  root to: redirect('/users/sign_in')
end
