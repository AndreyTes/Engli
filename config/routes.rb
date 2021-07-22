Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  root to: 'phrases#index', as: :root_path
  resources :phrases, only: [:new, :create, :edit, :update, :destroy]
  resources :users, only: [:show, :index]
  get 'hello' => 'static_pages#hello'

end
