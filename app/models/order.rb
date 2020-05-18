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
end
