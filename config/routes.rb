Rails.application.routes.draw do
  root to: 'phrases#index', as: :root_path
  resources :phrases
  get 'hello' => 'static_pages#hello'
end
