# frozen_string_literal: true

class LeadConsent < ApplicationRecord
  belongs_to :lead
  belongs_to :lead_session, optional: true

  validates :consent_type, presence: true
end
