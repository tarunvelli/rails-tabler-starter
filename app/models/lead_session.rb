# frozen_string_literal: true

class LeadSession < ApplicationRecord
  belongs_to :lead
  belongs_to :web_property
  belongs_to :intake_schema

  has_many :messages, dependent: :destroy
  has_many :email_deliveries, dependent: :destroy
  has_many :lead_consents, dependent: :nullify
  has_many :audit_events, dependent: :nullify

  validates :session_token, presence: true, uniqueness: true
  validates :attempt_number, presence: true, uniqueness: { scope: :lead_id }
  validate :web_property_matches_related_records

  enum :status, { in_progress: 0, completed: 1, abandoned: 2 }

  private

  def web_property_matches_related_records
    return if web_property_id.blank?

    if lead&.web_property_id.present? && lead.web_property_id != web_property_id
      errors.add(:web_property_id, "must match lead.web_property_id")
    end

    if intake_schema&.web_property_id.present? && intake_schema.web_property_id != web_property_id
      errors.add(:web_property_id, "must match intake_schema.web_property_id")
    end
  end
end
