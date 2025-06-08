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

  Rails.application.config.app_settings.each do |key, schema|
    define_singleton_method(key) do
      TypeCast::FUNCTION_MAPPER[schema["type"]].call(inferred_value(key))
    end
  end

  class << self
    private

    def inferred_value(key)
      find_by(key:)&.value || Rails.application.config.app_settings[key]["default"]
    end
  end

  private

  def type
    Rails.application.config.app_settings[key]["type"]
  end
end
