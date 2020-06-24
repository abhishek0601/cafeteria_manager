class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :name, presence: true
  validates :email, presence: true
  validates :phone_number, format: { with: /\d[0-9]\)*\z/, message: " bad format" }, :length => { :minimum => 10, :maximum => 15 }

  def self.clerk
    all.where("role=?", "clerk")
  end

  def self.users
    all.where("role=?", "customer")
  end

  def user_orders(orders)
    orders.where.not(delivered: nil).order("delivered_at DESC")
  end

  def total_orders
    orders.where("delivered=?", true).count
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.forgot_password(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
