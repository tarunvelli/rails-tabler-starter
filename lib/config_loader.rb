class ConfigLoader
  def self.config_path (name)
    "#{Rails.root}/config/#{name.to_s}.yml"
  end

  def self.load_config (name, erb: true)
    path      = config_path(name)
    yaml_data  = File.read(path)
    yaml_data = ERB.new(yaml_data).result if erb
    yml_result = YAML.safe_load(yaml_data, aliases: erb)

    yml_result = yml_result[Rails.env] if yml_result[Rails.env].present?
    Hashr.new(yml_result)
  end
end