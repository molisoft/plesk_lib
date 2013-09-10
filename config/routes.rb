PleskKit::Engine.routes.draw do
  resources :servers


  resources :subscriptions
  resources :reseller_accounts
  resources :customer_accounts
end
