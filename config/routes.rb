Tinysale::Application.routes.draw do
  match '/rate' => 'rater#create', :as => 'rate'

  get "payments/new"

  devise_for :users

  root to: "static_pages#home"

  resources :emails, only: [:create]
  resources :products, path: 'sale'
  resources :payments
  resources :comments

  match '/attachments/:id' => "products#download", as: :download

  mount StripeEvent::Engine => '/stripe_webhook'

  post "/charge" => "products#charge", as: :charge
end
