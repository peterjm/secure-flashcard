# frozen_string_literal: true

source "https://rubygems.org"
ruby "3.1.0"

gem "rails", "~> 7.0"

gem "bcrypt"
gem "bootsnap", require: false
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "puma"

# Front-end
gem "font-awesome-rails"
gem "importmap-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"

group :production do
  gem "pg"
end

group :development do
  gem "foreman"
  gem "rubocop"
  gem "rubocop-rails"
  gem "web-console"
end

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "sqlite3"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
