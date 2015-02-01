class UserMailer < ApplicationMailer
  default from: "noreply@example.com"

  #  instance variable containing the user (for use in the view) and 
  # then mail the result to user.email
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
