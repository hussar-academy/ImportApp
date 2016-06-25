Rails.application.routes.draw do
  root 'home#index'
  resources :operations, only: [:create]
end
