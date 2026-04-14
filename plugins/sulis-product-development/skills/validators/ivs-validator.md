# IVS (Implementation & Verification Specification) Validator

> **Focus:** Validates IVS.md structure, completeness, and production readiness criteria
> **Checks:** IVS-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md
> **Reference:** `features/workflows-async/IVS.md` for canonical structure

## Purpose

Ensures the IVS.md contains all required sections bridging design to production-ready implementation:
1. C4 Architecture diagrams
2. Infrastructure integration specs
3. Port-to-implementation mapping
4. Security/Observability/Reliability verification
5. Performance SLOs
6. Production Guardian checklist

## Files to Read

1. `features/{feature}/IVS.md`
2. `features/{feature}/TEST_SCENARIOS.md` (for requirement-to-test mapping)
3. `features/{feature}/DESIGN.md` (for consistency check)

---

## Validation Checks

### Section 0: C4 Architecture Model (IVS-C4-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-C4-01 | Section 0 "C4 Architecture Model" exists | BLOCKING |
| IVS-C4-02 | Level 1 System Context diagram present | BLOCKING |
| IVS-C4-03 | Actors table defined | BLOCKING |
| IVS-C4-04 | External Systems table defined | BLOCKING |
| IVS-C4-05 | Level 2 Container Diagram present | BLOCKING |
| IVS-C4-06 | Level 3 Component Overview present | BLOCKING |
| IVS-C4-07 | Components table with File/Responsibility | BLOCKING |
| IVS-C4-08 | External Dependencies table | WARNING |
| IVS-C4-09 | Level 4 Code Summary with key types | WARNING |

### Section 1: Infrastructure Integration (IVS-INFRA-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-INFRA-01 | Section 1 "Infrastructure Integration" exists | BLOCKING |
| IVS-INFRA-02 | Cloud Services Required table | BLOCKING |
| IVS-INFRA-03 | IAM Permissions Required table | BLOCKING |
| IVS-INFRA-04 | Environment Variables Required table | BLOCKING |
| IVS-INFRA-05 | Terraform/Infrastructure code examples | WARNING |
| IVS-INFRA-06 | Each env var has Required/Default/Description | BLOCKING |

### Section 2: Port-to-Implementation Mapping (IVS-PORT-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-PORT-01 | Section 2 "Port-to-Implementation Mapping" exists | BLOCKING |
| IVS-PORT-02 | Each port has location table (Port/Memory/GCP adapter) | BLOCKING |
| IVS-PORT-03 | Port Interface code examples | BLOCKING |
| IVS-PORT-04 | Implementation Completeness Matrix | BLOCKING |
| IVS-PORT-05 | Matrix shows Memory/GCP/K8s status per method | WARNING |

### Section 3: Security Verification (IVS-SEC-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-SEC-01 | Section 3 "Security Verification" exists | BLOCKING |
| IVS-SEC-02 | Authorization Verification table (SEC-AUTHZ-*) | BLOCKING |
| IVS-SEC-03 | Permission Matrix with operations | BLOCKING |
| IVS-SEC-04 | Data Protection Verification table (SEC-DATA-*) | BLOCKING |
| IVS-SEC-05 | Each requirement has Verification Method | BLOCKING |
| IVS-SEC-06 | Each requirement has Test Reference | BLOCKING |
| IVS-SEC-07 | At least 4 SEC-AUTHZ-* requirements | BLOCKING |
| IVS-SEC-08 | At least 3 SEC-DATA-* requirements | BLOCKING |

### Section 4: Observability Verification (IVS-OBS-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-OBS-01 | Section 4 "Observability Verification" exists | BLOCKING |
| IVS-OBS-02 | Logging Verification table (OBS-LOG-*) | BLOCKING |
| IVS-OBS-03 | Required Log Events table | BLOCKING |
| IVS-OBS-04 | Metrics Verification table (OBS-MET-*) | BLOCKING |
| IVS-OBS-05 | Required Metrics definition (name, type, labels) | BLOCKING |
| IVS-OBS-06 | At least 3 OBS-LOG-* requirements | BLOCKING |
| IVS-OBS-07 | At least 3 OBS-MET-* requirements | BLOCKING |

### Section 5: Reliability Verification (IVS-REL-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-REL-01 | Section 5 "Reliability Verification" exists | BLOCKING |
| IVS-REL-02 | Error Handling Verification table (REL-ERR-*) | BLOCKING |
| IVS-REL-03 | Fault Tolerance Verification table (REL-FT-*) | BLOCKING |
| IVS-REL-04 | Recovery Verification table (REL-REC-*) | WARNING |
| IVS-REL-05 | Each requirement has Verification Method | BLOCKING |
| IVS-REL-06 | Each requirement has Test Reference | BLOCKING |
| IVS-REL-07 | At least 3 REL-ERR-* requirements | BLOCKING |
| IVS-REL-08 | At least 2 REL-FT-* requirements | BLOCKING |

### Section 6: Performance Verification (IVS-PERF-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-PERF-01 | Section 6 "Performance Verification" exists | BLOCKING |
| IVS-PERF-02 | Latency SLOs table with P50/P95/P99 | BLOCKING |
| IVS-PERF-03 | Each operation has latency targets | BLOCKING |
| IVS-PERF-04 | Resource Limits table | BLOCKING |
| IVS-PERF-05 | Resource limits have rationale | WARNING |

### Section 7: Production Guardian Checklist (IVS-PROD-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-PROD-01 | Section 7 "Production Guardian Review Checklist" exists | BLOCKING |
| IVS-PROD-02 | Pre-Deployment Verification section | BLOCKING |
| IVS-PROD-03 | Implementation Completeness checklist | BLOCKING |
| IVS-PROD-04 | Security Sign-off checklist | BLOCKING |
| IVS-PROD-05 | Observability Sign-off checklist | BLOCKING |
| IVS-PROD-06 | Reliability Sign-off checklist | BLOCKING |
| IVS-PROD-07 | Performance Sign-off checklist | BLOCKING |
| IVS-PROD-08 | Deployment Decision Matrix | BLOCKING |
| IVS-PROD-09 | APPROVED/BLOCKED/CONDITIONAL decision options | BLOCKING |

### Implementation Layer Coverage (IVS-IMPL-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-IMPL-01 | Domain layer requirements present (models, services) | BLOCKING |
| IVS-IMPL-02 | Port layer requirements present (protocols/interfaces) | BLOCKING |
| IVS-IMPL-03 | Adapter layer requirements present (Memory + GCP minimum) | BLOCKING |
| IVS-IMPL-04 | Handler layer requirements present | BLOCKING |
| IVS-IMPL-05 | HTTP/API layer requirements present | BLOCKING |
| IVS-IMPL-06 | SDK layer requirements present | WARNING |

### Traceability (IVS-TRACE-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| IVS-TRACE-01 | Each SEC-* has Test Reference column | BLOCKING |
| IVS-TRACE-02 | Each OBS-* has Test Reference column | BLOCKING |
| IVS-TRACE-03 | Each REL-* has Test Reference column | BLOCKING |
| IVS-TRACE-04 | Test references use TS-* format | BLOCKING |

---

## Expected IVS Structure

```markdown
# {Feature} - Implementation & Verification Specification

**Status:** Draft | In Review | Approved
**Created:** YYYY-MM-DD
**Feature Folder:** `features/{feature}/`

**Related Documents:**
- Design: `DESIGN.md`
- Test Scenarios: `TEST_SCENARIOS.md`
- Traceability: `TRACEABILITY.jsonld`

---

## Document Purpose

{Description of what this IVS covers}

---

## 0. C4 Architecture Model

### 0.1 Level 1: System Context
{Mermaid diagram or ASCII art}
{Actors table}
{External Systems table}

### 0.2 Level 2: Container Diagram
{Mermaid diagram or ASCII art}

### 0.3 Level 3: Component Overview
{Mermaid diagram or ASCII art}
{Components table: Component | File | Responsibility}
{External Dependencies table}

### 0.4 Level 4: Code Summary
{Key type definitions}

---

## 1. Infrastructure Integration Specification

### 1.1 Cloud Services Required
| Service | Product | API Endpoint | Purpose |

### 1.2 IAM Permissions Required
| Permission | IAM Role | Used By |

### 1.3 Environment Variables Required
| Variable | Required | Default | Description |

### 1.4 Infrastructure Configuration
{Terraform examples or similar}

---

## 2. Port-to-Implementation Mapping

### 2.1 {Port Name} Port
| Aspect | Specification |
| Port Location | `path/to/port.py` |
| Memory Adapter | `path/to/memory_adapter.py` |
| GCP Adapter | `path/to/gcp_adapter.py` |

**Port Interface:**
{Code example}

### 2.N Implementation Completeness Matrix
| Port Method | Memory | GCP | K8s | Notes |

---

## 3. Security Verification Specification

### 3.1 Authorization Verification
| Requirement ID | Requirement | Verification Method | Test Reference |
| SEC-AUTHZ-01 | ... | ... | TS-XX |

**Permission Matrix:**
| Operation | Required Permission | Test Reference |

### 3.2 Data Protection Verification
| Requirement ID | Requirement | Verification Method | Test Reference |
| SEC-DATA-01 | ... | ... | TS-XX |

---

## 4. Observability Verification Specification

### 4.1 Logging Verification
| Requirement ID | Requirement | Verification Method | Test Reference |
| OBS-LOG-01 | ... | ... | TS-XX |

**Required Log Events:**
| Event | Severity | Fields |

### 4.2 Metrics Verification
| Requirement ID | Requirement | Verification Method | Test Reference |
| OBS-MET-01 | ... | ... | TS-XX |

**Required Metrics:**
{YAML or table format}

---

## 5. Reliability Verification Specification

### 5.1 Error Handling Verification
| Requirement ID | Requirement | Verification Method | Test Reference |
| REL-ERR-01 | ... | ... | TS-XX |

### 5.2 Fault Tolerance Verification
| Requirement ID | Requirement | Verification Method | Test Reference |
| REL-FT-01 | ... | ... | TS-XX |

### 5.3 Recovery Verification
| Requirement ID | Requirement | Verification Method | Test Reference |
| REL-REC-01 | ... | ... | TS-XX |

---

## 6. Performance Verification Specification

### 6.1 Latency SLOs
| Operation | P50 | P95 | P99 | Test Reference |

### 6.2 Resource Limits
| Resource | Limit | Rationale |

---

## 7. Production Guardian Review Checklist

### 7.1 Pre-Deployment Verification

**Implementation Completeness:**
- [ ] All port methods implemented
- [ ] Memory and GCP adapter parity verified
- [ ] Entry points tested

**Security Sign-off:**
- [ ] SEC-AUTHZ-* requirements verified
- [ ] SEC-DATA-* requirements verified

**Observability Sign-off:**
- [ ] OBS-LOG-* requirements verified
- [ ] OBS-MET-* requirements verified

**Reliability Sign-off:**
- [ ] REL-ERR-* requirements verified
- [ ] REL-FT-* requirements verified

**Performance Sign-off:**
- [ ] Latency SLOs met
- [ ] Resource limits defined

### 7.2 Deployment Decision Matrix

| Check Category | Status | Blocking? |
|----------------|--------|-----------|
| Security | PASS/FAIL | Yes |
| Observability | PASS/FAIL | Yes |
| Reliability | PASS/FAIL | Yes |
| Performance | PASS/FAIL | Yes |
| Test Coverage | PASS/FAIL | Yes |

**Deployment Decision:**
- [ ] **APPROVED FOR PRODUCTION**
- [ ] **BLOCKED**
- [ ] **CONDITIONAL**

---

## Document History

| Version | Date | Author | Changes |
```

---

## Agent Prompt

```
You are the IVS Validator - a focused validator that checks IVS.md structure and production readiness.

## Your Task

Validate IVS for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/IVS.md (primary)
2. features/{feature_name}/TEST_SCENARIOS.md (for traceability)

## Validation Checklist

### IVS-C4-*: C4 Architecture Model (Section 0)
- [ ] IVS-C4-01: Section 0 exists
- [ ] IVS-C4-02: Level 1 System Context diagram
- [ ] IVS-C4-03: Actors table
- [ ] IVS-C4-04: External Systems table
- [ ] IVS-C4-05: Level 2 Container Diagram
- [ ] IVS-C4-06: Level 3 Component Overview
- [ ] IVS-C4-07: Components table
- [ ] IVS-C4-08: External Dependencies (WARNING)
- [ ] IVS-C4-09: Level 4 Code Summary (WARNING)

### IVS-INFRA-*: Infrastructure Integration (Section 1)
- [ ] IVS-INFRA-01: Section 1 exists
- [ ] IVS-INFRA-02: Cloud Services Required
- [ ] IVS-INFRA-03: IAM Permissions Required
- [ ] IVS-INFRA-04: Environment Variables Required
- [ ] IVS-INFRA-05: Terraform examples (WARNING)
- [ ] IVS-INFRA-06: Env vars have Required/Default/Description

### IVS-PORT-*: Port-to-Implementation Mapping (Section 2)
- [ ] IVS-PORT-01: Section 2 exists
- [ ] IVS-PORT-02: Port location tables
- [ ] IVS-PORT-03: Port Interface code examples
- [ ] IVS-PORT-04: Implementation Completeness Matrix
- [ ] IVS-PORT-05: Matrix shows adapter status (WARNING)

### IVS-SEC-*: Security Verification (Section 3)
- [ ] IVS-SEC-01: Section 3 exists
- [ ] IVS-SEC-02: Authorization Verification (SEC-AUTHZ-*)
- [ ] IVS-SEC-03: Permission Matrix
- [ ] IVS-SEC-04: Data Protection (SEC-DATA-*)
- [ ] IVS-SEC-05: Each has Verification Method
- [ ] IVS-SEC-06: Each has Test Reference
- [ ] IVS-SEC-07: At least 4 SEC-AUTHZ-*
- [ ] IVS-SEC-08: At least 3 SEC-DATA-*

### IVS-OBS-*: Observability Verification (Section 4)
- [ ] IVS-OBS-01: Section 4 exists
- [ ] IVS-OBS-02: Logging Verification (OBS-LOG-*)
- [ ] IVS-OBS-03: Required Log Events table
- [ ] IVS-OBS-04: Metrics Verification (OBS-MET-*)
- [ ] IVS-OBS-05: Required Metrics definition
- [ ] IVS-OBS-06: At least 3 OBS-LOG-*
- [ ] IVS-OBS-07: At least 3 OBS-MET-*

### IVS-REL-*: Reliability Verification (Section 5)
- [ ] IVS-REL-01: Section 5 exists
- [ ] IVS-REL-02: Error Handling (REL-ERR-*)
- [ ] IVS-REL-03: Fault Tolerance (REL-FT-*)
- [ ] IVS-REL-04: Recovery (REL-REC-*) (WARNING)
- [ ] IVS-REL-05: Each has Verification Method
- [ ] IVS-REL-06: Each has Test Reference
- [ ] IVS-REL-07: At least 3 REL-ERR-*
- [ ] IVS-REL-08: At least 2 REL-FT-*

### IVS-PERF-*: Performance Verification (Section 6)
- [ ] IVS-PERF-01: Section 6 exists
- [ ] IVS-PERF-02: Latency SLOs (P50/P95/P99)
- [ ] IVS-PERF-03: Operations have latency targets
- [ ] IVS-PERF-04: Resource Limits table
- [ ] IVS-PERF-05: Limits have rationale (WARNING)

### IVS-PROD-*: Production Guardian Checklist (Section 7)
- [ ] IVS-PROD-01: Section 7 exists
- [ ] IVS-PROD-02: Pre-Deployment Verification
- [ ] IVS-PROD-03: Implementation Completeness checklist
- [ ] IVS-PROD-04: Security Sign-off checklist
- [ ] IVS-PROD-05: Observability Sign-off checklist
- [ ] IVS-PROD-06: Reliability Sign-off checklist
- [ ] IVS-PROD-07: Performance Sign-off checklist
- [ ] IVS-PROD-08: Deployment Decision Matrix
- [ ] IVS-PROD-09: APPROVED/BLOCKED/CONDITIONAL options

### IVS-IMPL-*: Implementation Layer Coverage
- [ ] IVS-IMPL-01: Domain layer (models, services)
- [ ] IVS-IMPL-02: Port layer (protocols)
- [ ] IVS-IMPL-03: Adapter layer (Memory + GCP)
- [ ] IVS-IMPL-04: Handler layer
- [ ] IVS-IMPL-05: HTTP/API layer
- [ ] IVS-IMPL-06: SDK layer (WARNING)

### IVS-TRACE-*: Traceability
- [ ] IVS-TRACE-01: SEC-* have Test Reference
- [ ] IVS-TRACE-02: OBS-* have Test Reference
- [ ] IVS-TRACE-03: REL-* have Test Reference
- [ ] IVS-TRACE-04: References use TS-* format

## Section Detection Patterns

```
## 0. C4 Architecture Model
### 0.1 Level 1: System Context
### 0.2 Level 2: Container Diagram
### 0.3 Level 3: Component Overview
### 0.4 Level 4: Code Summary

## 1. Infrastructure Integration
### 1.1 Cloud Services Required
### 1.2 IAM Permissions Required
### 1.3 Environment Variables Required

## 2. Port-to-Implementation Mapping

## 3. Security Verification Specification
### 3.1 Authorization Verification
### 3.2 Data Protection Verification

## 4. Observability Verification Specification
### 4.1 Logging Verification
### 4.2 Metrics Verification

## 5. Reliability Verification Specification
### 5.1 Error Handling Verification
### 5.2 Fault Tolerance Verification
### 5.3 Recovery Verification

## 6. Performance Verification Specification
### 6.1 Latency SLOs
### 6.2 Resource Limits

## 7. Production Guardian Review Checklist
### 7.1 Pre-Deployment Verification
### 7.2 Deployment Decision Matrix
```

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "ivs",
  "version": "2.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 55,
    "checks_passed": X,
    "checks_failed": X,
    "checks_skipped": X,
    "blocking_issues": X,
    "warning_issues": X,
    "sections_found": ["0", "1", "2", "3", "4", "5", "6", "7"],
    "requirement_counts": {
      "SEC-AUTHZ": N,
      "SEC-DATA": N,
      "OBS-LOG": N,
      "OBS-MET": N,
      "REL-ERR": N,
      "REL-FT": N,
      "REL-REC": N
    }
  },
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Read IVS.md thoroughly - it's the primary file
2. Check ALL section headers exist (0-7)
3. Count requirements by prefix (SEC-*, OBS-*, REL-*)
4. Verify test references in tables
5. Return ONLY JSON output
6. Be specific about missing sections
7. Compare to workflows-async/IVS.md as reference structure
```
