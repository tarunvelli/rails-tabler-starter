module Roles
  class Custom < Role
    belongs_to :space

    def self.sti_name
      CUSTOM_TYPE
    end
  end
end
