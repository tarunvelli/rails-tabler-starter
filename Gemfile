source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.0"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", require: false

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Add authorization to your Rails application [https://github.com/varvet/pundit]
gem "pundit", "~> 2.2"

# Add admin interface to your Rails application [https://github.com/sferik/rails_admin]
gem "rails_admin", "~> 3.0"

# Adds pagination to your Rails application [https://github.com/kaminari/kaminari]
gem "kaminari"

# Add user authentication to your Rails application [https://github.com/heartcombo/devise]
gem "devise", "~> 4.9"
gem "devise_invitable", "~> 2.0"

gem "dotenv", "~> 3.1"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Use letter_opener to preview emails in development [https://github.com/ryanb/letter_opener]
  gem "letter_opener"

  # Annotate models, routes, and components [https://github.com/ctran/annotate_models]
  gem "annotate"

  # Use RSpec for testing [https://github.com/rspec/rspec-rails]
  gem "rspec-rails"
  gem "rubocop-rspec"
  gem "factory_bot_rails"

  # Debugging tool [https://github.com/deivid-rodriguez/byebug]
  gem "byebug"

  # N+1 query detection [https://github.com/flyerhzm/bullet]
  gem "bullet"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  gem "ruby-lsp-rspec", require: false

  # Profiling tools
  gem "rack-mini-profiler", require: false
  gem "memory_profiler"
  gem "stackprof"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
