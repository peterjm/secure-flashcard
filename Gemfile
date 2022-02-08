source 'https://rubygems.org'
ruby '3.1.0'

gem 'rails', '~> 7.0'

gem 'puma'
gem 'bcrypt'
gem 'bootsnap', require: false

gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

group :production do
  gem 'pg'
end

group :development do
  gem "web-console"
end

group :development, :test do
  gem 'sqlite3'
  gem 'dotenv-rails'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'font-awesome-rails'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
