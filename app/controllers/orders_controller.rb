class OrdersController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :ensure_staff_logged_in, :only => [:status]
  before_action :ensure_owner_logged_in, :only => [:reports]

  def index
  end

  def new
    render "cart"
  end

  def all_orders
    ensure_staff_logged_in
  end

  def update
    id = params[:id]
    success = params[:success]
    order = current_user.orders.find(id)
    order.success = true
    if @current_user.role == "customer"
      order.delivered = false
    else
      order.delivered = true
      order.delivered_at = DateTime.now.in_time_zone("Asia/Kolkata")
      flash[:success] = "Ordered Successfully"
    end
    if order.save!
      if @current_user.role == "customer"
        flash[:success] = "Successfully Ordered and Invoice would be sent through E-mail"
      end
    end
    redirect_to orders_path
  end

  def status
    @order = Order.find(params[:id])
    @order.delivered = true
    @order.delivered_at = DateTime.now.in_time_zone("Asia/Kolkata")
    @user = User.find(@order.user_id)
    if @order.save
      UserMailer.invoice(@user, @order).deliver
      flash[:success] = "Order has been delivered successfully"
    end
    redirect_to orders_path
  end

  def invoice
    order = Order.find(params[:id])
    render "invoice", locals: { order: order }
  end

  def reports
    if params[:start_date] == "" || params[:end_date] == ""
      flash[:error] = "Date Range is Invalid"
      redirect_to reports_path
    else
      if params[:start_date]
        orders = Order.where("delivered = ? AND delivered_at >= ? AND delivered_at <= ? ", true, params[:start_date].to_date, params[:end_date].to_date + 1)
      end
      if params[:customer_id] != nil && params[:customer_id] != ""
        orders = Order.where("user_id = ? AND delivered=? ", params[:customer_id], true)
      end
      render "reports", locals: { orders: orders, start_date: params[:start_date], end_date: params[:end_date], customer_id: params[:customer_id] }
    end
  end
end
