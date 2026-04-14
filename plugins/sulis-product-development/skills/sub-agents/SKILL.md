# Sub-Agent Architecture for Autonomous Implementation

> **Purpose:** Define specialized sub-agents that work autonomously on implementation tasks.
> **Principle:** Complete context enables atomic execution without human clarification.

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        ORCHESTRATOR AGENT                                    │
│                                                                              │
│  Receives: Complete Generative Seed (all design artifacts)                   │
│  Produces: Task breakdown → Sub-agent assignments → Aggregated results       │
│                                                                              │
│  Responsibilities:                                                           │
│  1. Parse and validate all design artifacts                                  │
│  2. Check platform capabilities against NFR.md requirements                  │
│  3. Decompose implementation into parallel-safe tasks                        │
│  4. Assign tasks to specialized sub-agents                                   │
│  5. Aggregate results, handle failures, escalate gaps                        │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        ▼                           ▼                           ▼
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│  DOMAIN AGENT   │       │  HANDLER AGENT  │       │   INFRA AGENT   │
│  domain-agent/  │       │  handler-agent/ │       │  infra-agent/   │
└─────────────────┘       └─────────────────┘       └─────────────────┘
        │                           │                           │
        ▼                           ▼                           ▼
┌─────────────────┐       ┌─────────────────┐       ┌─────────────────┐
│   TEST AGENT    │       │ SECURITY AGENT  │       │   COST AGENT    │
│  test-agent/    │       │ security-agent/ │       │  cost-agent/    │
└─────────────────┘       └─────────────────┘       └─────────────────┘
```

---

## Sub-Agent Index

| Agent | Purpose | Skill File | Inputs | Outputs |
|-------|---------|------------|--------|---------|
| **orchestrator** | Coordinate sub-agents | `orchestrator-agent/SKILL.md` | Generative Seed | Task assignments |
| **domain** | Domain models, entities | `domain-agent/SKILL.md` | DESIGN, SERVICE_SPEC | Models, repositories |
| **handler** | Handlers, actions, routes | `handler-agent/SKILL.md` | DESIGN, SERVICE_SPEC, IVS | Handlers, actions |
| **infra** | Deployment configuration | `infra-agent/SKILL.md` | NFR, DESIGN | Dockerfile, sulis.yaml |
| **test** | Test implementations | `test-agent/SKILL.md` | TEST_SCENARIOS, IVS | Unit, integration tests |
| **security** | Security implementation | `security-agent/SKILL.md` | IVS (SEC-*), SERVICE_SPEC | Auth, validation, audit |
| **cost** | Cost estimation & validation | `cost-agent/SKILL.md` | NFR, PLATFORM_CAPABILITIES | Cost estimates, optimization |

---

## When to Use Sub-Agents

### Use Sub-Agents When:
- Feature has complete Generative Seed (all artifacts exist)
- Implementation can be parallelized across domains
- GATE 1 (Design Approval) has passed
- NFR.md has no blocking capability gaps

### Do NOT Use Sub-Agents When:
- Design phase incomplete (artifacts missing)
- Clarification needed from user
- Blocking capability gaps exist
- Feature is trivial (< 3 files changed)

---

## Orchestration Flow

```python
async def orchestrate_implementation(feature_name: str):
    """
    Main orchestration flow for autonomous implementation.
    """
    # Phase 1: Load and validate Generative Seed
    seed = await load_generative_seed(feature_name)
    validate_seed_completeness(seed)

    # Phase 2: Check platform capabilities
    gaps = await check_platform_fit(seed.nfr, PLATFORM_CAPABILITIES)
    if gaps.has_blocking:
        return EscalationResult(
            status="BLOCKED",
            reason="Capability gaps require platform expansion",
            gaps=gaps.blocking
        )

    # Phase 3: Decompose into tasks
    tasks = decompose_implementation(seed)

    # Phase 4: Assign to sub-agents (parallel where safe)
    parallel_tasks = [
        ("domain-agent", tasks.domain),
        ("infra-agent", tasks.infrastructure),
        ("cost-agent", tasks.cost_estimation),
    ]

    # These depend on domain models
    sequential_tasks = [
        ("handler-agent", tasks.handlers),  # Needs domain models
        ("security-agent", tasks.security),  # Needs handlers
        ("test-agent", tasks.tests),         # Needs handlers + security
    ]

    # Phase 5: Execute parallel tasks
    parallel_results = await asyncio.gather(*[
        spawn_agent(agent, task) for agent, task in parallel_tasks
    ])

    # Phase 6: Execute sequential tasks
    sequential_results = []
    for agent, task in sequential_tasks:
        result = await spawn_agent(agent, task, context=parallel_results)
        sequential_results.append(result)

    # Phase 7: Aggregate and validate
    all_results = parallel_results + sequential_results
    return aggregate_results(all_results)
```

---

## Context Injection

Each sub-agent receives:

### 1. Generative Seed Artifacts
```yaml
context:
  feature: "{feature_name}"
  artifacts:
    - DESIGN.md
    - SERVICE_SPECIFICATION.md (or DELTA)
    - IVS.md
    - NFR.md
    - TEST_SCENARIOS.md
    - ONTOLOGY.jsonld
```

### 2. Platform Context
```yaml
platform:
  capabilities: "architecture/PLATFORM_CAPABILITIES.md"
  conventions: "features/PLATFORM_CONVENTIONS.md"
  entity_model: "architecture/PLATFORM_ENTITY_MODEL.md"
```

### 3. Codebase Patterns
```yaml
patterns:
  handlers: "src/services/{service}/service_layer/handlers/"
  actions: "src/services/{service}/domain/actions/"
  models: "src/services/{service}/domain/models/"
  ports: "src/services/{service}/ports/"
  adapters: "src/services/{service}/infrastructure/"
  tests:
    unit: "tests/unit/services/{service}/"
    integration: "tests/integration/services/{service}/"
```

---

## Error Handling

### Recoverable Errors
- File not found → Re-read with correct path
- Test failure → Fix and re-run
- Lint error → Auto-fix with ruff

### Escalation Triggers
- Capability gap (blocking) → Escalate to orchestrator
- Ambiguous requirement → Escalate with options
- Conflicting constraints → Escalate for human decision
- Security concern → Escalate immediately

### Escalation Format
```json
{
  "agent": "handler-agent",
  "type": "ESCALATION",
  "severity": "BLOCKING",
  "issue": "Ambiguous permission model",
  "context": "IVS.md specifies SEC-AUTHZ-01 but SERVICE_SPEC has no permissions section",
  "options": [
    "Add permissions to SERVICE_SPEC based on IVS",
    "Clarify with user which permissions are needed"
  ],
  "recommendation": "Option 1 - derive from IVS"
}
```

---

## Atomicity Guarantee

Sub-agents work atomically when these conditions are met:

| Condition | Verified By |
|-----------|-------------|
| All design artifacts exist | orchestrator (Phase 1) |
| No capability gaps | orchestrator (Phase 2) |
| NFR constraints clear | orchestrator (Phase 2) |
| No conflicting requirements | orchestrator (Phase 2) |
| Platform context available | orchestrator (Phase 1) |

If ANY condition fails, orchestrator escalates before spawning sub-agents.

---

## Integration with OFM

```
DESIGN PHASE (complete)
         │
         ▼
GATE 1: Design Approval
         │
         ▼
IMPLEMENTATION PHASE
         │
         ├── Orchestrator validates Generative Seed
         ├── Orchestrator checks platform fit
         ├── Orchestrator spawns sub-agents
         │       ├── Domain Agent → models, repositories
         │       ├── Handler Agent → handlers, actions
         │       ├── Infra Agent → Dockerfile, sulis.yaml
         │       ├── Test Agent → unit, integration tests
         │       ├── Security Agent → auth, validation
         │       └── Cost Agent → estimates, optimization
         ├── Orchestrator aggregates results
         │
         ▼
Pre-commit checks (ruff, pytest)
         │
         ▼
GATE 2: Implementation Complete
         │
         ▼
PRODUCTION GUARDIAN
         │
         ▼
GATE 3: Release Approval
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-16 | Initial sub-agent architecture |
