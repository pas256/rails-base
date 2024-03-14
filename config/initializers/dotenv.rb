# frozen_string_literal: true

# Require the following environment variables to be set in all environments
required_env_vars = %w[
  DOMAIN
  MAGIC_LINK_SECRET_KEY
  SECRET_KEY_BASE
]

# Require the following environment variables to be set in development environments
if Rails.env.development?
  required_env_vars.push(%w[
                           MAILTRAP_USER_NAME
                           MAILTRAP_PASSWORD
                         ])
end

Dotenv.require_keys(required_env_vars)
