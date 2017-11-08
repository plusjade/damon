Rails.application.routes.draw do
  root 'home#index'
  resources :videos, param: :token, except: [:create]
  resources :trends, param: :token, except: [:create]
  resources :entries
end
