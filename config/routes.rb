Rails.application.routes.draw do
  get 'dashboards/index'
  devise_for :users
  root to: "pages#home"

  post 'calculate_emissions', to: 'pages#calculate_emissions'
  get 'dashboard', to: 'pages#dashboard'

  resources :shipments, only: [:index, :new, :create, :edit, :update, :destroy, :show]
end
