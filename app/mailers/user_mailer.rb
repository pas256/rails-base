# frozen_string_literal: true

# Emails sent to users go here
class UserMailer < ApplicationMailer
  default from: email_address_with_name('notifications@example.com', 'Example Notifications')

  def magic_link_email
    @user = params[:user]
    @url  = root_url
    mail(to: @user.email)
  end
end
