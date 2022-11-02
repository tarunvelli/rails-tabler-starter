module Roles
  class Custom < Role
    belongs_to :space

    def self.sti_name
      'custom'
    end
  end
end
