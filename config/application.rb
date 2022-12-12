require_relative "boot"

require "rails/all"

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

    # layout ["VERTICAL", "HORIZONTAL", "OVERLAP", "CONDENSED"]
    config.interface_layout = 'CONDENSED'
    # mode ["LIGHT", "DARK"]
    config.interface_mode = 'LIGHT'
    # theme ["DEFAULT", "COOL"]
    config.interface_theme = 'DEFAULT'
    # layout ["DEFAULT", "ILLUSTRATION", "COVER"]
    config.login_layout = 'DEFAULT'

    # multi tenant mode [true, false]
    # when true allows multiple spaces to be created
    config.multi_tenant_mode = true

    # show landing page [true, false]
    # when true  root shows the landing page when user is signed out
    config.show_landing_page = true
  end
end
