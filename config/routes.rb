Rails.application.routes.draw do
  resources :listings

  get 'pages/about'

  get 'pages/contact'

  root 'listings#index'
end
