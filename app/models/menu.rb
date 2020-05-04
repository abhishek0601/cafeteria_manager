class Menu < ActiveRecord::Base
  validates :name, presence: true
  has_many :menu_items
end
