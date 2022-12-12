class UserPolicy < ApplicationPolicy
  def initialize(user, record)
    super
    @role = user.get_role_in_space(record)
  end

  def create?
    @role.can_create_user?
  end

  def update?
    @role.can_update_user?
  end

  def destroy?
    @role.can_delete_user?
  end
end
