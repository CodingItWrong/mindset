Rails.application.routes.draw do
  devise_for :users
  resources :prayers, except: :index do
    collection do
      resources :unanswered, only: [:index]
      resources :answered, only: [:index]
    end
    resource :answer, only: [:new, :create]
  end
  authenticated do
    root to: 'prayers#show'
  end
  root to: redirect('/users/sign_in')
end
