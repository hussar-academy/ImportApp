Rails.application.routes.draw do
  root 'operations#index'

  resources :operations, only: [:index] do
    post 'import', on: :collection
  end
end
