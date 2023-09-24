Rails.application.routes.draw do
  namespace :api do
    resources :companies, only: [:index, :show, :create, :update, :destroy]
    get '/companies/:id', to: 'companies#show', as: 'show_company'
    put '/companies/:id', to: 'companies#update', as: 'update_company'

    resources :reporters, only: [:index, :show, :create, :update, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
