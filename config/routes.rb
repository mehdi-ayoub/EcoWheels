Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  post 'calculate_emissions', to: 'pages#calculate_emissions'

  resources :shipments
end
