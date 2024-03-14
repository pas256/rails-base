# frozen_string_literal: true

# Magic Link
module MagicLink
  class << self
    # # Automatically strip spaces from email
    # auto_strip_attributes :email

    # # Lowercase emails before validating
    # before_validation { email&.downcase! }

    # validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    #

    def generate_token(email)
      clean_email = email&.downcase&.strip
      mv.generate([SecureRandom.uuid, clean_email], purpose: :magic_link, expires_in: 1.hour)
    end

    def verify_token(signed_message)
      uuid, email = mv.verify(signed_message, purpose: :magic_link)
      key = "magic_link/#{uuid}"
      redis = Redis.new
      unused = redis.set(key, Time.current.to_s, ex: 1.day, nx: true)
      unused ? email : nil
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end

    private

    def mv
      secret = Rails.application.credentials.secret_key_base # TODO: use a different secret specifically for magic links
      ActiveSupport::MessageVerifier.new(secret, url_safe: true)
    end
  end
end
