class UserMailer < ApplicationMailer
  def invoice(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Order Delivered")
  end
end
