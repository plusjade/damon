Rails.application.routes.draw do
  root 'home#index'
  resources :videos, param: :token, except: [:create]
end
