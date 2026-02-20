# frozen_string_literal: true

class IntakeSchema < ApplicationRecord
  belongs_to :web_property

  has_many :lead_sessions, dependent: :restrict_with_error

  validates :version, :json_schema, presence: true
  validates :version, uniqueness: { scope: :web_property_id }
  validate :single_active_schema_per_web_property

  enum :status, { draft: 0, active: 1, archived: 2 }

  private

  def single_active_schema_per_web_property
    return unless active?
    return if web_property_id.blank?

    conflict_exists = self.class.where(web_property_id: web_property_id, status: self.class.statuses[:active])
                                .where.not(id: id)
                                .exists?
    return unless conflict_exists

    errors.add(:status, "only one active schema is allowed per web property")
  end
end
