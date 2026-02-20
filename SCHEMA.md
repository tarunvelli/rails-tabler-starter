# Database Schema Design

This document is the canonical schema specification for the Qualified.at Rails app.

## Existing Foundation Tables

Already present before this phase:

- `users`
- `roles`
- `user_roles`
- `plans`
- `subscriptions`
- `app_settings`
- `active_storage_*`

## Rename Phase

`spaces` is renamed to `sites`.

Column renames:

- `roles.space_id` -> `roles.site_id`
- `user_roles.space_id` -> `user_roles.site_id`
- `subscriptions.space_id` -> `subscriptions.site_id`

Semantics:

- `sites` now represents the tenant organization/workspace.
- A tenant's external websites are modeled by `web_properties`.

## New Tables

### `web_properties`

External customer websites that embed the widget.

- `id` bigint PK
- `site_id` bigint NOT NULL FK -> `sites(id)`
- `name` string NOT NULL
- `public_id` uuid NOT NULL UNIQUE
- `domain` string
- `status` integer NOT NULL default 0 (`active`, `archived`)
- `allowed_origins` text[] NOT NULL default []
- `embed_config` jsonb NOT NULL default {}
- `embed_secret_digest` string
- `embed_secret_version` integer NOT NULL default 1
- `embed_token_ttl_seconds` integer NOT NULL default 900
- `pii_retention_days` integer NOT NULL default 365
- timestamps

Indexes:

- `site_id`
- unique `public_id`
- `domain`
- gin `allowed_origins`

### `intake_schemas`

Versioned JSON schema definitions per web property.

- `id` bigint PK
- `web_property_id` bigint NOT NULL FK -> `web_properties(id)`
- `version` integer NOT NULL
- `name` string
- `json_schema` jsonb NOT NULL
- `pricing_config` jsonb NOT NULL default {}
- `status` integer NOT NULL default 0 (`draft`, `active`, `archived`)
- timestamps

Indexes/constraints:

- unique `[web_property_id, version]`
- partial unique active schema per web_property (`status = 1`)

### `llm_models`

Global model registry.

- `id` bigint PK
- `provider` string NOT NULL
- `model_id` string NOT NULL
- `display_name` string
- `api_endpoint` string
- `capabilities` jsonb NOT NULL default {}
- `active` boolean
- timestamps

Indexes/constraints:

- unique `[provider, model_id]`
- partial unique index where `active = true`

### `web_property_llm_configs`

Per-web-property model binding.

- `id` bigint PK
- `web_property_id` bigint NOT NULL FK -> `web_properties(id)`
- `llm_model_id` bigint NOT NULL FK -> `llm_models(id)`
- `priority` integer NOT NULL default 100
- `enabled` boolean NOT NULL default true
- `credential_ref` string
- `settings` jsonb NOT NULL default {}
- timestamps

Indexes:

- unique `[web_property_id, llm_model_id]`
- `[web_property_id, enabled, priority]`

### `leads`

Anonymous-first lead identity.

- `id` bigint PK
- `web_property_id` bigint NOT NULL FK -> `web_properties(id)`
- `external_visitor_id` string
- `name` string
- `email` string
- `phone` string
- `contact_method` string
- `time_zone` string
- `ip_address` inet
- `user_agent` string
- `referrer_url` string
- `status` integer NOT NULL default 0 (`in_progress`, `completed`, `abandoned`)
- `first_seen_at` datetime
- `last_seen_at` datetime
- timestamps

Indexes:

- `web_property_id`
- `[web_property_id, email]`
- `[web_property_id, status]`
- `created_at`

### `lead_sessions`

Qualification attempt records (a lead may retry).

- `id` bigint PK
- `lead_id` bigint NOT NULL FK -> `leads(id)`
- `web_property_id` bigint NOT NULL FK -> `web_properties(id)`
- `intake_schema_id` bigint NOT NULL FK -> `intake_schemas(id)`
- `session_token` string NOT NULL
- `attempt_number` integer NOT NULL default 1
- `responses` jsonb NOT NULL default {}
- `current_step` integer NOT NULL default 0
- `total_steps` integer
- `status` integer NOT NULL default 0 (`in_progress`, `completed`, `abandoned`)
- `estimated_cost_cents` integer
- `currency` string NOT NULL default 'USD'
- `pii_detected` boolean NOT NULL default false
- `started_at` datetime
- `completed_at` datetime
- timestamps

Indexes:

- unique `session_token`
- unique `[lead_id, attempt_number]`
- `[web_property_id, status]`
- `[intake_schema_id]`

### `messages`

Message log inside a lead session.

- `id` bigint PK
- `lead_session_id` bigint NOT NULL FK -> `lead_sessions(id)`
- `sender_type` string NOT NULL (`lead`, `system`, `llm`)
- `llm_model_id` bigint NULL FK -> `llm_models(id)`
- `intent` string
- `content` text
- `field_key` string
- `field_value` jsonb
- `metadata` jsonb NOT NULL default {}
- `pii_detected` boolean NOT NULL default false
- timestamps

Indexes:

- `[lead_session_id, created_at]`
- `llm_model_id`
- `field_key`

### `email_deliveries`

Delivery ledger for estimate emails.

- `id` bigint PK
- `web_property_id` bigint NOT NULL FK -> `web_properties(id)`
- `lead_id` bigint NOT NULL FK -> `leads(id)`
- `lead_session_id` bigint NOT NULL FK -> `lead_sessions(id)`
- `email` string NOT NULL
- `template_key` string NOT NULL
- `template_version` string
- `status` integer NOT NULL default 0 (`queued`, `sent`, `failed`, `bounced`)
- `provider` string
- `provider_message_id` string
- `retries_count` integer NOT NULL default 0
- `error_class` string
- `error_message` text
- `queued_at` datetime
- `sent_at` datetime
- `failed_at` datetime
- timestamps

Indexes:

- `[lead_session_id, status]`
- `[web_property_id, created_at]`
- `provider_message_id`

### `lead_consents`

Consent capture records.

- `id` bigint PK
- `lead_id` bigint NOT NULL FK -> `leads(id)`
- `lead_session_id` bigint NULL FK -> `lead_sessions(id)`
- `consent_type` string NOT NULL
- `accepted` boolean NOT NULL default false
- `accepted_at` datetime
- `policy_version` string
- `source` string
- `ip_address` inet
- `user_agent` string
- timestamps

Indexes:

- `[lead_id, consent_type, created_at]`

### `audit_events`

Immutable audit log for compliance-sensitive events.

- `id` bigint PK
- `web_property_id` bigint NULL FK -> `web_properties(id)`
- `lead_id` bigint NULL FK -> `leads(id)`
- `lead_session_id` bigint NULL FK -> `lead_sessions(id)`
- `event_type` string NOT NULL
- `actor_type` string
- `actor_id` string
- `request_id` string
- `ip_address` inet
- `metadata` jsonb NOT NULL default {}
- `occurred_at` datetime NOT NULL
- timestamps

Indexes:

- `[web_property_id, occurred_at]`
- `[lead_id, occurred_at]`
- `[lead_session_id, occurred_at]`
- `event_type`

## Integrity Rules

- One active intake schema per web_property.
- One active global llm model row at a time (optional policy).
- `lead_sessions.intake_schema_id` must belong to the same `web_property_id` as `lead_sessions.web_property_id` (enforced application-side + validation).
- `email_deliveries.email` is captured snapshot at send time (does not mutate historical records if lead email changes).

## Migration Order

1. Rename `spaces` to `sites` and rename `space_id` references.
2. Create `web_properties`.
3. Create `intake_schemas`.
4. Create `llm_models`.
5. Create `web_property_llm_configs`.
6. Create `leads`.
7. Create `lead_sessions`.
8. Create `messages`.
9. Create `email_deliveries`.
10. Create `lead_consents`.
11. Create `audit_events`.
