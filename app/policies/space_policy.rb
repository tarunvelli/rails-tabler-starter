class SpacePolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @space = record
    @role = user.get_role_in_space(record)
  end

  def update?
    @role.can_update_space?
  end
end
