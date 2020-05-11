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
end
