FactoryBot.define do
  factory :role do
    type { Role::COMMON_TYPE }
    sequence(:name) { |n| "Role #{n}" }
    permissions { {} }
  end

  factory :plan do
    sequence(:name) { |n| "Plan #{n}" }
    currency { "USD" }
    duration { "monthly" }
    price { 0.0 }
  end

  factory :subscription do
    association :site
    association :plan
    start_date { Time.current }
    seats { 1 }
  end

  factory :user_role do
    association :user
    association :site
    association :role
  end

  factory :web_property do
    association :site
    sequence(:name) { |n| "Web Property #{n}" }
    public_id { SecureRandom.uuid }
    domain { "example.com" }
    status { :active }
    allowed_origins { ["https://example.com"] }
  end

  factory :intake_schema do
    association :web_property
    sequence(:version) { |n| n }
    name { "Tax Intake" }
    json_schema { { type: "object", properties: {}, required: [] } }
    status { :draft }
  end

  factory :llm_model do
    provider { "openai" }
    sequence(:model_id) { |n| "gpt-4.1-mini-#{n}" }
    display_name { "GPT 4.1 Mini" }
    capabilities { {} }
    active { nil }
  end

  factory :web_property_llm_config do
    association :web_property
    association :llm_model
    priority { 100 }
    enabled { true }
    settings { {} }
  end

  factory :lead do
    association :web_property
    external_visitor_id { SecureRandom.hex(8) }
    email { "lead@example.com" }
    status { :in_progress }
  end

  factory :lead_session do
    association :lead
    web_property { lead.web_property }
    intake_schema { association(:intake_schema, web_property: web_property) }
    session_token { SecureRandom.hex(16) }
    attempt_number { 1 }
    responses { {} }
    status { :in_progress }
  end

  factory :message do
    association :lead_session
    sender_type { "lead" }
    content { "Sample message" }
  end

  factory :email_delivery do
    association :lead_session
    lead { lead_session.lead }
    web_property { lead_session.web_property }
    email { "lead@example.com" }
    template_key { "estimate_v1" }
    status { :queued }
  end

  factory :lead_consent do
    association :lead
    lead_session { nil }
    consent_type { "privacy_policy" }
    accepted { true }
    accepted_at { Time.current }
  end

  factory :audit_event do
    association :web_property
    association :lead
    association :lead_session
    event_type { "embed_token_rejected" }
    occurred_at { Time.current }
    metadata { {} }
  end
end
