Tinysale::Application.routes.draw do
  devise_for :users

  root to: "static_pages#home"

  resources :emails, only: [:create]
  resources :products, only: [:index, :new, :create]
  resources :products, path: "sale", except: [:index, :new, :create]
end
