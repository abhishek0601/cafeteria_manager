class OrderItemsController < ApplicationController
  def create
    order = current_user.orders.cart
    check = order.order_items.exists?(:menu_item_name => params[:menu_item_name])
    order_item = order.order_items.find_by(menu_item_name: params[:menu_item_name])
    if check
      order_item.quantity = order_item.quantity + 1
      order_item.save
    else
      quantity = 1
      order.order_items.create!(
        menu_item_name: params[:menu_item_name],
        menu_item_price: params[:menu_item_price],
        menu_item_id: params[:menu_item_id],
        quantity: quantity,
      )
    end
    if params[:success] == false
      redirect_to cart_path
    else
      redirect_to cart_path
    end
  end
end
