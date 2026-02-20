# frozen_string_literal: true

class AuditEvent < ApplicationRecord
  belongs_to :web_property, optional: true
  belongs_to :lead, optional: true
  belongs_to :lead_session, optional: true

  validates :event_type, :occurred_at, presence: true
end
