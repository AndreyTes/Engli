Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up' }
  root to: 'phrases#index', as: :root_path
  resources :phrases do
    member do
      post :vote
    end
    resources :examples, only: [:create, :destroy] do
       post :vote
      end
  end
  resources :notifications, only: [:index] do
    collection do
      put :read_all
    end
  end
  resources :users, only: [:show, :index]
  get 'hello' => 'static_pages#hello'

end
