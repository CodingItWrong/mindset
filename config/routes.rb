Rails.application.routes.draw do
  devise_for :users
  resources :prayers, except: :index do
    collection do
      scope module: 'prayers' do
        resources :unanswered, only: [:index]
        resources :answered, only: [:index]
      end
    end
    resource :answer, only: [:new, :create]
  end
  authenticated do
    root to: 'prayers#show'
  end
  root to: redirect('/users/sign_in')
end
