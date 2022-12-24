module SetupHelper
  def app_settings_values(key)
    AppSettings::AVAILABLE_SETTINGS[key][:values]
  end
end
