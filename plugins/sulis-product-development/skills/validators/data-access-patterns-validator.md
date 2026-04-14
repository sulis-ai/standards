# Data Access Patterns Validator

> **Focus:** Validates DESIGN.md Section 9.7 Data Access & Performance Patterns
> **Checks:** PERF-*
> **Output:** Structured JSON per VALIDATOR_OUTPUT_SCHEMA.md

## Purpose

Ensures the design addresses N+1 query prevention, caching strategy, repository requirements, and performance targets. N+1 queries are the #1 cause of performance degradation and are difficult to fix post-implementation.

## Files to Read

1. `features/{feature}/DESIGN.md` (Section 9.7)
2. `features/{feature}/TEST_SCENARIOS.md` (for performance tests)

## Validation Checks

### N+1 Prevention (PERF-N1-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| PERF-N1-01 | Section 9.7 exists (Data Access & Performance Patterns) | BLOCKING |
| PERF-N1-02 | No queries inside loops - batch methods documented | BLOCKING |
| PERF-N1-03 | Repository has `get_batch()` method for bulk fetches | BLOCKING |
| PERF-N1-04 | Targeted queries used (not load-all-filter pattern) | BLOCKING |
| PERF-N1-05 | Memoization documented for recursive operations | WARNING |
| PERF-N1-06 | Pass-through pattern documented (not re-fetching) | WARNING |

### Caching Strategy (PERF-CACHE-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| PERF-CACHE-01 | Caching strategy defined (L1/L2 or justification for no cache) | WARNING |
| PERF-CACHE-02 | Cache keys include platform_id for tenant isolation | BLOCKING |
| PERF-CACHE-03 | Cache invalidation on mutations documented | WARNING |
| PERF-CACHE-04 | TTLs defined for cacheable data types | WARNING |

### Repository Requirements (PERF-REPO-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| PERF-REPO-01 | Repository protocol includes `get_batch()` | BLOCKING |
| PERF-REPO-02 | Server-side filtering methods documented | BLOCKING |
| PERF-REPO-03 | `count_by_*()` method (no fetch for counts) | WARNING |
| PERF-REPO-04 | Pagination documented for list operations | BLOCKING |

### Query Complexity (PERF-QRY-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| PERF-QRY-01 | Query complexity limits defined (queries per request) | WARNING |
| PERF-QRY-02 | Performance targets defined (P50, P99 response times) | WARNING |
| PERF-QRY-03 | Query metrics tracking documented | WARNING |

### Performance Testing (PERF-TEST-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| PERF-TEST-01 | TEST_SCENARIOS.md includes N+1 detection test (TS-PERF-04) | BLOCKING |
| PERF-TEST-02 | Performance targets defined with measurement method | WARNING |

### Data Access Checklist (PERF-CHK-*)

| Check ID | Check | Severity |
|----------|-------|----------|
| PERF-CHK-01 | Data Access Checklist (9.7.7) exists | BLOCKING |
| PERF-CHK-02 | All PERF-* check IDs listed | BLOCKING |

## Validation Process

### Step 1: Check Section Existence

```
Read: DESIGN.md

Search for:
- "9.7" or "Data Access" or "Performance Patterns"
- "9.7.1" or "N+1 Prevention"
- "9.7.2" or "Batch Operations"
- "9.7.3" or "Caching Strategy"
- "9.7.4" or "Repository Requirements"
- "9.7.5" or "Query Complexity"
- "9.7.6" or "Performance Testing"
- "9.7.7" or "Data Access Checklist"

If section missing → PERF-N1-01 FAIL
```

### Step 2: Check N+1 Patterns

```
For N+1 prevention, look for:
- get_batch(ids: list[str]) method
- "batch" or "bulk" operations
- "avoid loops" or "no queries in loops"

Anti-patterns to flag:
- for item in items: repo.get(item.id)
- List comprehensions with repo calls inside
```

### Step 3: Check Caching

```
Look for:
- "L1 cache" or "request-scoped cache"
- "L2 cache" or "Redis" or "distributed cache"
- OR explicit "no caching" with justification

If caching mentioned, verify:
- Cache keys include platform_id
- TTL defined
- Invalidation strategy
```

### Step 4: Check Test Coverage

```
Read: TEST_SCENARIOS.md

Search for:
- "PERF-04" or "N+1"
- Performance test scenarios
- Query count assertions
```

## Agent Prompt

```
You are the Data Access Patterns Validator - a focused validator that checks ONLY Section 9.7 compliance.

## Your Task

Validate data access patterns for feature: {feature_name}
Feature path: features/{feature_name}/

## Files to Read

1. features/{feature_name}/DESIGN.md (focus on Section 9.7)
2. features/{feature_name}/TEST_SCENARIOS.md

## Validation Checklist

### PERF-N1-*: N+1 Prevention (9.7.1-9.7.2)
- [ ] PERF-N1-01: Section 9.7 exists
- [ ] PERF-N1-02: No queries in loops documented
- [ ] PERF-N1-03: get_batch() method defined
- [ ] PERF-N1-04: Targeted queries (not load-all-filter)
- [ ] PERF-N1-05: Memoization for recursion (WARNING)
- [ ] PERF-N1-06: Pass-through pattern (WARNING)

### PERF-CACHE-*: Caching Strategy (9.7.3)
- [ ] PERF-CACHE-01: Caching strategy defined (WARNING)
- [ ] PERF-CACHE-02: Cache keys include platform_id
- [ ] PERF-CACHE-03: Cache invalidation (WARNING)
- [ ] PERF-CACHE-04: TTLs defined (WARNING)

### PERF-REPO-*: Repository Requirements (9.7.4)
- [ ] PERF-REPO-01: get_batch() in protocol
- [ ] PERF-REPO-02: Server-side filtering
- [ ] PERF-REPO-03: count_by_*() method (WARNING)
- [ ] PERF-REPO-04: Pagination documented

### PERF-QRY-*: Query Complexity (9.7.5)
- [ ] PERF-QRY-01: Query limits defined (WARNING)
- [ ] PERF-QRY-02: P50/P99 targets (WARNING)
- [ ] PERF-QRY-03: Query metrics (WARNING)

### PERF-TEST-*: Performance Testing (9.7.6)
- [ ] PERF-TEST-01: N+1 detection test
- [ ] PERF-TEST-02: Performance targets (WARNING)

### PERF-CHK-*: Checklist (9.7.7)
- [ ] PERF-CHK-01: Checklist exists
- [ ] PERF-CHK-02: All IDs listed

## N+1 Anti-Patterns to Flag

```python
# BAD - N+1 query pattern
for workload in workloads:
    details = await repo.get(workload.id)  # N queries!

# GOOD - Batch query
details_map = await repo.get_batch([w.id for w in workloads])  # 1 query
```

## Output Format

Return JSON following VALIDATOR_OUTPUT_SCHEMA.md:

```json
{
  "validator": "data-access-patterns",
  "version": "1.0.0",
  "feature": "{feature_name}",
  "timestamp": "{ISO 8601}",
  "status": "PASS or FAIL",
  "summary": {...},
  "issues": [...],
  "checks": [...]
}
```

## Rules

1. Focus ONLY on Section 9.7 content
2. Check ONLY PERF-* checks
3. Return ONLY JSON output
4. WARNING checks don't cause FAIL status
5. N+1 prevention is critical - be thorough
```
