# frozen_string_literal: true

# Emails sent to users go here
class UserMailer < ApplicationMailer
  default from: email_address_with_name('notifications@example.com', 'Example Notifications')

  def magic_link_email(email = params[:email], url = params[:url])
    @email = email
    @url = url
    @preview_text = 'Click the magic link to sign in'
    mail(to: @email)
  end
end
