Dummy::Application.routes.draw do
  get "admin" => "nothing#here", as: :admin
  get "login" => "nothing#here", as: :login
  resources :products
end
