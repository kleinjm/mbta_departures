source 'https://rubygems.org'

ruby '2.3.1'

### Core
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18' # Use postgresql as the database for Active Record
gem 'puma', '~> 3.0' # Use Puma as the app server

gem 'bootstrap', '~> 4.0.0.alpha5'
gem 'rails-assets-tether', '>= 1.1.0'
gem 'haml-rails', '~> 0.9.0' # .html.haml views
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'sass-rails', '~> 5.0' # Use SCSS for stylesheets
gem 'simple_form'
# Turbolinks makes navigating your web application faster.
# Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

### Optional
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an IRB console on exception pages or by using <%= console %>
  # anywhere in the code.
  gem 'web-console'
end

group :test do
  gem 'capybara' # feature specs
  # headless browser and JS framework with capybara. Requires QT5+
  gem 'capybara-webkit', '~> 1.1.0'
  gem 'database_cleaner', '~> 1.5.3'
  gem 'factory_girl'
  gem 'rails-controller-testing', '~> 1.0.1'
  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.1.1'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
end
