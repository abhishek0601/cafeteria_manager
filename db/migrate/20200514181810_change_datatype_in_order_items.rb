class ChangeDatatypeInOrderItems < ActiveRecord::Migration[6.0]
  def change
    change_column :order_items, :quantity, :integer
  end
end
