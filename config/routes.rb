Tinysale::Application.routes.draw do
  match '/rate' => 'rater#create', :as => 'rate'

  get "payments/new"

  devise_for :users

  root to: "static_pages#home"

  resources :emails, only: [:create]
  resources :products, path: 'sale'
  get 'sale/:permalink/download_sample' => 'products#download_sample', as: :download_sample_product_path
  resources :payments
  resources :comments
  resources :attachments, only: [:show]

  mount StripeEvent::Engine => '/stripe_webhook'

  post "/charge" => "products#charge", as: :charge
end
