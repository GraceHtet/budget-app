Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index', as: 'home'

  resources :categories, only: [:index, :show, :new, :create] do
    resources :money_transactions, only: [:index, :new, :create]
  end

  resources :money_transactions, only: [:index, :show, :new, :create] do
    resources :categories, only: [:index, :new, :create]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
