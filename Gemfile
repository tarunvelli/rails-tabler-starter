source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", ">= 7.0.8.1"

# The new asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use cockroachdb as the database for Active Record
gem 'activerecord-cockroachdb-adapter', '~> 7.0.0'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.4.2"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
gem "redis-namespace"
gem "redis-rails"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Authentication
gem "devise"

# Authorization
gem "pundit", "~> 2.2"

# Invitable
gem "devise_invitable", "~> 2.0.0"

# Admin interface
gem "rails_admin", "~> 3.0"

# pagination
gem "kaminari"

# background tasks
gem "sidekiq", ">= 7.2.4"
gem "sidekiq-scheduler"
gem "sidekiq-statistic"

# dependabot alerts
gem "rack", ">= 2.2.8.1"
gem "nokogiri", ">= 1.16.2"
gem "rdoc", ">= 6.6.3.1"
gem "yard", ">= 0.9.36"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"

  gem "pry-byebug", "~> 3.10.1"
  gem "pry-rails", "~> 0.3.9"
  gem "pry-rescue", "~> 1.5.2"

  gem "rspec-rails", "~> 6.0.0"
end

group :development do
  gem "annotate"
  gem "brakeman"
  gem "byebug"
  gem "foreman"
  gem "htmlbeautifier"
  gem "letter_opener"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "solargraph"
  gem "solargraph-rails"

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
