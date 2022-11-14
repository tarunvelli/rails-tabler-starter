class Role < ApplicationRecord
  self.store_full_sti_class = false

  COMMON_TYPE = 'common'.freeze
  CUSTOM_TYPE = 'custom'.freeze
  AVAILABLE_TYPES = [COMMON_TYPE, CUSTOM_TYPE].freeze

  READ = 'r'.freeze
  WRITE = 'w'.freeze
  NONE = 'n'.freeze

  AVAILABLE_VALUES = [READ, WRITE, NONE].freeze
  AVAILABLE_PERMISSIONS = %w[user space].freeze

  validates_inclusion_of :type, in: AVAILABLE_TYPES
  validate :check_permissions

  def self.find_sti_class(type_name)
    super("Roles::#{type_name.classify}")
  end

  def common?
    type == COMMON_TYPE
  end

  def custom?
    type == CUSTOM_TYPE
  end

  def can_write?(object)
    permissions[object.to_s] == WRITE
  end

  def can_read?(object)
    can_write?(object) || permissions[object.to_s] == READ
  end

  private

  def check_permissions
    permissions.each do |key, val|
      errors.add(:permissions, "Invalid permission key '#{key}'") unless AVAILABLE_PERMISSIONS.include?(key)
      errors.add(:permissions, "Invalid permission value '#{val}'") unless AVAILABLE_VALUES.include?(val)
    end
  end
end
