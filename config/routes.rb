require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :companies
  resources :operations

  get '/import', to: 'import#index'
  post '/import', to: 'import#create'

  root 'companies#index', as: :root
end
