module Roles
  class Common < Role
    def self.sti_name
      COMMON_TYPE
    end
  end
end
