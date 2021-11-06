source 'https://rubygems.org'
ruby '2.6.5'

gem 'rails', '~> 5.2'
gem 'puma'
gem 'uglifier'
gem 'turbolinks'
gem 'bcrypt'
gem 'bootsnap', require: false

group :production do
  gem 'pg'
end

group :development do
  gem 'listen' # needed for puma in development
end

group :development, :test do
  gem 'sqlite3'
  gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'font-awesome-rails'
gem 'omniauth-google-oauth2'
