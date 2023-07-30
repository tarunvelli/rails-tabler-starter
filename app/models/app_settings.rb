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
  after_save :update_settings_cache

  AVAILABLE_SETTINGS = {
    "interface_layout" => {
      type: :string,
      values: %w[VERTICAL VERTICAL-TRANSPARENT HORIZONTAL OVERLAP CONDENSED],
    },
    "interface_mode" => {
      type: :string,
      values: %w[LIGHT DARK SYSTEM],
    },
    "interface_theme" => {
      type: :string,
      values: %w[DEFAULT COOL],
    },
    "login_layout" => {
      type: :string,
      values: %w[DEFAULT ILLUSTRATION COVER],
    },
    "multi_space_mode" => {
      type: :boolean,
      values: [true, false],
    },
    "show_landing_page" => {
      type: :boolean,
      values: [true, false],
    },
  }.freeze

  AVAILABLE_SETTINGS.each do |key, _schema|
    define_singleton_method(key) do
      return class_variable_get("@@#{key}") if class_variable_defined?("@@#{key}")

      value = typecasetd_settings_value(key, find_by(key:)&.value)
      class_variable_set("@@#{key}", value) && value
    end
  end

  def self.typecasetd_settings_value(key, value)
    return value unless AVAILABLE_SETTINGS[key]

    case AVAILABLE_SETTINGS[key][:type]
    when :boolean
      value == "true"
    else
      value
    end
  end

  private

  def update_settings_cache
    self.class.class_variable_set(
      "@@#{key}", self.class.typecasetd_settings_value(key, value)
    )
  end
end
