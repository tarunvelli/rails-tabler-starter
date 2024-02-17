Rails.application.config.app_settings = YAML.load_file(
  Rails.root.join("config/app_settings.yml"),
).tap do |setting|
  setting.each do |key, value|
    value["default"] = ENV[key.upcase] || value["default"]
  end
end
