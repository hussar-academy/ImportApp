Rails.application.routes.draw do
  root 'home#index'
  resources :operations, only: [:index, :create]
end
