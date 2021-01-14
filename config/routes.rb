Rails.application.routes.draw do
  resources :items
  resources :members
  resources :checkouts
  post 'checkouts/scan', to: 'checkouts#scan'
end

