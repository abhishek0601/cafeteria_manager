Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"

  resources :users
  resources :orders
  resources :menus
  resources :menu_items

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
  get "/home" => "menu_items#home", as: :new_menu_items_home
  post "/order_items" => "order_items#create", as: :new_order_item
  get "/cart" => "orders#new", as: :cart
  put "/status" => "orders#status", as: :order_status
  get "/orders/:id/invoice" => "orders#invoice", as: :invoice
  get "/reports" => "orders#reports", as: :reports
  delete "/order_items/:id" => "order_items#destroy", as: :order_items
  put "/order_items/update/:id" => "order_items#update", as: :update_order_items
end
