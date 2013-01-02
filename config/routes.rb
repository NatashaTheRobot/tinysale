Tinysale::Application.routes.draw do
  get "payments/new"

  devise_for :users

  root to: "static_pages#home"

  resources :emails, only: [:create]
  resources :products, only: [:index, :new, :create]
  resources :products, path: "sale", except: [:index, :new, :create]
  resources :payments

  match '/attachments/:id' => "products#download", as: :download

  mount StripeEvent::Engine => '/stripe_webhook'

  post "/charge" => "products#charge", as: :charge
end
