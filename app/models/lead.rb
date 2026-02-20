# frozen_string_literal: true

class Lead < ApplicationRecord
  belongs_to :web_property

  has_many :lead_sessions, dependent: :destroy
  has_many :messages, through: :lead_sessions
  has_many :email_deliveries, dependent: :destroy
  has_many :lead_consents, dependent: :destroy
  has_many :audit_events, dependent: :nullify

  enum :status, { in_progress: 0, completed: 1, abandoned: 2 }
end
