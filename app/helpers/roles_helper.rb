# frozen_string_literal: true

module RolesHelper
  def has?(permission)
    @role.send("can_#{permission}?")
  end
end
