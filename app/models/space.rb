# frozen_string_literal: true

class Space < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, presence: true
  validate :check_saas_mode

  enum status: %i[active archived]

  private

  def check_saas_mode
    return unless !Rails.application.config.saas_mode && Space.count.positive?

    errors.add(:base, "Can't create additional spaces in non-saas mode")
  end
end
