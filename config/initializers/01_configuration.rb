require "#{Rails.root}/lib/app/config_loader"

module App
  Config = ConfigLoader.load_config("configuration")
end
