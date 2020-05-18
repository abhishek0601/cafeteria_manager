class OrdersController < ApplicationController
  before_action :ensure_user_logged_in

  def index
  end

  def new
    render "cart"
  end

  def update
    id = params[:id]
    success = params[:success]
    order = current_user.orders.find(id)
    order.success = true
    order.delivered = false
    order.save!
    redirect_to menus_path
  end

  def status
    order = Order.find(params[:id])
    order.delivered = true
    order.delivered_at = DateTime.now
    order.save
    redirect_to orders_path
  end
end
