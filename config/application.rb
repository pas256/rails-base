# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mybase
  # Application configuration
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Add the `app/utils` directory to the load path
    config.autoload_paths += %W[#{config.root}/app/utils]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Domain for URLs in emails
    config.action_mailer.default_url_options = { host: ENV.fetch('DOMAIN', nil) }

    # TODO: For simple_form To avoid the error:
    #     Could not find "_form.html.tailwindcss" in any of your source paths.
    # use the workaround documented in https://github.com/rails/tailwindcss-rails/issues/246
    # and overwrite what tailwindcss-rails sets
    # config.generators.template_engine :erb
  end
end
