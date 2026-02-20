# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :lead_session
  belongs_to :llm_model, optional: true

  validates :sender_type, presence: true, inclusion: { in: %w[lead system llm] }
end
