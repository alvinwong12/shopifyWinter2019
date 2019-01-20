Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products
  
  get "/carts", to: "carts#index"
  get "/carts/:id", to: "carts#show"
  post "/carts", to: "carts#create"
  post "/carts/:id/products", to: "carts#add"
  post "/carts/:id/activate", to: "carts#activate"
  put  "/carts/:id/products", to: "carts#update"
  delete "/carts/:id", to: "carts#destroy"

  get "/", to: "welcome#index"
  
end
