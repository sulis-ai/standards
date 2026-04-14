# Feature Completion Protocol

> **Quick checklist to ensure no step is missed before marking a feature complete.**
>
> **Phase Advancement:** Gates control phase transitions. Each gate passage advances the phase
> and is recorded in LIFECYCLE_STATE.json for audit.

---

## Phase Advancement Protocol

### Gate Passage Updates LIFECYCLE_STATE.json

When a gate passes, the following updates MUST occur:

| Gate | From Phase | To Phase | State Updates |
|------|------------|----------|---------------|
| GATE 1: Design Approval | design | plan | Record gate, advance phase |
| GATE 2: Plan Approval | plan | implementation | Record gate, advance phase |
| GATE 3: Release Approval | release | completion | Record gate, advance phase |
| GATE 4: User Sign-off | completion | complete | Mark feature complete |

### On Gate Passage

Update LIFECYCLE_STATE.json with:

```json
{
  "current_phase": "{next_phase}",
  "phase_status": "IN_PROGRESS",
  "phases": {
    "{completed_phase}": {
      "status": "complete",
      "completed_at": "{ISO 8601 timestamp}",
      "gate": {
        "name": "{gate_name}",
        "passed": true,
        "passed_at": "{ISO 8601 timestamp}",
        "approver": "User"
      }
    },
    "{next_phase}": {
      "status": "in_progress",
      "started_at": "{ISO 8601 timestamp}"
    }
  },
  "navigation": {
    "previous_phase": "{completed_phase}",
    "next_phase": "{phase_after_next}",
    "recommended_action": "{action for next phase}",
    "command": "/sulis {next_phase_command}"
  }
}
```

### Example: GATE 1 Passage (Design → Plan)

```json
{
  "current_phase": "plan",
  "phase_status": "PENDING",
  "phases": {
    "design": {
      "status": "complete",
      "completed_at": "2026-01-19T21:00:00Z",
      "gate": {
        "name": "GATE 1: Design Approval",
        "passed": true,
        "passed_at": "2026-01-19T21:00:00Z",
        "approver": "User"
      }
    },
    "plan": {
      "status": "pending"
    }
  },
  "navigation": {
    "previous_phase": "design",
    "next_phase": "implementation",
    "recommended_action": "Create implementation plan",
    "command": "/sulis plan {feature-name}"
  }
}
```

### Example: GATE 4 Passage (Complete Feature)

```json
{
  "current_phase": "complete",
  "phase_status": "COMPLETE",
  "phases": {
    "completion": {
      "status": "complete",
      "completed_at": "2026-01-20T10:00:00Z",
      "gate": {
        "name": "GATE 4: User Sign-off",
        "passed": true,
        "passed_at": "2026-01-20T10:00:00Z",
        "approver": "User"
      }
    }
  },
  "navigation": {
    "previous_phase": "completion",
    "next_phase": null,
    "recommended_action": "Feature complete - no further action",
    "command": null
  },
  "completed_at": "2026-01-20T10:00:00Z"
}
```

---

## Pre-Completion Checklist

### Phase 1: DESIGN Complete?
- [ ] PR_FAQ.md created and approved
- [ ] USER_GUIDE.md created with all sections
- [ ] TEST_SCENARIOS.md derived from User Guide
- [ ] DESIGN.md complete with architecture
- [ ] IVS.md has SEC-*/OBS-*/REL-* requirements
- [ ] TRACEABILITY.jsonld generated
- [ ] Feature registered in `features/index.md`
- [ ] **User approved design**

### Phase 2: IMPLEMENTATION Complete?
- [ ] PLAN.md created
- [ ] TASKS.md created and 100% complete
- [ ] All unit tests pass
- [ ] All integration tests pass
- [ ] Pre-commit checks pass (`uv run nox -s pre-commit`)
- [ ] All IVS verification requirements met
- [ ] CHANGELOG.md updated
- [ ] **User reviewed implementation**

### Phase 3: RELEASE Complete?
- [ ] Code committed with meaningful message
- [ ] Code pushed to remote
- [ ] CI/CD pipeline succeeded
- [ ] Deployment healthy
- [ ] Production Guardian review: APPROVED
- [ ] Post-deployment verification passed
- [ ] Guardian report saved in `reviews/`

### Phase 4: COMPLETION Complete?

#### 4a. Spec Canonicalization (if applicable)
- [ ] **For `service` classification:**
  - [ ] SERVICE_SPECIFICATION.md moved to `features/services/{name}/`
  - [ ] changelog.md created in `features/services/{name}/`
  - [ ] `features/services/index.md` updated with new service
- [ ] **For `service_enhancement` classification:**
  - [ ] SERVICE_SPECIFICATION_DELTA.md merged into `features/services/{parent}/SERVICE_SPECIFICATION.md`
  - [ ] Parent spec version bumped (X.Y.Z → X.Y+1.0)
  - [ ] `features/services/{parent}/changelog.md` updated with changes
  - [ ] Delta marked as merged in LIFECYCLE_STATE.json
- [ ] **For `extension` classification:**
  - [ ] EXTENSION_SPECIFICATION.md moved to `.extensions/{name}/`
  - [ ] `.extensions/index.md` updated
- [ ] **For `capability` classification:**
  - [ ] CAPABILITY_SPECIFICATION.md moved to `.capabilities/{name}/`
  - [ ] `.capabilities/index.md` updated

#### 4b. Entity Model Updates (if applicable)
- [ ] ENTITY_MODEL_DELTA.md merged into PLATFORM_ENTITY_MODEL.md

#### 4c. Documentation & Registry Updates
- [ ] PLATFORM_CONVENTIONS.md updated (if new patterns)
- [ ] `/docs` updated with user documentation
- [ ] `features/index.md` status updated to "complete"
- [ ] LIFECYCLE_STATE.json finalized with completion info
- [ ] **User explicitly signed off**

---

## Red Flags - STOP If Any Are True

- [ ] Tests failing
- [ ] Pre-commit checks failing
- [ ] Production Guardian BLOCKED
- [ ] Deployment unhealthy
- [ ] Work deferred without explicit user approval
- [ ] User has not approved current phase

---

## Quick Commands

```bash
# Check test status
uv run nox -s pre-commit

# Check feature state
cat features/{name}/LIFECYCLE_STATE.json | jq '.current_phase, .phases[].status'

# Verify deployment
curl -s https://{deployment-url}/health | jq

# Run Production Guardian
/production-guardian
```

---

## Deferral Request Template

If work must be deferred, use this format:

```
## Deferral Request

**Phase:** [DESIGN|IMPLEMENTATION|RELEASE|COMPLETION]
**Item:** [What is being deferred]
**Reason:** [Why it cannot be completed now]
**Impact:** [What happens without this]
**Follow-up:** [When/how will this be addressed]

Do you approve this deferral? [yes/no]
```

---

## Sign-off Request Template

At completion, present to user:

```
## Feature Complete: {feature-name}

### Summary
- Started: {start_date}
- Completed: {end_date}
- Duration: {hours} hours

### Deliverables
- [ ] Design artifacts in `features/{name}/`
- [ ] Implementation in `src/...`
- [ ] Tests in `tests/...`
- [ ] Documentation updated

### Production Status
- Deployment: {healthy/unhealthy}
- Guardian: {APPROVED/CONDITIONAL}

### Pending Items
{none OR list of approved deferrals}

---

Please confirm this feature is complete: [yes/no]
```
