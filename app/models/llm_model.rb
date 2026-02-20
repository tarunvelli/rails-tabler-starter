# frozen_string_literal: true

class LlmModel < ApplicationRecord
  has_many :web_property_llm_configs, dependent: :destroy
  has_many :messages, dependent: :nullify

  validates :provider, :model_id, presence: true
  validates :model_id, uniqueness: { scope: :provider }
  validate :single_active_model

  private

  def single_active_model
    return unless active?

    conflict_exists = self.class.where(active: true).where.not(id: id).exists?
    return unless conflict_exists

    errors.add(:active, "only one active model is allowed")
  end
end
