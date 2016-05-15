require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :companies
  resources :operations

  get '/import', to: 'import#index'
  post '/import', to: 'import#create'

  get '/fetch_operations', to: 'companies#fetch_operations'

  root 'companies#index', as: :root
end
