---
name: requirements-validation
description: >
  Run completeness verification on a specification folder. Three perspectives
  (traceability, integration completeness, NFR coverage), up to 3 passes,
  fix-as-you-go. Produces COMPLETENESS_REPORT.md with PASS or GAPS_FOUND verdict.
---

# Requirements Validation

When invoked, run the requirements completeness spiral on a specification folder.

If arguments are provided, treat them as the path to the specification folder.
If no path is provided, use the most recently modified folder in `.specifications/`.

Execute three verification perspectives, run up to 3 passes, fix small gaps inline,
surface larger gaps to the user. Produce `COMPLETENESS_REPORT.md` with a PASS or
GAPS_FOUND verdict.

---

## Spiral Mechanism

The completeness assessment uses a spiral approach rather than a single-pass checklist.

**Three perspectives** examine the specification from different angles:
1. Requirement Traceability — Can every goal be traced through use cases to testable requirements?
2. Integration Completeness — Is every external system specified well enough to build against?
3. NFR Coverage — Are non-functional requirements measurable and comprehensive?

**Fix-as-you-go:** When the assessment finds a gap that can be fixed without user input
(missing diagram for a well-described flow, adjective-only NFR that has enough context to
make measurable), the agent fixes it immediately and records the fix. Gaps that require
user input are flagged for review.

**Max 3 passes:** The spiral runs up to 3 times. Each pass re-examines all three perspectives.
Fixes applied in pass N are verified in pass N+1.

**Exit conditions:**
- **PASS** — All traces complete, all integrations specified, all NFR categories covered
  with measurable requirements. No flags remain.
- **GAPS_FOUND** — After 3 passes, some gaps remain that require user input or decisions
  that cannot be made by the agent. All remaining gaps are documented with their flags.

**Sufficiency test:** The guiding question for every check is: "Could a development team
implement this without making undocumented assumptions?" If the answer is no, a flag is raised.

---

## Perspective 1: Requirement Traceability

For each element in the SRD, verify that it connects to the elements above and below it
in the traceability chain.

### Checks

**Goal to Use Case:**
Every goal stated in the SRD must trace to at least one use case that, when implemented,
advances that goal.
- Flag: `UNTRACEABLE_GOAL` — A goal exists with no use case connected to it.
- Fix strategy: Review use cases to find implicit connections, or flag for user to
  identify which use case serves this goal.

**Use Case to Diagram:**
Every use case with a multi-step flow must have at least one supporting diagram (process
flow or sequence diagram) that visualises the flow.
- Flag: `UNDIAGRAMMED_USE_CASE` — A use case has a described flow but no diagram.
- Fix strategy: If the basic flow is described in enough detail, generate the diagram
  immediately. Record as a fix.

**Integration to Sequence Diagram:**
Every integration with an external system must have a sequence diagram showing the
interaction pattern, including error scenarios.
- Flag: `UNDIAGRAMMED_INTEGRATION` — An integration is described but has no sequence diagram.
- Fix strategy: If protocol, data format, and error handling are specified, generate the
  diagram. Otherwise, flag for user.

**Lifecycle Entity to State Diagram:**
Every entity that has distinct lifecycle states (e.g., order: draft, submitted, processing,
completed, cancelled) must have a state diagram.
- Flag: `MISSING_STATE_MODEL` — An entity has lifecycle states described in text but no
  state diagram.
- Fix strategy: If states and transitions are described, generate the diagram. Record as fix.

**Feature to Functional Requirement:**
Every feature must have at least one functional requirement with acceptance criteria that
could be used to write a test.
- Flag: `UNTESTABLE_FEATURE` — A feature is described but has no functional requirement
  with acceptance criteria.
- Fix strategy: If the feature description is detailed enough, draft the requirement and
  acceptance criteria. Flag for user verification.

---

## Perspective 2: Integration Completeness

For each external system referenced in the SRD, verify that the integration is specified
completely enough to implement.

### Checks Per Integration

**Protocol specified?**
The communication protocol must be explicitly stated: REST, GraphQL, gRPC, webhook,
message queue (RabbitMQ, Kafka, SQS), SMTP, file transfer (SFTP, S3), or other.
- Flag: `AMBIGUOUS_PROTOCOL` — The integration mentions communication but does not specify
  the protocol.

**Authentication specified?**
How the system authenticates with the external service must be stated: API key, OAuth 2.0
(which flow), bearer token, mutual TLS, certificate, basic auth, or no authentication.
- Flag: `UNDERSPECIFIED_INTEGRATION` — Protocol is specified but authentication is not.

**Error handling specified?**
What happens when the integration fails must be defined:
- Timeout duration (how long to wait before giving up)
- Retry policy (how many retries, backoff strategy)
- Fallback behaviour (what the system does if the integration is unavailable)
- Circuit breaker (whether to stop trying after repeated failures)
- Flag: `MISSING_ERROR_HANDLING` — No error handling specified for this integration.

**Data format specified?**
The format of data exchanged must be defined: JSON (with schema or example), XML,
protobuf, CSV, binary, or other.
- Flag: `UNDERSPECIFIED_INTEGRATION` — Data format not specified.

**Sync/async specified?**
Whether the interaction is synchronous (request-response, caller waits) or asynchronous
(fire-and-forget, callback, polling) must be stated.
- Flag: `UNDERSPECIFIED_INTEGRATION` — Timing model not specified.

### Fix Strategy

If the SRD contains enough context to infer a missing detail (e.g., "calls the Stripe API"
implies REST + JSON), the agent fills it in and records the fix. If the detail cannot be
inferred, the gap is flagged for user review.

---

## Perspective 3: NFR Coverage

Verify that non-functional requirements are comprehensive and measurable. The specification
must include at least one measurable requirement in each of the following categories.

### Minimum NFR Categories

**Performance:**
Response time, throughput, or latency targets with specific thresholds.
- Good: "API responses < 200ms at p95 under normal load"
- Bad: "The system should be fast"
- Flag: `UNMEASURABLE_NFR` — Requirement uses an adjective instead of a threshold.
- Flag: `MISSING_NFR_CATEGORY` — No performance requirements specified.

**Scalability:**
Concurrent user targets, data volume expectations, or growth rate projections.
- Good: "Support 10,000 concurrent users with < 5% degradation"
- Bad: "The system should scale"
- Flag: `UNMEASURABLE_NFR` — No specific scale targets.
- Flag: `MISSING_NFR_CATEGORY` — No scalability requirements specified.

**Security:**
Authentication method, authorisation model, encryption requirements, compliance frameworks.
- Good: "All API endpoints require OAuth 2.0 bearer tokens. Data encrypted at rest using AES-256."
- Bad: "The system should be secure"
- Flag: `UNMEASURABLE_NFR` — Security described as an adjective.
- Flag: `MISSING_NFR_CATEGORY` — No security requirements specified.

**Availability:**
Uptime SLA, recovery time objective (RTO), recovery point objective (RPO).
- Good: "99.9% monthly uptime. RTO: 4 hours. RPO: 1 hour."
- Bad: "The system should always be available"
- Flag: `UNMEASURABLE_NFR` — No specific availability targets.
- Flag: `MISSING_NFR_CATEGORY` — No availability requirements specified.

**Data:**
Retention policy, backup frequency, privacy requirements (GDPR, CCPA, HIPAA).
- Good: "User data retained for 7 years. Daily backups with 30-day retention. GDPR compliant — right to deletion within 30 days."
- Bad: "Data should be backed up"
- Flag: `UNMEASURABLE_NFR` — No specific data management targets.
- Flag: `MISSING_NFR_CATEGORY` — No data requirements specified.

### Fix Strategy

- `UNMEASURABLE_NFR`: If context exists in the SRD to infer a threshold, propose one and
  flag for user confirmation. If not, flag for user input.
- `MISSING_NFR_CATEGORY`: Flag for user. The agent cannot invent NFRs without user input.

---

## Content Quality Verification

In addition to the three requirement perspectives, verify that all generated artifacts
comply with the Content Quality Standard (CQ-01 through CQ-06):

- **CQ-01:** Every artifact over 50 lines has a summary section
- **CQ-02:** Detail sections use stable identifiers for traceability
- **CQ-03:** Prose paragraphs vary sentence rhythm (no 3+ consecutive same-band sentences)
- **CQ-05:** No AI-tell anti-patterns in prose (filler phrases, excessive hedging, empty emphasis)

Content quality failures are flags like any other gap — fix inline where possible, flag for
review where not.

---

## Output Format

The completeness assessment produces `COMPLETENESS_REPORT.md` in the specification folder.

```
REQUIREMENTS COMPLETENESS ASSESSMENT
Specification: {name}
Date: {date}
Passes completed: {1|2|3}

VERDICT: PASS | GAPS_FOUND

--- PERSPECTIVE 1: REQUIREMENT TRACEABILITY ---
[COMPLETE] Goal G-01 → UC-01, UC-02 → sequence-diagram SD-01, process-flow PF-01
[UNTRACEABLE_GOAL] Goal G-03 — no use case traces to this goal
[UNDIAGRAMMED_USE_CASE] UC-05 — has basic flow but no diagram
[MISSING_STATE_MODEL] Order entity — states described in UC-02 but no state diagram
[UNTESTABLE_FEATURE] F-07 — feature described but no functional requirement with acceptance criteria

--- PERSPECTIVE 2: INTEGRATION COMPLETENESS ---
[COMPLETE] Stripe integration — protocol, auth, errors, format, sync all specified
[UNDERSPECIFIED_INTEGRATION] Email service — protocol specified but no error handling
[AMBIGUOUS_PROTOCOL] Analytics service — "sends data" but protocol not specified
[MISSING_ERROR_HANDLING] Payment webhook — no timeout or retry policy specified

--- PERSPECTIVE 3: NFR COVERAGE ---
[COMPLETE] Performance — "API responses < 200ms at p95" (measurable)
[COMPLETE] Security — "OAuth 2.0 + AES-256 at rest" (measurable)
[MISSING_NFR_CATEGORY] Scalability — no requirements specified
[UNMEASURABLE_NFR] Availability — "system should be highly available" (adjective, not threshold)
[MISSING_NFR_CATEGORY] Data — no retention or backup requirements specified

--- CONTENT QUALITY ---
[COMPLETE] SRD.md — summary self-sufficient, rhythm varied, no AI-tell patterns
[CQ_FLAG] HANDOVER.md — missing summary section (CQ-01)

--- FIXES APPLIED ---
Pass 1:
  Fix 1: Generated sequence diagram for Stripe payment flow (was UNDIAGRAMMED_INTEGRATION)
  Fix 2: Generated state diagram for Order entity (was MISSING_STATE_MODEL)
  Fix 3: Added performance NFR for database queries based on SRD context

Pass 2:
  Fix 4: Generated process flow diagram for UC-05 checkout flow (was UNDIAGRAMMED_USE_CASE)
  Fix 5: Added summary section to HANDOVER.md (was CQ_FLAG)

--- REMAINING GAPS ---
1. [UNTRACEABLE_GOAL] Goal G-03 — user input required
2. [MISSING_NFR_CATEGORY] Scalability — user must specify targets
3. [UNMEASURABLE_NFR] Availability — needs specific uptime percentage and RTO/RPO
4. [MISSING_NFR_CATEGORY] Data — retention, backup, and privacy requirements not discussed
```

### Report Rules

- Every item in the report must reference the specific SRD element by identifier (G-01, UC-05, etc.)
- Fixes applied must reference what they fixed and which flag they resolved
- Remaining gaps must include enough context for the user to provide the missing information
- The verdict is PASS only when zero flags remain after all passes
- If GAPS_FOUND, the remaining gaps section must be actionable — each gap states what
  information is needed from the user

---

## Version History

| Date | Change | Author |
|------|--------|--------|
| 2026-03-13 | Initial version | Standards team |
| 2026-03-13 | Renamed from requirements-completeness. Merged verify command. Added Content Quality verification. | Standards team |
