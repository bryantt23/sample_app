# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview



  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation

# define a user variable equal to the first user in the 
# development database, and then pass it as an argument to 
    user = User.first
# UserMailer.account_activation below
    
    # assigns a value to user.activation_token
    user.activation_token = User.new_token    
    
    UserMailer.account_activation(user)
  end


  # Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset
  end

end