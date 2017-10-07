Rails.application.routes.draw do
  devise_for :users
  resources :prayers, except: :index do
    collection do
      scope module: 'prayers' do
        resources :unanswered, only: [:index], as: 'unanswered_prayers'
        resources :answered, only: [:index], as: 'answered_prayers'
      end
    end
    resource :answer, only: [:new, :create]
  end
  resources :tags, only: :index do
    scope module: 'tags' do
      resources :unanswered_prayers, only: :index
      resources :answered_prayers, only: :index
    end
  end
  authenticated do
    root to: 'prayers#show'
  end
  root to: redirect('/users/sign_in')
end
