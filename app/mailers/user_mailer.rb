class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end


# The e-mail content should be formatted with HTML (make do with <p>, <hr>, <h*>, <br> and other simple tags. No need to add style attributes or <img>s).

# Since you don't know their name information, it can just have a generic greeting

# The Order ID should be in the subject line

# It should list the total as well as each line item in the order.

  def receipt_email(order)
    @order = order
    mail(to: @order.email, subject: "Receipt \##{@order.id}")
  end

end
