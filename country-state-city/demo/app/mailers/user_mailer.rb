class UserMailer < ApplicationMailer

  def activation_needed_email(user)
    @user = user
    @url = activate_url(token: @user.activation_token)

    mail(to: @user.email, subject: "Activate account")
  end

  def activation_success_email(user)
    @user = user
    @url = sign_in_url()

    mail(to: @user.email, subject: "Account activated")
  end
end
