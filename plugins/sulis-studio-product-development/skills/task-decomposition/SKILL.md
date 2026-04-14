---
name: task-decomposition
description: |
  Decompose feature designs into implementation plans and machine-readable task specifications.
  Enables autonomous sub-agents to execute implementation without human coordination.

  TRIGGER KEYWORDS: plan implementation, create tasks, break down, decompose, task list,
  implementation plan, what are the steps, how to implement, generate tasks, create plan,
  tasks for, action items, work breakdown, sprint plan, implementation steps.

  USE WHEN:
  - Design artifacts (DESIGN.md, IVS.md, NFR.md) are complete
  - Ready to start implementation
  - Need to generate implementation tasks for sub-agents
  - Creating a plan from design specifications

  GENERATES:
  - PLAN.md - Human-readable implementation strategy
  - TASKS.yaml - Machine-readable task specifications for autonomous agents

  NOTE: This skill is now aliased by the plan skill. For the complete workflow
  including GATE 2 approval, use /sulis plan or the plan skill.

allowed-tools: Read, Write, Edit, Glob, Grep
---

# Task Decomposition Skill

> **Note:** For the complete planning workflow with GATE 2 approval, see:
> - **Command:** `/sulis plan`
> - **Skill:** `skills/plan/SKILL.md`

This skill transforms design artifacts into actionable implementation plans and
machine-readable task specifications that enable autonomous agent execution.

## When to Use This Skill

- After design phase is complete (DESIGN.md, IVS.md, NFR.md exist)
- When ready to transition from design to implementation
- When sub-agents need clear task specifications to work autonomously

## Input Requirements

The following design artifacts must exist:

```
features/{feature-name}/
├── DESIGN.md              # Technical architecture
├── IVS.md                 # Implementation verification spec
├── NFR.md                 # Non-functional requirements
├── TEST_SCENARIOS.md      # Test specifications
└── USER_GUIDE.md          # User documentation
```

## Output Artifacts

### 1. PLAN.md (Human-Readable)

Implementation strategy for humans and agents to understand the approach.

### 2. TASKS.yaml (Machine-Readable)

Structured task specifications that autonomous agents can parse and execute.

## TASKS.yaml Format

The TASKS.yaml file uses a structured format that sub-agents can parse:

```yaml
# TASKS.yaml - Machine-Readable Task Specification
# Generated from: features/{feature-name}/DESIGN.md
# Generated at: {ISO 8601 timestamp}

metadata:
  feature: "{feature-name}"
  version: "1.0.0"
  generated: "{timestamp}"
  source_artifacts:
    - DESIGN.md
    - IVS.md
    - NFR.md
    - TEST_SCENARIOS.md

constraints:
  # From NFR.md - enables autonomous decision making
  compute:
    workload_type: "service"
    cpu_max: "2"
    memory_max: "2Gi"
  performance:
    p95_latency_ms: 200
  cost:
    monthly_budget_credits: 500

phases:
  - id: "phase-1"
    name: "Domain Models"
    description: "Implement core domain models"
    depends_on: []
    tasks:
      - id: "T-1.1"
        name: "Create {Entity} model"
        type: "implementation"
        priority: 1
        complexity:
          size: medium
          rationale: "1 entity, single-step creation, adapted from existing model patterns"
        depends_on: []
        inputs:
          - artifact: "DESIGN.md"
            section: "7.4"  # Entity Model
        outputs:
          - file: "src/services/{service}/domain/models/{entity}.py"
        verification:
          - type: "test"
            command: "pytest tests/unit/services/{service}/domain/models/test_{entity}.py"
          - type: "lint"
            command: "ruff check src/services/{service}/domain/models/{entity}.py"
        acceptance_criteria:
          - "Model validates all fields per DESIGN.md schema"
          - "Type hints on all attributes"
          - "Unit tests achieve >90% coverage"
        tdd_cycle:
          red:
            - "Write test__{entity}__creation_with_valid_data"
            - "Write test__{entity}__validation_rejects_invalid_data"
          green:
            - "Implement {Entity} dataclass/model"
            - "Add validation logic"
          refactor:
            - "Extract common validation patterns"

  - id: "phase-2"
    name: "Repository Layer"
    description: "Implement repository interfaces and adapters"
    depends_on: ["phase-1"]
    tasks:
      - id: "T-2.1"
        name: "Define {Entity}Repository protocol"
        type: "implementation"
        priority: 1
        depends_on: ["T-1.1"]
        inputs:
          - artifact: "DESIGN.md"
            section: "10"  # Component Breakdown
        outputs:
          - file: "src/services/{service}/domain/ports/{entity}_repository.py"
        verification:
          - type: "typecheck"
            command: "mypy src/services/{service}/domain/ports/{entity}_repository.py"

      - id: "T-2.2"
        name: "Implement Memory{Entity}Repository"
        type: "implementation"
        priority: 1
        depends_on: ["T-2.1"]
        outputs:
          - file: "src/services/{service}/infrastructure/repositories/memory/{entity}_repository.py"
        verification:
          - type: "test"
            command: "pytest tests/unit/services/{service}/infrastructure/repositories/"
        acceptance_criteria:
          - "Implements all protocol methods"
          - "Enables fast unit testing"

  - id: "phase-3"
    name: "Handler Implementation"
    description: "Implement business logic handlers"
    depends_on: ["phase-2"]
    tasks:
      - id: "T-3.1"
        name: "Implement {Entity}Handler"
        type: "implementation"
        priority: 1
        depends_on: ["T-2.2"]
        inputs:
          - artifact: "DESIGN.md"
            section: "7.6"  # API Contract
          - artifact: "IVS.md"
            section: "SEC-*"
        outputs:
          - file: "src/services/{service}/service_layer/handlers/{entity}_handler.py"
        verification:
          - type: "test"
            command: "pytest tests/unit/services/{service}/service_layer/handlers/"
          - type: "ivs"
            requirements: ["SEC-01", "SEC-02", "OBS-01"]
        acceptance_criteria:
          - "All CRUD operations implemented"
          - "Authorization checks in place (SEC-*)"
          - "Events emitted on mutations"
          - "@operation decorator on all methods"

  - id: "phase-4"
    name: "HTTP Entrypoints"
    description: "Implement HTTP routers and endpoints"
    depends_on: ["phase-3"]
    tasks:
      - id: "T-4.1"
        name: "Implement {entity} router"
        type: "implementation"
        priority: 1
        depends_on: ["T-3.1"]
        inputs:
          - artifact: "DESIGN.md"
            section: "7.6"  # API Contract
        outputs:
          - file: "src/services/{service}/entrypoints/http/{entity}_router.py"
        verification:
          - type: "test"
            command: "pytest tests/integration/services/{service}/entrypoints/http/"
        acceptance_criteria:
          - "All endpoints from DESIGN.md implemented"
          - "Request/response schemas match spec"
          - "Error responses follow standard envelope"

  - id: "phase-5"
    name: "Integration & Verification"
    description: "Integration tests and IVS verification"
    depends_on: ["phase-4"]
    tasks:
      - id: "T-5.1"
        name: "Implement integration tests"
        type: "test"
        priority: 1
        depends_on: ["T-4.1"]
        inputs:
          - artifact: "TEST_SCENARIOS.md"
            section: "all"
        outputs:
          - file: "tests/integration/services/{service}/test_{feature}.py"
        verification:
          - type: "test"
            command: "pytest tests/integration/services/{service}/ -v"
        acceptance_criteria:
          - "All TS-* scenarios implemented"
          - "Happy path tests pass"
          - "Error scenarios covered"

      - id: "T-5.2"
        name: "Verify IVS requirements"
        type: "verification"
        priority: 1
        depends_on: ["T-5.1"]
        inputs:
          - artifact: "IVS.md"
            section: "all"
        verification:
          - type: "checklist"
            items:
              - "SEC-01: Authentication required"
              - "SEC-02: Authorization checked"
              - "OBS-01: Structured logging"
              - "REL-01: Graceful degradation"
        acceptance_criteria:
          - "All SEC-* requirements verified"
          - "All OBS-* requirements verified"
          - "All REL-* requirements verified"

summary:
  total_tasks: 7
  total_phases: 5
  complexity_profile:
    small: 2
    medium: 3
    large: 2
  blocking_requirements:
    - "SEC-*"
    - "OBS-*"
    - "REL-*"
```

## Task Types

| Type | Description | Typical Activities |
|------|-------------|-------------------|
| `implementation` | Write new code | Models, handlers, routers |
| `test` | Write tests | Unit, integration, e2e |
| `verification` | Verify requirements | IVS checks, security review |
| `documentation` | Update docs | README, API docs |
| `configuration` | Config changes | Environment, deployment |

## Task Priority

| Priority | Description | When to Use |
|----------|-------------|-------------|
| 1 | Critical path | Blocks other tasks |
| 2 | High priority | Important but not blocking |
| 3 | Normal | Standard implementation |
| 4 | Low priority | Nice to have |
| 5 | Deferred | Future enhancement |

## Decomposition Process

### Step 1: Read Design Artifacts

```yaml
inputs:
  - DESIGN.md → Architecture, components, API contract
  - IVS.md → Verification requirements (SEC-*, OBS-*, REL-*)
  - NFR.md → Constraints for autonomous decisions
  - TEST_SCENARIOS.md → Test specifications
```

### Step 2: Identify Phases

Standard phases for most features:

1. **Domain Models** - Core entities and value objects
2. **Repository Layer** - Data access interfaces and implementations
3. **Handler Layer** - Business logic and orchestration
4. **HTTP Layer** - API endpoints and routing
5. **Integration & Verification** - Tests and IVS verification

### Step 3: Generate Tasks per Phase

For each phase:

1. Identify components from DESIGN.md
2. Create task for each component
3. Define dependencies between tasks
4. Map IVS requirements to tasks
5. Define acceptance criteria
6. Add verification commands

### Step 4: Add Constraints from NFR.md

Extract constraints that enable autonomous decisions:

```yaml
constraints:
  compute:
    workload_type: "{from COMP-01}"
    cpu_max: "{from COMP-10}"
    memory_max: "{from COMP-11}"
  performance:
    p95_latency_ms: "{from PERF-02}"
  cost:
    monthly_budget_credits: "{from COST-01}"
```

### Step 5: Define TDD Cycles

For implementation tasks, define RED-GREEN-REFACTOR:

```yaml
tdd_cycle:
  red:
    - "Write failing test for [scenario]"
  green:
    - "Implement minimal code to pass"
  refactor:
    - "Clean up and extract patterns"
```

## PLAN.md Generation

Generate PLAN.md alongside TASKS.yaml:

```markdown
# {Feature Name} - Implementation Plan

## Context

{From PR_FAQ.md and DESIGN.md executive summary}

## Approach

### Hardest Problems First

1. **{Primary Risk}** - {Description and mitigation}
2. **{Secondary Risk}** - {Description and mitigation}

## Implementation Phases

### Phase 1: Domain Models

**Goal:** Implement core entities per DESIGN.md Section 7.4

**Tasks:**
- T-1.1: Create {Entity} model

**Exit Criteria:**
- All models pass validation tests
- >90% unit test coverage

### Phase 2: Repository Layer

**Goal:** Implement data access layer

**Tasks:**
- T-2.1: Define repository protocols
- T-2.2: Implement memory repositories

### Phase 3: Handler Layer

...

## Dependencies

{From DESIGN.md Section 4.5}

## Testing Strategy

{From TEST_SCENARIOS.md}

## IVS Requirements

All requirements are BLOCKING:

| Category | Requirements | Tasks |
|----------|--------------|-------|
| Security | SEC-01, SEC-02, SEC-03 | T-3.1, T-5.2 |
| Observability | OBS-01, OBS-02 | T-3.1, T-5.2 |
| Reliability | REL-01, REL-02 | T-3.1, T-5.2 |
```

## Agent Execution Protocol

When a sub-agent picks up a task from TASKS.yaml:

1. **Read task specification**
   - Understand inputs, outputs, acceptance criteria
   - Check dependencies are complete

2. **Read source artifacts**
   - Load referenced sections from design docs
   - Understand context and constraints

3. **Execute TDD cycle**
   - RED: Write failing tests
   - GREEN: Implement to pass
   - REFACTOR: Clean up

4. **Run verification**
   - Execute verification commands
   - Confirm acceptance criteria met

5. **Update task status**
   - Mark task complete in TASKS.yaml
   - Record completion timestamp

## Example: Task Execution

Agent receives task T-1.1:

```yaml
- id: "T-1.1"
  name: "Create Notification model"
  inputs:
    - artifact: "DESIGN.md"
      section: "7.4"
  outputs:
    - file: "src/services/notifications/domain/models/notification.py"
  acceptance_criteria:
    - "Model validates all fields per DESIGN.md schema"
    - "Type hints on all attributes"
    - "Unit tests achieve >90% coverage"
```

Agent execution:

1. Read DESIGN.md Section 7.4 for entity schema
2. Write test: `test__notification__creation_with_valid_data`
3. Run test (fails - RED)
4. Implement Notification model
5. Run test (passes - GREEN)
6. Refactor for clarity
7. Run verification: `pytest tests/unit/.../test_notification.py`
8. Verify coverage: `pytest --cov=...`
9. Mark T-1.1 complete

## Integration with Other Skills

| Skill | Relationship |
|-------|--------------|
| `design` | Provides input artifacts (DESIGN.md, IVS.md, NFR.md) |
| `platform-capabilities` | Referenced by NFR constraints |
| `backend-development` | Uses TASKS.yaml for implementation guidance |
| `test-scenarios` | Uses TASKS.yaml for test implementation |

## Checklist Before Generating Tasks

- [ ] DESIGN.md exists and is complete
- [ ] IVS.md has SEC-*, OBS-*, REL-* requirements
- [ ] NFR.md has compute, performance, cost constraints
- [ ] TEST_SCENARIOS.md has test specifications
- [ ] All design artifacts approved (GATE 1 passed)

## Files in This Skill

```
skills/task-decomposition/
└── SKILL.md                # This file
```
