class UserMailer < ApplicationMailer
  def invoice(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: "Order Delivered")
  end

  def forgot_password(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, :subject => "Reset password instructions"
  end
end
