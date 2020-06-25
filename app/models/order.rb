class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  def self.cart
    order = find_by("success = ?", false)
    if order == nil
      order = create!(date: DateTime.now, success: false)
    end
    order
  end

  def self.filter
    Order.where.not(delivered: nil)
  end

  def total_price
    order = Order.find(id)
    total_price = 0
    order.order_items.each do |order_item|
      total_price = total_price + order_item.menu_item_price * order_item.quantity
    end
    total_price
  end

  def self.pending_orders
    all.where("delivered=?", false)
  end

  def self.all_orders
    all.where("delivered=?", true).order("delivered_at DESC")
  end

  def delivered_time
    delivered_at.strftime("%d %b %Y")
  end

  def find_order_items(order_item)
    order_items.find_by(menu_item_name: order_item.menu_item_name)
  end

  def self.total_amount(orders)
    total_amount = 0
    orders.each do |order|
      total_amount = total_amount + order.total_price
    end
    total_amount
  end
end
