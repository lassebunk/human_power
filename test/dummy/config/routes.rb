Dummy::Application.routes.draw do
  get "sitemap.xml" => "nothing#here", as: :sitemap
  get "admin" => "nothing#here", as: :admin
  get "login" => "nothing#here", as: :login
  resources :products
end
