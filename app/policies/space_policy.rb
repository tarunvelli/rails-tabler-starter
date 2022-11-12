class SpacePolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @space = record
    @role = user.user_roles.find_by(space: record).role
  end

  def update?
    @role.can_write?(:space)
  end
end
