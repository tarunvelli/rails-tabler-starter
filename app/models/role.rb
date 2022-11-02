class Role < ApplicationRecord
  self.store_full_sti_class = false

  def self.find_sti_class(type_name)
    super("Roles::#{type_name.classify}")
  end
end
