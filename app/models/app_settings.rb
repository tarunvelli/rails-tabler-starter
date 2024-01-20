# frozen_string_literal: true

# == Schema Information
#
# Table name: app_settings
#
#  id         :bigint           not null, primary key
#  key        :string           not null
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AppSettings < ApplicationRecord
  require "type_cast"

  after_save :update_settings_cache

  Rails.application.config.app_settings.each do |key, schema|
    define_singleton_method(key) do
      return class_variable_get("@@#{key}") if class_variable_defined?("@@#{key}")

      value = TypeCast::FUNCTION_MAPPER[schema["type"]].call(find_by(key:)&.value)
      class_variable_set("@@#{key}", value) && value
    end
  end

  private

  def update_settings_cache
    self.class.class_variable_set(
      "@@#{key}", TypeCast::FUNCTION_MAPPER[type].call(value)
    )
  end

  def type
    Rails.application.config.app_settings[key]["type"]
  end
end
