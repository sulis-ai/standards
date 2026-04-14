# Validator Output Schema

> **Purpose:** Defines the structured output format that ALL sub-validators MUST produce.
> The orchestrator depends on this exact format to collate results.

## Output Contract

Every validator MUST return a JSON object with this exact structure:

```json
{
  "validator": "validator-name",
  "version": "1.0.0",
  "feature": "feature-name",
  "timestamp": "2026-01-11T12:00:00Z",
  "status": "PASS | FAIL",
  "summary": {
    "checks_total": 15,
    "checks_passed": 12,
    "checks_failed": 3,
    "checks_skipped": 0,
    "blocking_issues": 3,
    "warning_issues": 0
  },
  "issues": [
    {
      "check_id": "CHECK-ID-01",
      "severity": "BLOCKING | WARNING",
      "title": "Short description of issue",
      "file": "relative/path/to/file.md",
      "line": 42,
      "evidence": "Quoted text from file showing the problem",
      "violation": "What rule was violated",
      "fix": "Specific action to fix this issue"
    }
  ],
  "checks": [
    {
      "check_id": "CHECK-ID-01",
      "description": "What this check validates",
      "status": "PASS | FAIL | SKIP",
      "notes": "Optional context"
    }
  ]
}
```

## Field Definitions

### Top-Level Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `validator` | string | Yes | Validator identifier (e.g., "market-evidence") |
| `version` | string | Yes | Validator version (semver) |
| `feature` | string | Yes | Feature being validated |
| `timestamp` | string | Yes | ISO 8601 timestamp |
| `status` | enum | Yes | "PASS" or "FAIL" |
| `summary` | object | Yes | Aggregated counts |
| `issues` | array | Yes | List of issues found (empty if PASS) |
| `checks` | array | Yes | All checks with their status |

### Summary Object

| Field | Type | Description |
|-------|------|-------------|
| `checks_total` | int | Total checks in this validator |
| `checks_passed` | int | Checks that passed |
| `checks_failed` | int | Checks that failed |
| `checks_skipped` | int | Checks skipped (N/A for classification) |
| `blocking_issues` | int | BLOCKING severity issues |
| `warning_issues` | int | WARNING severity issues |

### Issue Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `check_id` | string | Yes | Unique check identifier |
| `severity` | enum | Yes | "BLOCKING" or "WARNING" |
| `title` | string | Yes | Brief issue title |
| `file` | string | Yes | File where issue was found |
| `line` | int | No | Line number (if applicable) |
| `evidence` | string | Yes | Quoted text showing problem |
| `violation` | string | Yes | What rule was violated |
| `fix` | string | Yes | How to fix the issue |

### Check Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `check_id` | string | Yes | Unique check identifier |
| `description` | string | Yes | What this check validates |
| `status` | enum | Yes | "PASS", "FAIL", or "SKIP" |
| `notes` | string | No | Additional context |

## Status Determination

- **PASS**: All checks passed OR only WARNING issues found
- **FAIL**: One or more BLOCKING issues found

## Example Output

```json
{
  "validator": "platform-conventions",
  "version": "1.0.0",
  "feature": "compute-provider-resource-details",
  "timestamp": "2026-01-11T12:00:00Z",
  "status": "FAIL",
  "summary": {
    "checks_total": 15,
    "checks_passed": 13,
    "checks_failed": 2,
    "checks_skipped": 0,
    "blocking_issues": 2,
    "warning_issues": 0
  },
  "issues": [
    {
      "check_id": "CONV-WL-01",
      "severity": "BLOCKING",
      "title": "Hardcoded cloud console URL",
      "file": "USER_GUIDE.md",
      "line": 187,
      "evidence": "print(f\"Spark UI: {details.metadata['spark_ui_url']}\")\n# Opens: https://xyz-dot-us-central1.dataproc.googleusercontent.com/",
      "violation": "Direct cloud provider URL exposed to users violates cloud abstraction principle",
      "fix": "Use Sulis Platform proxy URL: {platform_host}/proxy/spark/{workload_id}"
    }
  ],
  "checks": [
    {
      "check_id": "CONV-WL-01",
      "description": "No hardcoded cloud provider URLs in user-facing content",
      "status": "FAIL",
      "notes": "Found in USER_GUIDE.md section 3.4"
    },
    {
      "check_id": "CONV-WL-02",
      "description": "Event type prefixes are platform-configurable",
      "status": "PASS",
      "notes": null
    }
  ]
}
```

## Validator List

| Validator ID | Check Prefix | Focus Area |
|--------------|--------------|------------|
| `market-evidence` | ART-00*, KANO-* | Problem validation, Kano scope |
| `platform-conventions` | CONV-* | White-label, secrets, naming |
| `entity-model` | ENT-* | Tenant hierarchy, relationships |
| `architecture-principles` | ARCH-* | Security, DDD, Ports & Adapters |
| `service-layer-patterns` | IMPL-* | Section 9.6 patterns |
| `data-access-patterns` | PERF-* | Section 9.7 patterns |
| `structural-completeness` | STRUCT-* | Template section presence |
| `servicespec` | SPEC-* | ServiceSpec completeness |
| `artifact-presence` | ART-01 to ART-09 | All artifacts exist |
