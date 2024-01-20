module SetupHelper
  def app_settings_values(key)
    Rails.application.config.app_settings[key]["available"]
  end
end
