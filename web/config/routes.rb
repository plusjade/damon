Rails.application.routes.draw do
  root 'home#index'
  get "/narly" => 'narly#index'
end
