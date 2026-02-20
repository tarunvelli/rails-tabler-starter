# frozen_string_literal: true

class EmailDelivery < ApplicationRecord
  belongs_to :web_property
  belongs_to :lead
  belongs_to :lead_session

  validates :email, :template_key, presence: true

  enum :status, { queued: 0, sent: 1, failed: 2, bounced: 3 }
end
