# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id          :bigint           not null, primary key
#  name        :string
#  permissions :jsonb            not null
#  type        :string
#  value       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  space_id    :bigint
#
class Role < ApplicationRecord
  self.store_full_sti_class = false

  attribute :permissions, :json, default: {}

  COMMON_TYPE = "common".freeze
  CUSTOM_TYPE = "custom".freeze
  AVAILABLE_TYPES = [ COMMON_TYPE, CUSTOM_TYPE ].freeze
  AVAILABLE_PERMISSION_VALUES = [ "true", "false", nil ].freeze
  AVAILABLE_PERMISSIONS = %w[
    create_user
    read_user
    update_user
    delete_user
    create_space
    read_space
    update_space
    delete_space
  ].freeze

  validates_inclusion_of :type, in: AVAILABLE_TYPES
  validate :check_permissions

  def self.find_sti_class(type_name)
    super("Roles::#{type_name.classify}")
  end

  AVAILABLE_PERMISSIONS.each do |p|
    define_method("can_#{p}?") { permissions[p] == "true" }
  end

  def common?
    type == COMMON_TYPE
  end

  def custom?
    type == CUSTOM_TYPE
  end

  private

  def check_permissions
    permissions.each do |key, val|
      errors.add(:permissions, "Invalid permission key '#{key}'") unless AVAILABLE_PERMISSIONS.include?(key)
      errors.add(:permissions, "Invalid permission value '#{val}'") unless AVAILABLE_PERMISSION_VALUES.include?(val)
    end
  end
end
