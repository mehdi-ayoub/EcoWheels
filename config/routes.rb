Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :shipments, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
