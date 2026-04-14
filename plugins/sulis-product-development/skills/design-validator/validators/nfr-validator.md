# NFR Validator

> **Purpose:** Validate Non-Functional Requirements (NFR.md) against platform capabilities.
> **Check Prefix:** NFR-*

## Files to Read

**Feature Artifacts:**
- `features/{feature}/NFR.md` - Non-functional requirements
- `features/{feature}/DESIGN.md` - Technical design (for cross-reference)
- `features/{feature}/LIFECYCLE_STATE.json` - Classification

**Platform References:**
- `architecture/PLATFORM_CAPABILITIES.md` - Platform capability manifest (when it exists)
- Compute service knowledge (injected via skill context)

---

## Validation Checklist

### NFR-ART-* (Artifact Presence)

| ID | Check | Severity |
|----|-------|----------|
| NFR-ART-01 | NFR.md exists in feature folder | BLOCKING |
| NFR-ART-02 | All required sections present | BLOCKING |
| NFR-ART-03 | Platform Capability Check section completed | BLOCKING |

### NFR-CAP-* (Capability Validation)

| ID | Check | Severity |
|----|-------|----------|
| NFR-CAP-01 | Required capabilities listed | BLOCKING |
| NFR-CAP-02 | Each capability marked as Available or Gap | BLOCKING |
| NFR-CAP-03 | Blocking gaps documented with recommendations | BLOCKING |
| NFR-CAP-04 | Non-blocking gaps have workarounds | WARNING |

### NFR-COMP-* (Compute Requirements)

| ID | Check | Severity |
|----|-------|----------|
| NFR-COMP-01 | Workload type specified (COMP-01) | BLOCKING |
| NFR-COMP-02 | Workload type valid: service, job, worker_pool, cluster | BLOCKING |
| NFR-COMP-03 | CPU constraints within platform limits (0-4 vCPU) | BLOCKING |
| NFR-COMP-04 | Memory constraints within platform limits (128Mi-32Gi) | BLOCKING |
| NFR-COMP-05 | Timeout constraints within platform limits | BLOCKING |
| NFR-COMP-06 | Min/Target/Max structure used for resources | WARNING |

### NFR-PERF-* (Performance Requirements)

| ID | Check | Severity |
|----|-------|----------|
| NFR-PERF-01 | At least one latency requirement specified | BLOCKING |
| NFR-PERF-02 | P95 latency is a constraint (not just hint) | BLOCKING |
| NFR-PERF-03 | Throughput requirements specified | BLOCKING |
| NFR-PERF-04 | Availability target specified | WARNING |
| NFR-PERF-05 | Performance requirements achievable with compute constraints | BLOCKING |

### NFR-INFRA-* (Infrastructure Requirements)

| ID | Check | Severity |
|----|-------|----------|
| NFR-INFRA-01 | Networking requirements specified | BLOCKING |
| NFR-INFRA-02 | Storage requirements specified (or explicitly "Not required") | BLOCKING |
| NFR-INFRA-03 | External dependencies listed with fallbacks | WARNING |
| NFR-INFRA-04 | All required infrastructure available on platform | BLOCKING |

### NFR-COST-* (Cost Requirements)

| ID | Check | Severity |
|----|-------|----------|
| NFR-COST-01 | Monthly budget specified | BLOCKING |
| NFR-COST-02 | Budget is realistic (> 0 credits) | BLOCKING |
| NFR-COST-03 | Scale-to-zero preference specified | WARNING |
| NFR-COST-04 | Cost vs latency tradeoff documented | WARNING |

### NFR-SCALE-* (Scaling Requirements)

| ID | Check | Severity |
|----|-------|----------|
| NFR-SCALE-01 | Expected load documented | BLOCKING |
| NFR-SCALE-02 | Min/max instances specified | BLOCKING |
| NFR-SCALE-03 | Max instances within platform limits (≤100 default, ≤1000 max) | BLOCKING |
| NFR-SCALE-04 | Peak multiplier documented | WARNING |
| NFR-SCALE-05 | Geographic requirements specified | BLOCKING |

### NFR-VALID-* (Constraint Validation Matrix)

| ID | Check | Severity |
|----|-------|----------|
| NFR-VALID-01 | Hard constraints section populated | BLOCKING |
| NFR-VALID-02 | Each constraint has validation check | BLOCKING |
| NFR-VALID-03 | Soft constraints section populated | WARNING |
| NFR-VALID-04 | No conflicting constraints | BLOCKING |

### NFR-GAP-* (Capability Gap Summary)

| ID | Check | Severity |
|----|-------|----------|
| NFR-GAP-01 | Gap summary section exists | BLOCKING |
| NFR-GAP-02 | All gaps from Section 1 appear in summary | BLOCKING |
| NFR-GAP-03 | Blocking gaps have "Blocks Feature?" = Yes | BLOCKING |
| NFR-GAP-04 | Platform expansion recommendations provided for gaps | WARNING |

---

## Platform Capability Reference

Use these limits for validation (current Sulis Platform platform):

### Compute Limits

| Resource | Min | Max (Default) | Max (Elevated) |
|----------|-----|---------------|----------------|
| Services per platform | 0 | 10 | 100 |
| Concurrent jobs | 0 | 100 | 1000 |
| Worker pools | 0 | 5 | 50 |
| Cluster jobs | 0 | 3 | 20 |
| Instances per service | 0 | 100 | 1000 |
| vCPU per container | 0.25 | 4 | 8 |
| Memory per container | 128Mi | 8Gi | 32Gi |
| Job timeout | 1s | 10m | 24h |
| Request timeout | 1s | 300s | 3600s |

### Infrastructure Availability

| Capability | Available | Notes |
|------------|-----------|-------|
| Services (HTTP) | Yes | Cloud Run / ECS |
| Jobs (batch) | Yes | Cloud Run Jobs / AWS Batch |
| Worker pools | Yes | Queue-based processing |
| Cluster jobs | Yes | Spark/Dataproc/EMR |
| Object storage | Yes | GCS / S3 |
| Document storage | Yes | Firestore |
| Pub/Sub messaging | Yes | GCP Pub/Sub |
| Custom domains | Yes | DNS + SSL auto-managed |
| SSL/TLS | Yes | Auto-provisioned |
| Load balancing | Yes | Built-in per service |
| GPU compute | No | Not yet available |
| Multi-region | Limited | Single region recommended |

---

## Validation Logic

### Constraint Consistency Check

```python
# Check for conflicting constraints
def check_constraint_consistency(nfr):
    issues = []

    # Scale-to-zero + min_instances > 0 conflict
    if nfr.cost.scale_to_zero == "Required" and nfr.scale.min_instances > 0:
        issues.append("NFR-VALID-04: Scale-to-zero required but min_instances > 0")

    # P95 latency vs cold start tolerance
    if nfr.perf.p95_latency < 1000 and nfr.perf.cold_start_tolerance == "Not acceptable":
        if nfr.scale.min_instances == 0:
            issues.append("NFR-VALID-04: Low latency + no cold start + scale-to-zero conflict")

    # Budget vs resources
    estimated_cost = estimate_monthly_cost(nfr.comp, nfr.scale)
    if estimated_cost > nfr.cost.monthly_budget * 1.2:  # 20% buffer
        issues.append(f"NFR-VALID-04: Estimated cost ({estimated_cost}) exceeds budget ({nfr.cost.monthly_budget})")

    return issues
```

### Platform Fit Check

```python
# Check if requirements fit within platform capabilities
def check_platform_fit(nfr, platform_caps):
    issues = []

    # CPU check
    if nfr.comp.cpu_max > platform_caps.max_vcpu:
        issues.append(f"NFR-COMP-03: CPU max ({nfr.comp.cpu_max}) exceeds platform limit ({platform_caps.max_vcpu})")

    # Memory check
    if parse_memory(nfr.comp.memory_max) > parse_memory(platform_caps.max_memory):
        issues.append(f"NFR-COMP-04: Memory max exceeds platform limit")

    # Instance count check
    if nfr.scale.max_instances > platform_caps.max_instances:
        issues.append(f"NFR-SCALE-03: Max instances ({nfr.scale.max_instances}) exceeds platform limit")

    return issues
```

---

## Output Format

Return JSON following the standard validator schema:

```json
{
  "validator": "nfr",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {
    "checks_total": 35,
    "checks_passed": 0,
    "checks_failed": 0,
    "checks_skipped": 0,
    "blocking_issues": 0,
    "warning_issues": 0
  },
  "issues": [],
  "checks": []
}
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-16 | Initial NFR validator |
