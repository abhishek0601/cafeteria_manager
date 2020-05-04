class OrderItemsController < ApplicationController
  def create
    order = current_user.orders.cart
    order.order_items.create!(
      menu_item_name: params[:menu_item_name],
      menu_item_price: params[:menu_item_price],
      menu_item_id: params[:menu_item_id],
    )
    if params[:success] == false
      redirect_to cart_path
    else
      redirect_to cart_path
    end
  end
end
