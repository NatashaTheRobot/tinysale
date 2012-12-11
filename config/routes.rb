Tinysale::Application.routes.draw do
  root to: "static_pages#home"

  resources :emails, only: [:create]
end
