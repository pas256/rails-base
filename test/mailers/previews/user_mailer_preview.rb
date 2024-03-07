# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def magic_link_email
    UserMailer.with(user: User.first).magic_link_email
  end
end
