class OrderItemsController < ApplicationController
  def create
    order = current_user.orders.cart
    order_item = order.order_items.find_by(menu_item_name: params[:menu_item_name])
    quantity = 1
    order.order_items.create!(
      menu_item_name: params[:menu_item_name],
      menu_item_price: params[:menu_item_price],
      menu_item_id: params[:menu_item_id],
      quantity: quantity,
    )
    flash[:success] = "#{params[:menu_item_name]} has been added to cart successfully"
    redirect_to menu_path(id: params[:menu_id])
  end

  def destroy
    id = params[:id]
    order_item = OrderItem.all.find(id)
    order_item.destroy
    redirect_to cart_path
  end

  def update
    order_item = OrderItem.find(params[:id])
    if params[:update] == "+"
      order_item.quantity = order_item.quantity + 1
      order_item.save
    else
      if order_item.quantity == 1
        order_item.destroy
      else
        order_item.quantity = order_item.quantity - 1
        order_item.save
      end
    end
    if params[:route] == "cart"
      redirect_to cart_path
    else
      redirect_to menu_path(id: params[:menu_id])
    end
  end
end
