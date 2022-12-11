# frozen_string_literal: true

class Space < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, presence: true
  validate :check_multi_tenant_mode

  enum status: %i[active archived]

  def all_roles
    Role.where(space_id: [nil, id])
  end

  private

  def check_multi_tenant_mode
    return if multi_tenant_mode?

    errors.add(:base, "Can't create additional spaces in single-tenant mode")
  end
end
