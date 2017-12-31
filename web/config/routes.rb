Rails.application.routes.draw do
  root 'home#index'
  resources :videos, param: :token, except: [:create]
  resources :categories, only: [:index]
  resources :chats, only: [:index]
  resources :feeds, param: :category_name, only: [:show]
  resources :entries
end
