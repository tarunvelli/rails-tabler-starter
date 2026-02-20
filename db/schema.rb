# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_02_19_101000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "app_settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "settings", default: {}, null: false
    t.datetime "updated_at", null: false
    t.index ["settings"], name: "index_app_settings_on_settings", using: :gin
  end

  create_table "audit_events", force: :cascade do |t|
    t.string "actor_id"
    t.string "actor_type"
    t.datetime "created_at", null: false
    t.string "event_type", null: false
    t.inet "ip_address"
    t.bigint "lead_id"
    t.bigint "lead_session_id"
    t.jsonb "metadata", default: {}, null: false
    t.datetime "occurred_at", null: false
    t.string "request_id"
    t.datetime "updated_at", null: false
    t.bigint "web_property_id"
    t.index ["event_type"], name: "index_audit_events_on_event_type"
    t.index ["lead_id", "occurred_at"], name: "index_audit_events_on_lead_id_and_occurred_at"
    t.index ["lead_id"], name: "index_audit_events_on_lead_id"
    t.index ["lead_session_id", "occurred_at"], name: "index_audit_events_on_lead_session_id_and_occurred_at"
    t.index ["lead_session_id"], name: "index_audit_events_on_lead_session_id"
    t.index ["web_property_id", "occurred_at"], name: "index_audit_events_on_web_property_id_and_occurred_at"
    t.index ["web_property_id"], name: "index_audit_events_on_web_property_id"
  end

  create_table "email_deliveries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "error_class"
    t.text "error_message"
    t.datetime "failed_at"
    t.bigint "lead_id", null: false
    t.bigint "lead_session_id", null: false
    t.string "provider"
    t.string "provider_message_id"
    t.datetime "queued_at"
    t.integer "retries_count", default: 0, null: false
    t.datetime "sent_at"
    t.integer "status", default: 0, null: false
    t.string "template_key", null: false
    t.string "template_version"
    t.datetime "updated_at", null: false
    t.bigint "web_property_id", null: false
    t.index ["lead_id"], name: "index_email_deliveries_on_lead_id"
    t.index ["lead_session_id", "status"], name: "index_email_deliveries_on_lead_session_id_and_status"
    t.index ["lead_session_id"], name: "index_email_deliveries_on_lead_session_id"
    t.index ["provider_message_id"], name: "index_email_deliveries_on_provider_message_id"
    t.index ["web_property_id", "created_at"], name: "index_email_deliveries_on_web_property_id_and_created_at"
    t.index ["web_property_id"], name: "index_email_deliveries_on_web_property_id"
  end

  create_table "intake_schemas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "json_schema", null: false
    t.string "name"
    t.jsonb "pricing_config", default: {}, null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.integer "version", null: false
    t.bigint "web_property_id", null: false
    t.index ["web_property_id", "status"], name: "index_intake_schemas_one_active_per_web_property", unique: true, where: "(status = 1)"
    t.index ["web_property_id", "version"], name: "index_intake_schemas_on_web_property_id_and_version", unique: true
    t.index ["web_property_id"], name: "index_intake_schemas_on_web_property_id"
  end

  create_table "lead_consents", force: :cascade do |t|
    t.boolean "accepted", default: false, null: false
    t.datetime "accepted_at"
    t.string "consent_type", null: false
    t.datetime "created_at", null: false
    t.inet "ip_address"
    t.bigint "lead_id", null: false
    t.bigint "lead_session_id"
    t.string "policy_version"
    t.string "source"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.index ["lead_id", "consent_type", "created_at"], name: "index_lead_consents_lookup"
    t.index ["lead_id"], name: "index_lead_consents_on_lead_id"
    t.index ["lead_session_id"], name: "index_lead_consents_on_lead_session_id"
  end

  create_table "lead_sessions", force: :cascade do |t|
    t.integer "attempt_number", default: 1, null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.string "currency", default: "USD", null: false
    t.integer "current_step", default: 0, null: false
    t.integer "estimated_cost_cents"
    t.bigint "intake_schema_id", null: false
    t.bigint "lead_id", null: false
    t.boolean "pii_detected", default: false, null: false
    t.jsonb "responses", default: {}, null: false
    t.string "session_token", null: false
    t.datetime "started_at"
    t.integer "status", default: 0, null: false
    t.integer "total_steps"
    t.datetime "updated_at", null: false
    t.bigint "web_property_id", null: false
    t.index ["intake_schema_id"], name: "index_lead_sessions_on_intake_schema_id"
    t.index ["lead_id", "attempt_number"], name: "index_lead_sessions_on_lead_id_and_attempt_number", unique: true
    t.index ["lead_id"], name: "index_lead_sessions_on_lead_id"
    t.index ["session_token"], name: "index_lead_sessions_on_session_token", unique: true
    t.index ["web_property_id", "status"], name: "index_lead_sessions_on_web_property_id_and_status"
    t.index ["web_property_id"], name: "index_lead_sessions_on_web_property_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "contact_method"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "external_visitor_id"
    t.datetime "first_seen_at"
    t.inet "ip_address"
    t.datetime "last_seen_at"
    t.string "name"
    t.string "phone"
    t.string "referrer_url"
    t.integer "status", default: 0, null: false
    t.string "time_zone"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "web_property_id", null: false
    t.index ["created_at"], name: "index_leads_on_created_at"
    t.index ["web_property_id", "email"], name: "index_leads_on_web_property_id_and_email"
    t.index ["web_property_id", "status"], name: "index_leads_on_web_property_id_and_status"
    t.index ["web_property_id"], name: "index_leads_on_web_property_id"
  end

  create_table "llm_models", force: :cascade do |t|
    t.boolean "active"
    t.string "api_endpoint"
    t.jsonb "capabilities", default: {}, null: false
    t.datetime "created_at", null: false
    t.string "display_name"
    t.string "model_id", null: false
    t.string "provider", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_llm_models_one_active", unique: true, where: "(active = true)"
    t.index ["provider", "model_id"], name: "index_llm_models_on_provider_and_model_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.string "field_key"
    t.jsonb "field_value"
    t.string "intent"
    t.bigint "lead_session_id", null: false
    t.bigint "llm_model_id"
    t.jsonb "metadata", default: {}, null: false
    t.boolean "pii_detected", default: false, null: false
    t.string "sender_type", null: false
    t.datetime "updated_at", null: false
    t.index ["field_key"], name: "index_messages_on_field_key"
    t.index ["lead_session_id", "created_at"], name: "index_messages_on_lead_session_id_and_created_at"
    t.index ["lead_session_id"], name: "index_messages_on_lead_session_id"
    t.index ["llm_model_id"], name: "index_messages_on_llm_model_id"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "crm_id"
    t.string "currency", null: false
    t.string "description"
    t.string "duration", null: false
    t.string "name", null: false
    t.float "price", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.json "permissions", default: "{}", null: false
    t.bigint "site_id"
    t.string "type"
    t.datetime "updated_at", null: false
    t.string "value"
    t.index ["site_id"], name: "index_roles_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "status", default: 0
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "end_date"
    t.bigint "plan_id", null: false
    t.integer "seats"
    t.bigint "site_id", null: false
    t.datetime "start_date", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["site_id"], name: "index_subscriptions_on_site_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "site_id", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "site_id"], name: "index_user_roles_on_user_id_and_site_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.string "first_name"
    t.datetime "invitation_accepted_at"
    t.datetime "invitation_created_at"
    t.integer "invitation_limit"
    t.datetime "invitation_sent_at"
    t.string "invitation_token"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.string "last_name"
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.datetime "locked_at"
    t.string "phone"
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "session_token"
    t.integer "sign_in_count", default: 0, null: false
    t.integer "status", default: 0
    t.string "uid"
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "idx_users_on_email", unique: true
    t.index ["confirmation_token"], name: "idx_users_on_confirmation_token", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "idx_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "idx_users_on_unlock_token", unique: true
  end

  create_table "web_properties", force: :cascade do |t|
    t.text "allowed_origins", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.string "domain"
    t.jsonb "embed_config", default: {}, null: false
    t.string "embed_secret_digest"
    t.integer "embed_secret_version", default: 1, null: false
    t.integer "embed_token_ttl_seconds", default: 900, null: false
    t.string "name", null: false
    t.integer "pii_retention_days", default: 365, null: false
    t.uuid "public_id", null: false
    t.bigint "site_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["allowed_origins"], name: "index_web_properties_on_allowed_origins", using: :gin
    t.index ["domain"], name: "index_web_properties_on_domain"
    t.index ["public_id"], name: "index_web_properties_on_public_id", unique: true
    t.index ["site_id"], name: "index_web_properties_on_site_id"
  end

  create_table "web_property_llm_configs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "credential_ref"
    t.boolean "enabled", default: true, null: false
    t.bigint "llm_model_id", null: false
    t.integer "priority", default: 100, null: false
    t.jsonb "settings", default: {}, null: false
    t.datetime "updated_at", null: false
    t.bigint "web_property_id", null: false
    t.index ["llm_model_id"], name: "index_web_property_llm_configs_on_llm_model_id"
    t.index ["web_property_id", "enabled", "priority"], name: "index_web_property_llm_configs_routing"
    t.index ["web_property_id", "llm_model_id"], name: "index_web_property_llm_configs_unique_binding", unique: true
    t.index ["web_property_id"], name: "index_web_property_llm_configs_on_web_property_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "audit_events", "lead_sessions"
  add_foreign_key "audit_events", "leads"
  add_foreign_key "audit_events", "web_properties"
  add_foreign_key "email_deliveries", "lead_sessions"
  add_foreign_key "email_deliveries", "leads"
  add_foreign_key "email_deliveries", "web_properties"
  add_foreign_key "intake_schemas", "web_properties"
  add_foreign_key "lead_consents", "lead_sessions"
  add_foreign_key "lead_consents", "leads"
  add_foreign_key "lead_sessions", "intake_schemas"
  add_foreign_key "lead_sessions", "leads"
  add_foreign_key "lead_sessions", "web_properties"
  add_foreign_key "leads", "web_properties"
  add_foreign_key "messages", "lead_sessions"
  add_foreign_key "messages", "llm_models"
  add_foreign_key "roles", "sites"
  add_foreign_key "web_properties", "sites"
  add_foreign_key "web_property_llm_configs", "llm_models"
  add_foreign_key "web_property_llm_configs", "web_properties"
end
