# frozen_string_literal: true

source "https://rubygems.org"
ruby "3.3.6"

gem "rails", "~> 7.0"

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
gem "tailwindcss-rails", "~> 3.3.1"
gem "turbo-rails"

group :development do
  gem "foreman"
  gem "rubocop"
  gem "rubocop-rails"
  gem "web-console"
end

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
