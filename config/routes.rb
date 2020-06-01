Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"

  resources :users
  resources :orders
  resources :menus
  resources :menu_items
  resources :password_resets

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
  get "/home" => "sessions#home", as: :sessions_home
  post "/order_items" => "order_items#create", as: :new_order_item
  get "/cart" => "orders#new", as: :cart
  put "/status" => "orders#status", as: :order_status
  get "/orders/:id/invoice" => "orders#invoice", as: :invoice
  get "/reports" => "orders#reports", as: :reports
  delete "/order_items/:id" => "order_items#destroy", as: :order_items
  put "/order_items/update/:id" => "order_items#update", as: :update_order_items
  get "/all_orders" => "orders#all_orders", as: :all_orders
  patch "/users/:id/change_role" => "users#change_role", as: :change_user_role
  get "/menus/:id/add_item" => "menu_items#add_item", as: :add_item
end
