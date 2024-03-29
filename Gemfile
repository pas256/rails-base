# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.4'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem 'auto_strip_attributes', '~> 2.6' # Automatically strip spaces from model attributes
gem 'mjml-rails' # Use MJML for emails
# gem 'simple_form', '~> 5.1.0' # Form builder with flexible DSL

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'brakeman' # Static analysis security vulnerability scanner
  gem 'debug', platforms: %i[mri windows]
  gem 'dotenv', '~> 3.1' # Loads environment variables from .env into ENV
  gem 'rails-controller-testing' # Test controllers in isolation
  gem 'rubocop' # Code style enforcer
  gem 'rubocop-capybara' # Code style for Capybara
  gem 'rubocop-performance' # Code style for performance
  gem 'rubocop-rails' # Code style for Rails
end

group :development do
  # gem "rack-mini-profiler" # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "spring" # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem 'debugbar' # Debugging toolbar for Rails applications
  gem 'guard' # Use guard for TDD flow
  gem 'guard-minitest' # Use minitest until I get too frustrated and switch to RSpec
  gem 'letter_opener' # Preview mail in the browser instead of sending
  gem 'overcommit' # Enforce Rubocup code style before committinng
  gem 'web-console' # Use console on exceptions pages [https://github.com/rails/web-console]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
