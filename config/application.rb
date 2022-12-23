require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # use application router for error pages
    config.exceptions_app = routes

    # use sidekiq as background worker
    config.active_job.queue_adapter = :sidekiq

    # redis cache
    config.cache_store = :redis_store, {
      host: ENV['REDIS_HOST'],
      port: ENV['REDIS_PORT'],
      db: ENV['REDIS_DB'],
      password: ENV['REDIS_PASSWORD']
    }, {
      expires_in: 90.minutes
    }
  end
end
