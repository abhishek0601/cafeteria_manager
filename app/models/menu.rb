class Menu < ActiveRecord::Base
  validates :name, presence: true
  has_many :menu_items

  def self.active_menus
    all.where("active=?", true)
  end
end
