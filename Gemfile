# frozen_string_literal: true

source "https://rubygems.org"
ruby "4.0.1"

gem "rails", "~> 8.0.0"

gem "bcrypt"
gem "bootsnap", require: false
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "puma"
gem "sqlite3"
gem "ruby-lsp"

# Front-end
gem "importmap-rails"
gem "sprockets-rails"
gem "tailwindcss-rails"
gem "turbo-rails"

group :development do
  gem "foreman"
  gem "rubocop"
  gem "rubocop-rails"
  gem "web-console"
end

group :development, :test do
  gem "debug"
  gem "factory_bot_rails"
end

group :test do
  # This is only necessary until the next minor version bump of Rails.
  # If you're reading this, you can probably remove this restriction.
  gem "minitest", "~> 5.0"
end
