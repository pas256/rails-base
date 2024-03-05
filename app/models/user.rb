# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Automatically strip spaces from email
  auto_strip_attributes :email

  # Lowercase emails before validating
  before_validation { email&.downcase! }

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
