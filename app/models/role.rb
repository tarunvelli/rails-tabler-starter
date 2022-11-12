class Role < ApplicationRecord
  self.store_full_sti_class = false

  AVAILABLE_PERMISSIONS = %w[user space].freeze
  WRITE = 'w'.freeze
  READ = 'r'.freeze
  AVAILABLE_VALUES = [WRITE, READ].freeze

  validate :check_permissions

  def self.find_sti_class(type_name)
    super("Roles::#{type_name.classify}")
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
