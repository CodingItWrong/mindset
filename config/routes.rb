Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  resources :thoughts, except: :index do
    collection do
      scope module: 'thoughts' do
        resources :unresolved, only: [:index], as: 'unresolved_thoughts'
        resources :resolved, only: [:index], as: 'resolved_thoughts'
      end
    end
    resource :resolution, only: [:new, :create]
  end
  resources :tags, only: :index do
    scope module: 'tags' do
      resources :unresolved_thoughts, only: :index
      resources :resolved_thoughts, only: :index
    end
  end

  namespace :api do
    resources :thoughts, only: %i[index create update destroy]
  end

  authenticated do
    root to: 'thoughts#show'
  end
  root to: redirect('/users/sign_in')
end
