# frozen_string_literal: true

source "https://rubygems.org"
ruby "4.0.1"

gem "rails", "~> 8.1.0"

gem "bcrypt"
gem "bootsnap", require: false
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "puma"
gem "sqlite3"

# Front-end
gem "importmap-rails"
gem "propshaft"
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
  gem "capybara"
end

gem "stimulus-rails", "~> 1.3"
