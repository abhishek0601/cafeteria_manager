class AddUrlToMenus < ActiveRecord::Migration[6.0]
  def change
    add_column :menus, :menu_url, :string
  end
end
