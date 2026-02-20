# frozen_string_literal: true

class WebProperty < ApplicationRecord
  belongs_to :site

  has_many :intake_schemas, dependent: :destroy
  has_many :web_property_llm_configs, dependent: :destroy
  has_many :leads, dependent: :destroy
  has_many :lead_sessions, dependent: :destroy
  has_many :email_deliveries, dependent: :destroy
  has_many :audit_events, dependent: :nullify

  validates :name, :public_id, presence: true

  enum :status, { active: 0, archived: 1 }
end
