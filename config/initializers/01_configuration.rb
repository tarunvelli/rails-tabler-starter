require "#{Rails.root}/lib/config_loader"

module App
  Config = ConfigLoader.load_config("configuration")
end
