class SpacePolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @space = record
    @user_role = user.user_roles.find_by(space: record).role
  end

  def update?
    @user_role.editor?
  end
end
