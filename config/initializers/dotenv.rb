# frozen_string_literal: true

# Require the following environment variables to be set
required_env_vars = %w[
  DOMAIN
]
Dotenv.require_keys(required_env_vars)
