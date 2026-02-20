# frozen_string_literal: true

class WebPropertyLlmConfig < ApplicationRecord
  belongs_to :web_property
  belongs_to :llm_model

  validates :priority, presence: true
  validates :llm_model_id, uniqueness: { scope: :web_property_id }
end
