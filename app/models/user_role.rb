class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :space
  belongs_to :role

  validate :role_belongs_to_space

  private

  def role_belongs_to_space
    return if role.common?
    return if role.space == space

    errors.add(:base, 'invalid role for space')
  end
end
