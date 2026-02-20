class CreateQualificationDomainTables < ActiveRecord::Migration[8.1]
  def change
    create_table :web_properties do |t|
      t.references :site, null: false, foreign_key: true
      t.string :name, null: false
      t.uuid :public_id, null: false
      t.string :domain
      t.integer :status, null: false, default: 0
      t.text :allowed_origins, array: true, null: false, default: []
      t.jsonb :embed_config, null: false, default: {}
      t.string :embed_secret_digest
      t.integer :embed_secret_version, null: false, default: 1
      t.integer :embed_token_ttl_seconds, null: false, default: 900
      t.integer :pii_retention_days, null: false, default: 365
      t.timestamps
    end

    add_index :web_properties, :public_id, unique: true
    add_index :web_properties, :domain
    add_index :web_properties, :allowed_origins, using: :gin

    create_table :intake_schemas do |t|
      t.references :web_property, null: false, foreign_key: true
      t.integer :version, null: false
      t.string :name
      t.jsonb :json_schema, null: false
      t.jsonb :pricing_config, null: false, default: {}
      t.integer :status, null: false, default: 0
      t.timestamps
    end

    add_index :intake_schemas, [:web_property_id, :version], unique: true
    add_index :intake_schemas, [:web_property_id, :status], unique: true, where: "status = 1", name: "index_intake_schemas_one_active_per_web_property"

    create_table :llm_models do |t|
      t.string :provider, null: false
      t.string :model_id, null: false
      t.string :display_name
      t.string :api_endpoint
      t.jsonb :capabilities, null: false, default: {}
      t.boolean :active
      t.timestamps
    end

    add_index :llm_models, [:provider, :model_id], unique: true
    add_index :llm_models, :active, unique: true, where: "active = true", name: "index_llm_models_one_active"

    create_table :web_property_llm_configs do |t|
      t.references :web_property, null: false, foreign_key: true
      t.references :llm_model, null: false, foreign_key: true
      t.integer :priority, null: false, default: 100
      t.boolean :enabled, null: false, default: true
      t.string :credential_ref
      t.jsonb :settings, null: false, default: {}
      t.timestamps
    end

    add_index :web_property_llm_configs, [:web_property_id, :llm_model_id], unique: true, name: "index_web_property_llm_configs_unique_binding"
    add_index :web_property_llm_configs, [:web_property_id, :enabled, :priority], name: "index_web_property_llm_configs_routing"

    create_table :leads do |t|
      t.references :web_property, null: false, foreign_key: true
      t.string :external_visitor_id
      t.string :name
      t.string :email
      t.string :phone
      t.string :contact_method
      t.string :time_zone
      t.inet :ip_address
      t.string :user_agent
      t.string :referrer_url
      t.integer :status, null: false, default: 0
      t.datetime :first_seen_at
      t.datetime :last_seen_at
      t.timestamps
    end

    add_index :leads, [:web_property_id, :email]
    add_index :leads, [:web_property_id, :status]
    add_index :leads, :created_at

    create_table :lead_sessions do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :web_property, null: false, foreign_key: true
      t.references :intake_schema, null: false, foreign_key: true
      t.string :session_token, null: false
      t.integer :attempt_number, null: false, default: 1
      t.jsonb :responses, null: false, default: {}
      t.integer :current_step, null: false, default: 0
      t.integer :total_steps
      t.integer :status, null: false, default: 0
      t.integer :estimated_cost_cents
      t.string :currency, null: false, default: "USD"
      t.boolean :pii_detected, null: false, default: false
      t.datetime :started_at
      t.datetime :completed_at
      t.timestamps
    end

    add_index :lead_sessions, :session_token, unique: true
    add_index :lead_sessions, [:lead_id, :attempt_number], unique: true
    add_index :lead_sessions, [:web_property_id, :status]
    create_table :messages do |t|
      t.references :lead_session, null: false, foreign_key: true
      t.string :sender_type, null: false
      t.references :llm_model, null: true, foreign_key: true
      t.string :intent
      t.text :content
      t.string :field_key
      t.jsonb :field_value
      t.jsonb :metadata, null: false, default: {}
      t.boolean :pii_detected, null: false, default: false
      t.timestamps
    end

    add_index :messages, [:lead_session_id, :created_at]
    add_index :messages, :field_key

    create_table :email_deliveries do |t|
      t.references :web_property, null: false, foreign_key: true
      t.references :lead, null: false, foreign_key: true
      t.references :lead_session, null: false, foreign_key: true
      t.string :email, null: false
      t.string :template_key, null: false
      t.string :template_version
      t.integer :status, null: false, default: 0
      t.string :provider
      t.string :provider_message_id
      t.integer :retries_count, null: false, default: 0
      t.string :error_class
      t.text :error_message
      t.datetime :queued_at
      t.datetime :sent_at
      t.datetime :failed_at
      t.timestamps
    end

    add_index :email_deliveries, [:lead_session_id, :status]
    add_index :email_deliveries, [:web_property_id, :created_at]
    add_index :email_deliveries, :provider_message_id

    create_table :lead_consents do |t|
      t.references :lead, null: false, foreign_key: true
      t.references :lead_session, null: true, foreign_key: true
      t.string :consent_type, null: false
      t.boolean :accepted, null: false, default: false
      t.datetime :accepted_at
      t.string :policy_version
      t.string :source
      t.inet :ip_address
      t.string :user_agent
      t.timestamps
    end

    add_index :lead_consents, [:lead_id, :consent_type, :created_at], name: "index_lead_consents_lookup"

    create_table :audit_events do |t|
      t.references :web_property, null: true, foreign_key: true
      t.references :lead, null: true, foreign_key: true
      t.references :lead_session, null: true, foreign_key: true
      t.string :event_type, null: false
      t.string :actor_type
      t.string :actor_id
      t.string :request_id
      t.inet :ip_address
      t.jsonb :metadata, null: false, default: {}
      t.datetime :occurred_at, null: false
      t.timestamps
    end

    add_index :audit_events, [:web_property_id, :occurred_at]
    add_index :audit_events, [:lead_id, :occurred_at]
    add_index :audit_events, [:lead_session_id, :occurred_at]
    add_index :audit_events, :event_type
  end
end
