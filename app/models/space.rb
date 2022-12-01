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
    return unless !Rails.application.config.multi_tenant_mode && Space.count.positive?

    errors.add(:base, "Can't create additional spaces in non-saas mode")
  end
end
