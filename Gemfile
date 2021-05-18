source 'https://rubygems.org'
ruby '2.6.5'

gem 'rails', '~> 5.2'
gem 'puma', '~> 4.3'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false

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
