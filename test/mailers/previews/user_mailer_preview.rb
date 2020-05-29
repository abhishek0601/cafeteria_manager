# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def invoice_preview
    UserMailer.invoice(User.last, User.last.orders.last)
  end
end
