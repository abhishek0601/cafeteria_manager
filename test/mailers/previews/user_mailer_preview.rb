# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def invoice_preview
    UserMailer.invoice(User.first, User.first.orders.last)
  end
end
