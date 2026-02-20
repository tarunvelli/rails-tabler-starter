# PLAN: Make Qualified.at Work End-to-End

This plan assumes the current state after schema/model groundwork and focuses on getting a production-credible vertical slice working as described in `AGENT.md`.

## Success Criteria

1. A customer can sign in and create a tenant (`Site`) and at least one external `WebProperty`.
2. A customer can create/version/activate JSON intake schemas for a `WebProperty`.
3. A lead can complete an embedded intake flow from an allowed origin.
4. The backend validates intake responses against active schema and computes an estimate safely.
5. The app records `Lead`, `LeadSession`, `Message`, and sends estimate email with tracked delivery status.
6. PII protections, consent capture, and audit events are active for key workflows.

## Phase 0: Stabilize Rename + Data Integrity (High Priority)

Goal: make app code consistent with the already-migrated DB (`spaces` -> `sites`).

1. Refactor controllers/routes/policies/views from `Space` to `Site`.
2. Keep backward compatibility shims only where unavoidable, then remove shims.
3. Update all strong params and form fields from `space_id` to `site_id`.
4. Update existing specs/factories still referencing old naming.
5. Add request specs to verify all renamed routes and ownership checks.

Deliverables:
- no runtime references to nonexistent `spaces` table
- green request/model suite for tenant/billing/roles flows

## Phase 1: Admin CRUD for Qualification Domain

Goal: customers can configure intake in the app.

1. Build CRUD for `WebProperty` under a `Site` context.
2. Build CRUD/versioning for `IntakeSchema`:
   - create draft
   - update draft
   - activate (deactivates previous active)
   - archive
3. Add `WebPropertyLlmConfig` management UI/API (model binding, priority, enabled).
4. Add validations and policies:
   - only site members can manage their web properties/schemas
   - one active schema per web property

Deliverables:
- customer can configure external domain + schema via app UI/API

## Phase 2: Public Embed + Session APIs

Goal: support real iframe/widget interactions safely.

1. Implement embed token issuance endpoint (signed token with `web_property_public_id`, origin, exp, nonce).
2. Implement public intake API endpoints (versioned):
   - start session
   - submit free-text
   - submit field answer
   - fetch next required question
   - complete session
3. Enforce `allowed_origins` + token signature/expiry.
4. Emit `AuditEvent` for denied origin, invalid token, replay attempts.
5. Add rate limiting to public endpoints.

Deliverables:
- secure, origin-bound embed flow with auditable rejection paths

## Phase 3: Schema Execution + Safe Estimation Engine

Goal: deterministic validation and price calculation without `eval`.

1. Add JSON Schema validator service (Draft 2020-12 compatible).
2. Build schema navigation service:
   - ordered fields
   - required/unanswered detection
   - optional skip logic hooks
3. Build formula evaluator service (safe DSL):
   - no Ruby eval
   - allowlisted functions/operators
   - numeric deterministic outputs
4. Build pricing engine:
   - `cost_per_item`
   - formula-based costs
   - top-level `x-pricing` discount tier application
5. Add unit tests with golden fixtures from `intake-types/*`.

Deliverables:
- validated responses + correct estimate for supported schemas

## Phase 4: LLM-Assisted Intake (Optional but Described)

Goal: free-text prefill and prompt-driven questioning.

1. Create provider-agnostic LLM client abstraction.
2. Implement OpenAI primary, Anthropic fallback using `WebPropertyLlmConfig` priorities.
3. Add prompt templates (`resources/prompts/*.j2`) for:
   - prefill extraction
   - follow-up question generation
4. Store LLM interactions in `messages` with metadata (latency/tokens/errors).
5. Fallback mode if LLM unavailable: plain schema labels/questions.

Deliverables:
- free-text prefill + robust fallback when LLM fails

## Phase 5: Email Delivery Pipeline

Goal: reliably send and track estimate emails.

1. Implement `EstimateMailer` templates and rendering.
2. Add background job (`Sidekiq`) to send queued `EmailDelivery` records.
3. Track state transitions: `queued` -> `sent|failed|bounced`.
4. Capture provider IDs and retry policy with capped backoff.
5. Add webhook endpoint (if provider supports) for bounce/complaint updates.

Deliverables:
- estimate emails sent with delivery ledger and retry semantics

## Phase 6: Compliance & Security Hardening

Goal: minimum acceptable operational safety.

1. Add PII detection/redaction service in intake pipeline.
2. Block prohibited patterns and log redactions in `AuditEvent`.
3. Capture consent events in `LeadConsent` (policy version + timestamp + source).
4. Add retention/deletion jobs based on `web_properties.pii_retention_days`.
5. Add structured security logging + request IDs across public endpoints.

Deliverables:
- consent + PII controls + auditable lifecycle

## Phase 7: Frontend Integration

Goal: connect existing widget/config frontend to Rails APIs.

1. Point frontend widget to Rails public intake endpoints.
2. Replace local/mock logic with server-backed session progression.
3. Preserve trigger modes (`auto`, `element`) in embed.js.
4. Add customer config UX for copying embed snippet with correct `public_id`.
5. Add E2E happy-path test: config -> embed -> complete intake -> email queued.

Deliverables:
- functional demo from customer setup to lead completion

## Phase 8: Test Strategy and CI Gates

Goal: prevent regressions while moving fast.

1. Model specs for all domain invariants (mostly done, expand DB constraint coverage).
2. Request specs for public intake endpoints and auth/policy checks.
3. Service specs for schema traversal, formula evaluation, pricing, PII detection.
4. Job/mailer specs for email lifecycle.
5. Add CI gate:
   - `bundle exec rspec`
   - lint (rubocop)
   - schema consistency checks

Deliverables:
- reliable CI signal for core product flows

## Phase 9: Rollout Plan

Goal: ship safely with progressive exposure.

1. Seed one internal `Site` + `WebProperty` for dogfooding.
2. Feature flags for:
   - LLM prefill
   - email sending
   - strict PII blocking
3. Collect metrics dashboards:
   - session start/completion rate
   - estimate generation latency
   - email send success rate
   - blocked requests by reason
4. Beta with one external customer domain.

Deliverables:
- measurable beta readiness and controlled launch

## Suggested Immediate Next 3 Tasks

1. Complete Phase 0 app-layer rename refactor (`Space` -> `Site`) and make existing app specs green.
2. Implement Phase 1 CRUD for `WebProperty` + `IntakeSchema` activation flow.
3. Implement Phase 2 public intake session endpoints with signed embed token verification.
