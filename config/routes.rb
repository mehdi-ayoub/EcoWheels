Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  post 'calculate_emissions', to: 'pages#calculate_emissions'

  resources :shipments, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :restaurants, only: [:new, :create, :show]
  end
end
