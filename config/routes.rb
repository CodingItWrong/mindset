Rails.application.routes.draw do
  devise_for :users
  resources :prayers
  authenticated do
    root to: 'prayers#show'
  end
  root to: redirect('/users/sign_in')
end
