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
module Roles
  class Common < Role
    def self.sti_name
      COMMON_TYPE
    end
  end
end
