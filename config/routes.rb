Rails.application.routes.draw do
  resources :members
  resources :items
  resources :checkouts
  post 'checkouts/:id/scan/:upc', to: 'checkouts#scan'
  post 'checkouts/:id/scan_member/:member_phone', to: 'checkouts#scan_member'
  get 'checkouts/:id/total', to: 'checkouts#checkout_total'
  post 'checkouts/:id/charge', to: 'checkouts#charge'
end

