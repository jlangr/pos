Rails.application.routes.draw do
  resources :members
  resources :items
  resources :checkouts
  post 'checkouts/:id/scan/:upc', to: 'checkouts#scan'
  get 'checkouts/:id/total', to: 'checkouts#checkout_total'
end

