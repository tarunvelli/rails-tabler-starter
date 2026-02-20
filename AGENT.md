# Qualified.at — Lead Qualification Platform

This document defines the product and data model direction for the Rails application in this repository.

## Product Summary

Qualified.at is a white-label lead-qualification platform for professional services businesses.

1. A customer creates an account on Qualified.at.
2. The customer configures one or more embedded qualification widgets for their external websites.
3. A lead starts an intake flow from the embedded widget.
4. The flow uses JSON Schema to drive both validation and UI behavior.
5. The system calculates an estimate and sends it by email.
6. The lead can optionally provide contact details for follow-up.

## Naming Decision (Important)

`spaces` are renamed to `sites` in the Rails data model.

- Old meaning: `space` = tenant organization/workspace
- New meaning: `site` = tenant organization/workspace

To avoid naming collision with a customer's external website, we use `web_properties` for embeddable target domains.

## Core Entities

### Platform Tenant

`sites` (renamed from `spaces`)

- top-level tenant/account
- owns users via roles/user_roles
- owns billing subscription
- owns many `web_properties`

### Customer External Website

`web_properties`

- belongs_to `site`
- stores domain and embed configuration
- stores allowed origins
- stores embed secret metadata
- owns many `intake_schemas`
- owns many `leads`

### Intake Schema

`intake_schemas`

- belongs_to `web_property`
- versioned JSON Schema documents
- status: `draft`, `active`, `archived`
- exactly one active schema per web_property
- includes optional extracted pricing metadata (`x-pricing`)

### Lead and Attempt Lifecycle

`leads`

- belongs_to `web_property`
- anonymous-first; identity can be collected later
- stores contact fields and request metadata (IP/user agent/referrer)

`lead_sessions`

- belongs_to `lead`
- belongs_to `web_property`
- belongs_to `intake_schema`
- one lead can have multiple attempts
- stores response state, progress, status, and estimate

`messages`

- belongs_to `lead_session`
- optional belongs_to `llm_model`
- captures user/system/llm messages and structured field-level answers

### LLM Configuration

`llm_models`

- global model catalog (provider + model id + capabilities)

`web_property_llm_configs`

- per-web-property model binding and fallback order
- stores encrypted credential reference and runtime limits
- supports site-specific model routing

### Email Delivery

`email_deliveries`

- belongs_to `lead_session`
- tracks estimate email generation and sending status
- includes provider message id, retries, and error details

### Compliance and Audit

`lead_consents`

- belongs_to `lead`
- stores consent type, accepted_at, policy version, and source context

`audit_events`

- immutable event log for sensitive operations (PII, redactions, exports, deletions)

## JSON Schema Rules

The intake schema is Draft 2020-12 JSON Schema plus controlled extension keys:

- `ui_element` (rendering hint, e.g. `radio`, `checkboxes`)
- `cost_per_item` (constant pricing component)
- `cost_formula` (expression in constrained formula language)
- `x-pricing` (top-level pricing tiers/notes)

### Security Rule for Formulas

Do not execute formulas with Ruby `eval`.

Use a constrained expression evaluator with:

- explicit allowed variables
- explicit allowed functions
- deterministic numeric result
- no file/network/object access

## Intake Flow

1. Lead opens widget iframe from an authorized origin.
2. Optional free-text intake is parsed by LLM to prefill known fields.
3. Remaining required fields are asked in schema-defined order.
4. Server validates incremental payload against active schema.
5. Estimate is computed from schema pricing metadata.
6. Contact details are collected at the end.
7. Estimate email is queued and delivery is tracked.

## Embed/Auth Requirements

- `web_properties.allowed_origins` enforced for iframe/API requests
- signed embed token includes `web_property_public_id`, origin, expiry
- token signature secret is rotated and versioned
- rejected requests are logged in `audit_events`

## Technical Conventions

- Ruby 4.0.1
- Rails 8.1.x
- PostgreSQL
- RSpec (not minitest)
- JSON keys in snake_case
- Jinja2 (`.j2`) prompts

## Implementation Note

Current repository has core auth/billing tables already. Qualification-domain tables are added via new migrations.
