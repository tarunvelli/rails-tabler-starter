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

    # layout ["VERTICAL", "HORIZONTAL", "OVERLAP", "CONDENSED"]
    config.interface_layout = 'CONDENSED'
    # mode ["LIGHT", "DARK"]
    config.interface_mode = 'LIGHT'
    # theme ["DEFAULT", "COOL"]
    config.interface_theme = 'COOL'
    # layout ["DEFAULT", "ILLUSTRATION", "COVER"]
    config.login_layout = 'DEFAULT'

    # saas mode [true, false]
    # when true allows multiple spaces to be created
    config.multi_tenant_mode = true
  end
end
