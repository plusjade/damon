Rails.application.routes.draw do
  root 'home#index'
  resources :videos, param: :token, except: [:create]
  resources :trends, param: :token, except: [:create]
  resources :chats, only: [:index]
  resources :categories, only: [:index]
  resources :feeds, param: :category_name, only: [:show]
  resources :entries
end
