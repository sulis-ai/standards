# IVS Authoring Skill

> **Status:** DEPRECATED — IVS production is now embedded in solution-design Activity 3.5.
> **Canonical location:** `methodology/delivery/product/outcomes/solution-design/OUTCOME.md` § Activity 3.5
>
> This skill's 8-phase process has been merged into the solution-design outcome so that
> the outcome-orchestrator produces deep IVS artifacts without requiring a separate skill
> invocation. The process below is preserved for reference but should NOT be invoked
> independently. Use `/sulis design` or `Run sequence: product-delivery` instead.

---

## Deprecation Notice

The IVS authoring process was previously a standalone skill invoked by the `feature-lifecycle` skill during Phase 1, Step 1.5. As of 2026-03-12, the 8-phase IVS production process has been merged into the `solution-design` OUTCOME.md (Activity 3.5) with the following updates:

1. **Codebase paths updated:** `src/` → `apps/api/sulis/`
2. **Scope-awareness added:** Per-scope IVS production (backend/, frontend-web/, infrastructure/)
3. **Integrated with product STANDARDS.md:** Verification categories align with PS-01 to PS-10
4. **Self-verification gate:** Quality checklist before proceeding to Activity 3.5b

**If you need to produce an IVS**, invoke the solution-design outcome (which includes Activity 3.5) rather than this skill.

---

## Legacy Process (Reference Only)

> **WARNING:** The content below is preserved for historical reference. It references
> outdated paths (`src/services/`, `src/shared/`, `src/core/`) and does not support
> scope-partitioned IVS production. Do not use for new features.

## Required Reading

Before creating an IVS, review:

1. **`features/PLATFORM_CONVENTIONS.md`** - For API and naming conventions
   - Section 1: Naming Conventions (camelCase for JSON APIs)
   - Section 4: Authentication patterns (PolicyResolver)
   - Section 7: ServiceSpec patterns

2. **`architecture/ARCHITECTURE.md`** - Core architecture principles

## When This Skill Activates

This skill triggers when:
- User requests "create IVS", "implementation spec", "verification spec"
- After DESIGN.md is approved (Approval Gate 2)
- Before backend-development begins
- User asks "how will this be verified" or "what are the production requirements"

## Skill Context

The IVS (Implementation & Verification Specification) is the missing link between:
- **DESIGN.md** → What to build (requirements, architecture)
- **IVS.md** → How to build it AND how to verify it's production-ready
- **Code** → The implementation

Without IVS, implementations have:
- Stubbed adapters without documentation
- Missing IAM permissions causing production failures
- No observability requirements
- No reliability requirements
- No clear production readiness criteria

## Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 0: C4 Architecture Model                                  │
│  Document architecture at all four C4 levels:                    │
│  → Level 1: System Context (actors, external systems)            │
│  → Level 2: Container (high-level technical building blocks)     │
│  → Level 3: Component (internal structure + dependencies table)  │
│  → Level 4: Code (implementation classes, interfaces)            │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 0.5: Dependency Analysis & Abstraction Opportunities      │
│  Proactively identify technical debt before implementation:      │
│  → Dependency Location Analysis (misplaced utilities)            │
│  → Pattern Consistency Analysis (duplicate implementations)      │
│  → Code Smell Detection (feature envy, shotgun surgery)          │
│  → SOLID Principle Check (interface/abstraction gaps)            │
│  → Generate Recommendations (with priority levels)               │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 0.6: Codebase-Wide Health Check                           │
│  Run systematic checks across entire codebase:                   │
│  → Shared Module Adoption (errors, auth, logger)                 │
│  → Duplicate Implementation Check (patterns this feature adds)   │
│  → Technical Debt Registry Review (blocking items?)              │
│  → Health Check Summary (proceed/block decision)                 │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 1: Infrastructure Analysis                                │
│  Analyze DESIGN.md for cloud integration points                  │
│  → Identify GCP services, APIs, IAM requirements                 │
│  → Document SDK vs REST API decisions                            │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 2: Port-to-Implementation Mapping                         │
│  For each port method:                                           │
│  → Map to specific GCP API calls                                 │
│  → Define error code mappings                                    │
│  → Specify retry policies                                        │
│  → Document implementation status (Complete/Partial/Stub)        │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 3: Security Verification Requirements                     │
│  Define verification for:                                        │
│  → Authentication (SEC-AUTH-*)                                   │
│  → Authorization (SEC-AUTHZ-*)                                   │
│  → Data Protection (SEC-DATA-*)                                  │
│  → Audit Trail (SEC-AUDIT-*)                                     │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 4: Observability Verification Requirements                │
│  Define verification for:                                        │
│  → Logging (OBS-LOG-*)                                           │
│  → Metrics (OBS-MET-*)                                           │
│  → Tracing (OBS-TRACE-*)                                         │
│  → Alerting (OBS-ALERT-*)                                        │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 5: Reliability Verification Requirements                  │
│  Define verification for:                                        │
│  → Error Handling (REL-ERR-*)                                    │
│  → Fault Tolerance (REL-FT-*)                                    │
│  → Recovery (REL-REC-*)                                          │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 6: Performance & Operational Requirements                 │
│  Define:                                                         │
│  → Latency SLOs                                                  │
│  → Throughput requirements                                       │
│  → Resource limits                                               │
│  → Deployment requirements                                       │
│  → Configuration requirements                                    │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 7: Ontology Verification Requirements                     │
│  Define verification for:                                        │
│  → Operation Metadata (ONT-OP-*)                                 │
│  → Entity Lifecycle (ONT-LC-*)                                   │
│  → Error Catalog (ONT-ERR-*)                                     │
│  → HATEOAS Navigation (ONT-NAV-*)                                │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 8: Production Guardian Checklist                          │
│  Create pre-deployment verification checklist:                   │
│  → All blocking checks defined                                   │
│  → Test references linked                                        │
│  → Decision matrix complete                                      │
└─────────────────────────────────────────────────────────────────┘
```

## Phase Details

### Phase 0: C4 Architecture Model

**Purpose:** Provide complete architectural context at all four C4 levels, ensuring developers and AI agents understand where this feature fits in the overall system.

**Inputs Required:**
- `DESIGN.md` Section 7 (Solution Design)
- `PR_FAQ.md` (Actors and external systems)
- `architecture/ARCHITECTURE.md` (System context)

**Actions:**
1. **Level 1 (Context):** Identify and diagram:
   - External actors (users, AI agents, systems)
   - External systems the feature interacts with
   - System boundary
2. **Level 2 (Container):** Diagram:
   - Where this feature's module(s) fit in the overall service architecture
   - Relationships to other containers (API, Workflow, Storage services)
   - Data stores and external integrations
3. **Level 3 (Component):** Document with **clean diagram + dependencies table**:
   - Internal components and their relationships (diagram)
   - External dependencies as a separate table (not in diagram)
   - See "Level 3 Best Practice" below
4. **Level 4 (Code):** Document (often in DESIGN.md already):
   - Type definitions, class diagrams
   - Interface specifications

**Level 3 Best Practice - Clean Diagram + Dependencies Table:**

> **Important:** Keep the Level 3 component diagram focused on INTERNAL structure only.
> External/shared dependencies should be documented in a separate table, not cluttering the diagram.

**Why this pattern:**
- Diagrams stay clean and focused on what's inside the module
- Dependencies table is easier to maintain and can include more detail
- Avoids C4 notation confusion (`System_Ext` vs `Container_Ext`)
- Tables can show specific files, methods used, and purpose

**Level 3 Structure:**
```markdown
### 0.3 Level 3: Component Overview

#### 0.3.1 Internal Components

[Mermaid diagram with ONLY internal components - no external refs]

**Components:**
| Component | File | Responsibility |
|-----------|------|----------------|

#### 0.3.2 External Dependencies

| Dependency | Location | Used By | Purpose |
|------------|----------|---------|---------|
| Secrets Module | `src/services/secrets/` | `resolver.py` | Credential resolution |
| Logger Sanitization | `src/shared/logger/` | `routes.py` | Sensitive data redaction |
| FastAPI | External package | `routes.py` | HTTP framework |
```

**Mermaid C4 Diagram Templates:**

```mermaid
%% Level 1: System Context
C4Context
    title System Context for {Feature}

    Person(user, "User Type", "Description")
    System_Ext(external, "External System", "Description")

    System_Boundary(platform, "Platform") {
        System(feature, "Feature Module", "What it does")
    }

    Rel(user, feature, "Uses")
    Rel(feature, external, "Integrates with")
```

```mermaid
%% Level 2: Container Diagram
C4Container
    title Container Diagram for {Feature}

    Container(api, "API Service", "FastAPI", "HTTP endpoints")
    Container(workflow, "Workflow Service", "LangGraph", "Orchestration")

    Container_Boundary(core, "Core Modules") {
        Container(feature, "Feature Module", "Python", "Description")
    }

    Rel(api, feature, "Imports")
    Rel(workflow, feature, "Uses")
```

**Output Sections:**
- IVS Section 0.1: System Context Diagram
- IVS Section 0.2: Container Diagram
- IVS Section 0.3: Component Overview
- IVS Section 0.4: Code-Level Summary
- IVS Section 0.5: C4 Model Verification Checklist
- IVS Section 0.6: Dependency Analysis & Abstraction Opportunities

---

### Phase 0.5: Dependency Analysis & Abstraction Opportunities

**Purpose:** Proactively identify misplaced dependencies, inconsistent patterns, and abstraction opportunities BEFORE implementation begins. This prevents technical debt accumulation.

**Inputs Required:**
- IVS Section 0.3.2 (External Dependencies table)
- Codebase search for similar patterns
- Existing shared modules (`src/shared/`, `src/core/`)

**Analysis Steps:**

#### Step 1: Dependency Location Analysis

For each external dependency, ask:

| Question | Red Flag | Action |
|----------|----------|--------|
| Is this dependency in `src/shared/` or `src/core/`? | No - it's buried in a specific service | Consider extraction to shared |
| Is this a general-purpose utility? | Yes, but it's in a service-specific location | Candidate for abstraction |
| Do multiple features reference this? | Yes, reaching into another service | Definite abstraction needed |
| Would changes here require changes elsewhere? | Yes, shotgun surgery required | Missing shared abstraction |

#### Step 2: Pattern Consistency Analysis

Search the codebase for similar functionality:

```bash
# Example: Find all sensitive data handling
grep -r "sanitize\|redact\|sensitive\|secret" src/ --include="*.py"

# Example: Find all retry/resilience logic
grep -r "retry\|backoff\|circuit" src/ --include="*.py"

# Example: Find all caching implementations
grep -r "cache\|ttl\|expire" src/ --include="*.py"
```

For each pattern found, document:
- How many implementations exist?
- Are they consistent in approach?
- Is there a canonical shared implementation?

#### Step 3: Code Smell Detection

Check for these architectural smells:

| Smell | Detection | Example |
|-------|-----------|---------|
| **Feature Envy** | Module A imports from deep within Module B | `from src.services.storage.service_layer.detector import X` |
| **Shotgun Surgery** | Pattern change requires edits in 3+ files | Updating auth patterns across services |
| **Divergent Change** | Module changes for unrelated reasons | Storage module changing for security pattern updates |
| **Inappropriate Intimacy** | Modules know too much about each other's internals | Direct access to private implementation details |
| **Duplicate Logic** | Same code in multiple places with slight variations | Multiple retry implementations |

#### Step 4: SOLID Principle Check

| Principle | Question | Violation Signal |
|-----------|----------|------------------|
| **Single Responsibility** | Does this module do ONE thing? | Module handles unrelated concerns |
| **Open/Closed** | Can we extend without modifying? | Must edit existing code to add behavior |
| **Liskov Substitution** | Can implementations be swapped? | No common interface exists |
| **Interface Segregation** | Do clients use all methods? | Clients depend on unused functionality |
| **Dependency Inversion** | Do we depend on abstractions? | High-level depends on low-level details |

#### Step 5: Generate Recommendations

For each issue found, document:

```markdown
| Issue | Location | Impact | Recommendation | Priority |
|-------|----------|--------|----------------|----------|
| Misplaced utility | `src/services/X/util.py` | Feature envy from 3 services | Move to `src/shared/X/` | High |
| Duplicate pattern | `src/services/*/retry.py` | 4 different retry implementations | Create `src/shared/resilience/` | Medium |
| Missing interface | Various auth handlers | No common contract | Define `AuthHandler` protocol | High |
```

**Output Sections:**
- IVS Section 0.6.1: Dependency Location Analysis
- IVS Section 0.6.2: Pattern Consistency Analysis
- IVS Section 0.6.3: Code Smell Detection
- IVS Section 0.6.4: Abstraction Recommendations

**Decision Gate:**
Before proceeding to Phase 1, review abstraction recommendations:
- **High priority items:** Should be addressed as part of this feature OR tracked as prerequisite
- **Medium priority items:** Track as follow-up technical debt ticket
- **Low priority items:** Document for future consideration

---

### Phase 0.6: Codebase-Wide Health Check

**Purpose:** Run systematic checks across the ENTIRE codebase to identify architectural inconsistencies that could affect this feature or be exacerbated by its implementation.

**When to Perform:**
- For any feature that creates new shared utilities
- For any feature that adds new patterns (error handling, caching, validation)
- For any feature touching cross-cutting concerns (auth, logging, security)
- Recommended for ALL features to maintain codebase health awareness

**Health Check Steps:**

#### Step 1: Shared Module Adoption Check

Run these commands:
```bash
# Check shared errors adoption
grep -r "from src.shared.errors" src/services --include="*.py" | wc -l

# Check for custom error definitions (should be minimal)
grep -r "class.*Error\|class.*Exception" src/services --include="*.py" | grep -v test | wc -l

# Check authorization setup patterns
ls src/services/*/entrypoints/http/authorization.py 2>/dev/null | wc -l
```

Fill in this table:
| Shared Module | Services Using | Target | Gap? |
|---------------|----------------|--------|------|
| `src/shared/errors/` | | All | |
| `src/shared/authorization/` | | All | |
| `src/shared/logger/` | | All | |

#### Step 2: Duplicate Implementation Check

Before adding new patterns, search for existing implementations:
```bash
# If adding caching
grep -r "TTLCache\|lru_cache\|cache.*ttl" src/ --include="*.py" | grep -v test

# If adding validation
grep -r "class.*Validator\|def validate" src/ --include="*.py" | grep -v test

# If adding resilience patterns
grep -r "retry\|backoff\|circuit" src/ --include="*.py" | grep -v test
```

Document findings:
| Pattern | Existing Implementations | Should Consolidate? |
|---------|--------------------------|---------------------|
| | | |

#### Step 3: Technical Debt Registry Check

Review `architecture/TECHNICAL_DEBT.md`:

| Debt Item | Affects This Feature? | Action Required |
|-----------|----------------------|-----------------|
| TD-ARCH-001 | | |
| TD-UNUSED-001 | | |
| TD-DUP-001 | | |

- Any blocking items must be resolved first
- New debt discovered should be added to registry

#### Step 4: Health Check Summary

Fill in IVS Section 0.7.5:
| Check | Status | Notes |
|-------|--------|-------|
| Shared Module Adoption | ✅/⚠️/❌ | |
| Duplicate Implementations | ✅/⚠️/❌ | |
| Technical Debt Compatibility | ✅/⚠️/❌ | |

**Decision:**
- [ ] Proceed - All checks pass
- [ ] Proceed with conditions - Follow-up items tracked
- [ ] Block - Address issues first

**Output Sections:**
- IVS Section 0.7.1: Shared Module Adoption Check
- IVS Section 0.7.2: Duplicate Implementation Check
- IVS Section 0.7.3: Authorization Boilerplate Check
- IVS Section 0.7.4: Technical Debt Registry Check
- IVS Section 0.7.5: Health Check Summary

---

### Phase 1: Infrastructure Analysis

**Inputs Required:**
- `DESIGN.md` Section 7 (Solution Design)
- `DESIGN.md` Section 8 (Technical Decisions)
- `DESIGN.md` Section 9 (Component Breakdown)

**Actions:**
1. Identify all external service integrations
2. Document GCP service requirements
3. List required IAM roles and permissions
4. Verify Terraform resources exist or create tickets

**Output Sections:**
- IVS Section 1.1: Cloud Services Required
- IVS Section 1.2: Authentication & Authorization
- IVS Section 1.3: IAM Permissions Required
- IVS Section 1.4: Environment Variables Required
- IVS Section 1.5: SDK vs REST API Decision

### Phase 2: Port-to-Implementation Mapping

**Inputs Required:**
- Port interface file (`domain/ports/*.py`)
- Existing adapter implementations (if any)
- GCP API documentation

**Actions:**
1. For each port method, document:
   - GCP API endpoint
   - Request/response mapping
   - Error code mapping
   - Retry policy
2. Determine implementation status:
   - ✅ Complete: Fully implemented
   - ⚠️ Partial: Some edge cases missing
   - ❌ Stub: Not implemented (logs warning)
3. Verify Memory/GCP adapter behavior parity

**Output Sections:**
- IVS Section 2.1: Port Method Specifications
- IVS Section 2.2: Implementation Completeness Matrix

### Phase 3: Security Verification Requirements

**Inputs Required:**
- `DESIGN.md` Section 4.2 (Non-Functional Requirements - Security)
- `DESIGN.md` Section 11.2 (Permission Definitions)
- `TEST_SCENARIOS.md` Security Scenarios

**Actions:**
1. Define authentication verification requirements
2. Define authorization verification requirements
3. Define data protection verification requirements
4. Define audit trail verification requirements
5. Create test references for each requirement

**Output Sections:**
- IVS Section 3.1: Authentication Verification
- IVS Section 3.2: Authorization Verification
- IVS Section 3.3: Data Protection Verification
- IVS Section 3.4: Audit Trail Verification

### Phase 4: Observability Verification Requirements

**Inputs Required:**
- Architecture observability patterns
- SLO definitions
- Existing logging/metrics patterns in codebase

**Actions:**
1. Define log schema and required fields
2. Define required metrics with labels and buckets
3. Define tracing span requirements
4. Define alerting thresholds

**Output Sections:**
- IVS Section 4.1: Logging Verification
- IVS Section 4.2: Metrics Verification
- IVS Section 4.3: Tracing Verification
- IVS Section 4.4: Alerting Verification

### Phase 5: Reliability Verification Requirements

**Inputs Required:**
- `DESIGN.md` Section 4.2 (Non-Functional Requirements - Reliability)
- Error handling patterns in codebase
- GCP service SLAs

**Actions:**
1. Define error handling requirements
2. Define fault tolerance requirements (timeouts, retries, circuit breakers)
3. Define recovery requirements (idempotency, consistency)

**Output Sections:**
- IVS Section 5.1: Error Handling Verification
- IVS Section 5.2: Fault Tolerance Verification
- IVS Section 5.3: Recovery Verification

### Phase 6: Performance & Operational Requirements

**Inputs Required:**
- `DESIGN.md` Section 4.2 (Non-Functional Requirements - Performance)
- Success metrics from `PR_FAQ.md`
- Cloud Run configuration

**Actions:**
1. Define latency SLOs (P50, P95, P99)
2. Define throughput requirements
3. Define resource limits
4. Define deployment requirements
5. Define configuration requirements

**Output Sections:**
- IVS Section 6: Performance Verification
- IVS Section 7: Maintainability Verification
- IVS Section 8: Operational Verification

### Phase 7: Ontology Verification Requirements

**Inputs Required:**
- `DESIGN.md` Section 8 (Ontology Integration)
- `ONTOLOGY.jsonld` from Phase 6 of solution-design
- `src/core/ontology/` for @operation decorator patterns

**Actions:**
1. Define operation metadata verification requirements (ONT-OP-*)
2. Define entity lifecycle verification requirements (ONT-LC-*)
3. Define error catalog verification requirements (ONT-ERR-*)
4. Define HATEOAS navigation verification requirements (ONT-NAV-*)
5. Define ontology export verification requirements (ONT-EXP-*)

**Output Sections:**
- IVS Section 6.1: Operation Metadata Verification
- IVS Section 6.2: Entity Lifecycle Verification
- IVS Section 6.3: Error Catalog Verification
- IVS Section 6.4: HATEOAS Navigation Verification
- IVS Section 6.5: Ontology Export Verification

**Verification Requirement IDs:**

| Category | ID Pattern | Purpose |
|----------|------------|---------|
| Operation Metadata | ONT-OP-* | All handlers use @operation decorator with required fields |
| Entity Lifecycle | ONT-LC-* | EntityLifecycle registered for stateful entities |
| Error Catalog | ONT-ERR-* | All errors in catalog with user_action |
| Navigation | ONT-NAV-* | Operations have leads_to navigation links |
| Export | ONT-EXP-* | Ontology exports as valid JSON-LD |

**Example Requirements:**

```markdown
| Requirement ID | Requirement | Verification Method | Test Reference |
|----------------|-------------|---------------------|----------------|
| ONT-OP-01 | All handlers use @operation decorator | Code inspection | `test_ont_operations_decorated` |
| ONT-OP-02 | Operations have name, description, permissions | Metadata check | `test_ont_operation_metadata` |
| ONT-OP-03 | Operations have user_guide with when_to_use | UserGuide check | `test_ont_user_guide` |
| ONT-OP-04 | Operations declare leads_to navigation | Navigation check | `test_ont_navigation` |
| ONT-LC-01 | Stateful entities have EntityLifecycle | Registry check | `test_ont_lifecycle` |
| ONT-LC-02 | Transitions have trigger operations | Transition check | `test_ont_transitions` |
| ONT-ERR-01 | All errors in error catalog | Catalog check | `test_ont_error_catalog` |
| ONT-ERR-02 | Errors have user_action | UserAction check | `test_ont_error_actions` |
| ONT-NAV-01 | CRUD operations have related links | Link check | `test_ont_crud_navigation` |
| ONT-EXP-01 | OntologyRegistry exports valid JSON-LD | Export validation | `test_ont_jsonld_export` |
```

### Phase 8: Production Guardian Checklist

**Inputs Required:**
- All previous IVS sections
- Test file structure

**Actions:**
1. Create comprehensive pre-deployment checklist
2. Define blocking vs non-blocking checks
3. Link all test references
4. Create decision matrix

**Output Sections:**
- IVS Section 9: Production Guardian Review Checklist
- IVS Section 10: Verification Test Organization

## IVS Quality Criteria

Before completing an IVS, verify:

### Completeness
- [ ] All port methods have implementation specifications
- [ ] All SEC-* requirements defined
- [ ] All OBS-* requirements defined
- [ ] All REL-* requirements defined
- [ ] All ONT-* requirements defined (ontology verification)
- [ ] Performance SLOs defined
- [ ] Production Guardian checklist complete

### Testability
- [ ] Each requirement has a test reference
- [ ] Test file locations specified
- [ ] Test markers defined
- [ ] CI/CD integration specified

### Actionability
- [ ] Developers can implement from this spec
- [ ] QE can create automated tests from this spec
- [ ] Production Guardian can verify from this spec
- [ ] Ontology is complete for LLM discoverability

## Template Location

`methodology templates/feature/IVS_TEMPLATE.md`

## Output Location

`features/{feature-name}/IVS.md`

## Integration with Other Skills

### Before IVS (Prerequisites)
- `solution-design` skill must complete:
  - DESIGN.md approved (Gate 2 passed)
  - TEST_SCENARIOS.md created

### After IVS (Triggers)
- `backend-development` skill uses IVS for:
  - Port-to-API mapping reference
  - Error handling requirements
  - Verification test requirements

- `production-guardian` skill uses IVS for:
  - Pre-deployment checklist
  - Automated verification tests
  - Deployment decision

## Example Invocation

```
User: "Create the IVS for per-platform-tenants"

Claude: I'll create the Implementation & Verification Specification for per-platform-tenants.

Let me analyze the existing design documents and create a comprehensive IVS.

[Phase 1: Analyzing DESIGN.md for infrastructure requirements...]
[Phase 2: Mapping TenantProvider port methods to GCP APIs...]
[Phase 3: Defining security verification requirements...]
[Phase 4: Defining observability verification requirements...]
[Phase 5: Defining reliability verification requirements...]
[Phase 6: Defining performance and operational requirements...]
[Phase 7: Creating Production Guardian checklist...]

IVS created at: features/per-platform-tenants/IVS.md
```

## Working with Sensitive Data

When defining SEC-DATA-* requirements for data protection, leverage the existing shared sanitization infrastructure rather than creating duplicate patterns.

### Two Complementary Approaches

| Approach | Location | Purpose | Use When |
|----------|----------|---------|----------|
| **Logger Sanitization** | `src/shared/logger/logger.py` | Unstructured text redaction | Log messages, error messages, debug output |
| **SensitiveDataDetector** | `src/services/storage/service_layer/sensitive_data_detector.py` | Structured data detection | Entity fields, API responses, serialization |

### Logger Sanitization

The logger provides regex-based pattern matching for unstructured text:

```python
from src.shared.logger.logger import sanitize_message, SECRET_PATTERNS

# SECRET_PATTERNS includes 17 compiled patterns:
# - AWS keys (AKIA...)
# - GitHub tokens (ghp_...)
# - Bearer tokens
# - JWT tokens (eyJ...)
# - Private keys (-----BEGIN PRIVATE KEY-----)
# - Passwords in URLs
# - API keys
# - Stripe keys (sk_live_...)
# - And more...

# Sanitize any string before logging or output
safe_output = sanitize_message(potentially_sensitive_string)
```

**Use for:** Unstructured log messages, error messages, debug output, any string that might accidentally contain secrets.

### SensitiveDataDetector

The detector uses the `detect-secrets` library for structured entity data:

```python
from src.services.storage.service_layer.sensitive_data_detector import (
    SensitiveDataDetector,
    SensitiveDataIssue,
)

# Three detection modes:
# - AUTO: Pattern-based detection using detect-secrets library
# - INLINE: Field name matching (password, secret, token, api_key, etc.)
# - SCHEMA: Entity-type-specific rules

detector = SensitiveDataDetector(detection_method="auto")
issues: list[SensitiveDataIssue] = detector.detect(entity_data)

if issues:
    # Handle sensitive data found
    for issue in issues:
        logger.warning(f"Sensitive data in {issue.field_path}: {issue.detector_type}")
```

**Use for:** Validating entity data before serialization, checking API responses, ensuring ServiceSpec output contains no secrets.

### IVS Data Protection Pattern

When writing SEC-DATA-* requirements, reference the shared infrastructure:

```markdown
### 3.3 Data Protection Verification

| Requirement ID | Requirement | Verification Method | Test Reference |
|----------------|-------------|---------------------|----------------|
| SEC-DATA-01 | Secret values never in serialized output | SensitiveDataDetector validation | `test_sec_no_secrets_serialized` |
| SEC-DATA-02 | Secret refs expose paths, not values | Serialization inspection | `test_sec_secret_refs_safe` |
| SEC-DATA-03 | No secrets in log messages | Logger sanitization | `test_sec_log_sanitization` |

**Implementation Note:** Use existing shared sanitization infrastructure:
- Logger sanitization (`src/shared/logger/logger.py`) for unstructured text
- SensitiveDataDetector (`src/services/storage/service_layer/sensitive_data_detector.py`) for structured validation

**Test Implementation:**
```python
def test_sec_no_secrets_serialized():
    """Verify no sensitive data in serialized output."""
    from src.services.storage.service_layer.sensitive_data_detector import SensitiveDataDetector

    detector = SensitiveDataDetector(detection_method="auto")
    serialized_output = entity.to_dict()
    issues = detector.detect(serialized_output)

    assert len(issues) == 0, f"Sensitive data found: {issues}"

def test_sec_log_sanitization():
    """Verify log messages are sanitized."""
    from src.shared.logger.logger import sanitize_message

    dangerous_message = "API key is sk_live_abc123xyz"
    safe_message = sanitize_message(dangerous_message)

    assert "sk_live_" not in safe_message
    assert "[STRIPE_KEY]" in safe_message
```
```

### Sensitive Field Names (Reference)

The SensitiveDataDetector recognizes these field names as potentially sensitive:

```python
SENSITIVE_FIELD_NAMES = {
    "password", "secret", "token", "key", "auth_token", "access_token",
    "refresh_token", "private_key", "api_key", "ssn", "social_security",
    "credit_card", "card_number", "cvv", "pin",
}
```

### Detector Plugins (Reference)

The detect-secrets library uses these plugins:

- `AWSKeyDetector` - AWS access keys
- `AzureStorageKeyDetector` - Azure storage keys
- `BasicAuthDetector` - Basic auth credentials
- `GitHubTokenDetector` - GitHub tokens
- `JwtTokenDetector` - JWT tokens
- `PrivateKeyDetector` - Private keys (RSA, EC, etc.)
- `SlackDetector` - Slack tokens
- `StripeDetector` - Stripe API keys
- `OpenAIDetector` - OpenAI API keys
- And more...

### When to Define Custom Patterns

Only define custom patterns in IVS when:
1. Domain-specific secrets not covered by existing detectors (rare)
2. Custom token formats unique to external integrations
3. Feature-specific sensitive data formats

Otherwise, always reference the shared infrastructure to avoid pattern drift and duplication.

---

## Common Patterns

### GCP API Mapping Pattern

```markdown
#### `create_tenant()`

| Aspect | Specification |
|--------|---------------|
| **Port Location** | `src/services/platform/domain/ports/tenant_provider.py` |
| **GCP API** | `identitytoolkit.googleapis.com/v2/projects/{project}/tenants` |
| **SDK Method** | `firebase_admin.tenant_mgt.create_tenant()` |
| **Implementation Status** | ✅ Complete |

**Request Mapping:**
```python
# Port signature
async def create_tenant(display_name: str) -> TenantConfig:

# Maps to Firebase Admin SDK
tenant = tenant_mgt.create_tenant(
    display_name=display_name,
    allow_password_sign_up=True,
)
```

**Error Mapping:**
| GCP Error | HTTP Status | Domain Exception |
|-----------|-------------|------------------|
| ALREADY_EXISTS | 409 | ConflictError |
| PERMISSION_DENIED | 403 | PermissionDenied |
```

### Verification Requirement Pattern

```markdown
| Requirement ID | Requirement | Verification Method | Test Reference |
|----------------|-------------|---------------------|----------------|
| SEC-AUTH-01 | Endpoints require auth | 401 without token | `test_sec_auth_required` |
```

### Production Guardian Check Pattern

```markdown
**Security Sign-off:**
- [ ] SEC-AUTH-* requirements verified (tests pass)
- [ ] SEC-AUTHZ-* requirements verified (tests pass)
- [ ] No secrets in code (gitleaks clean)
```

### Ontology Verification Pattern

```markdown
| Requirement ID | Requirement | Verification Method | Test Reference |
|----------------|-------------|---------------------|----------------|
| ONT-OP-01 | All handlers use `@operation` decorator | Code inspection | `test_ont_operations_decorated` |
| ONT-OP-02 | Operations have required metadata | Metadata check | `test_ont_operation_metadata` |
| ONT-OP-03 | Operations have `leads_to` navigation | Navigation check | `test_ont_operation_navigation` |
| ONT-OP-04 | State transitions via `causes_transition` | Transition check | `test_ont_state_transitions` |
| ONT-LC-01 | Stateful entities have EntityLifecycle | Registry check | `test_ont_lifecycle_defined` |
| ONT-ERR-01 | All errors in error catalog | Catalog check | `test_ont_error_catalog` |
| ONT-ERR-02 | Errors have `user_action` | UserAction check | `test_ont_error_user_action` |
| ONT-NAV-01 | CRUD ops have related links | Link check | `test_ont_crud_navigation` |
| ONT-EXP-01 | Valid JSON-LD export | Schema validation | `test_ont_jsonld_valid` |
```

**Production Guardian Ontology Sign-off:**
```markdown
- [ ] ONT-OP-* requirements verified (tests pass)
- [ ] ONT-LC-* requirements verified (tests pass)
- [ ] ONT-ERR-* requirements verified (tests pass)
- [ ] ONT-NAV-* requirements verified (tests pass)
- [ ] ONT-EXP-* requirements verified (tests pass)
```

## Troubleshooting

### "Can't determine GCP API"
- Check GCP documentation for the service
- Look at existing adapters for patterns
- Use Firebase Admin SDK reference
- Use Identity Platform REST API reference

### "Implementation status unclear"
- Read the adapter code
- Look for `logger.warning("not implemented")` patterns
- Check if SDK supports the operation
- Verify all error paths handled

### "Performance SLOs unknown"
- Use 200ms for simple reads
- Use 2s for operations with GCP API calls
- Use 5s for operations with multiple GCP calls
- Reference existing feature SLOs for consistency

### "Ontology requirements unclear"
- Check if handlers have `@operation` decorator
- Look for existing EntityLifecycle definitions in similar services
- Reference `methodology standards/ONTOLOGY_SPECIFICATION.md` for patterns
- Check `src/core/ontology/` for decorator usage examples
- Ensure all error codes have `user_action` explaining how to fix

### "Missing leads_to navigation"
- CRUD operations should link to related operations
- Create leads to Update, Read, Delete
- Update leads to Read
- Delete leads to List (to see remaining items)
- Reference workflow ontology for operation link patterns
