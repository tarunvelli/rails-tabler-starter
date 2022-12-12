class SpacePolicy < ApplicationPolicy
  def initialize(user, record)
    super
    @role = user.get_role_in_space(record)
  end

  def update?
    @role.can_update_space?
  end

  def destroy?
    @role.can_delete_space?
  end
end
