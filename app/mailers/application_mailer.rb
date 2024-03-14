# frozen_string_literal: true

# Base class for mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  # Override the `mail` method to use MJML
  # Snippet from: https://medium.com/@pl.d.wllms/sending-responsive-emails-from-a-rails-app-with-mjml-b36d3590d08f
  def mail(headers)
    super(headers) do |format|
      format.text
      format.mjml
    end
  end
end
