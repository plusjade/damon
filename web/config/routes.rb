Rails.application.routes.draw do
  root 'home#index'
  get "/play" => 'narly#play'
  get "/make" => 'narly#make'
end
