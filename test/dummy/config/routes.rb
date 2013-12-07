Dummy::Application.routes.draw do
  get "admin" => "nothing#here", as: :admin
  resources :products
end
