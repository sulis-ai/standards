# Implementation System Skill

> **"Design tokens in; developer primitives out."**
>
> This skill translates DESIGN_TOKENS.json into the developer and
> agent-consumable primitives that bridge design authority to
> implementation: Token map, Value canon, Component-API contracts,
> Framework rules, and Gotchas registry.
>
> **Philosophy:** Design system value is zero unless developers can
> consume it without re-inferring tokens or drifting from authority.

---

## Command Integration

This skill is invoked via `/sulis-design:implementation-system`:

```bash
/sulis-design:implementation-system             # View current implementation primitive state
/sulis-design:implementation-system create      # Generate primitives from DESIGN_TOKENS.json
/sulis-design:implementation-system evolve      # Update primitives after token changes
```

---

## TRIGGER KEYWORDS

### Exact Match (High Intent)
- "implementation system", "design primitives", "token map"
- "value canon", "component API", "gotchas registry"
- "design to code", "developer primitives", "agent primitives"
- "token bridge", "framework rules"

### Broad Match (Discovery)
- CSS custom properties, tailwind tokens, design token consumption
- how do I use the design tokens, token classes

---

## Execution

### Outcome

Invoke `implementation-system` via the outcome-executor:

```
Outcome: implementation-system
Path: methodology/outcomes/utility/implementation-system/OUTCOME.md
```

### Prerequisites

| Input | Required | Source |
|-------|----------|--------|
| DESIGN_TOKENS.json | Yes | `product/design/DESIGN_TOKENS.json` (from design-foundation) |
| HIG.md | Recommended | `product/design/HIG.md` (component interaction patterns) |
| DESIGN_LANGUAGE.md | Recommended | `product/design/DESIGN_LANGUAGE.md` |

### Outputs

| Artifact | Location |
|----------|----------|
| TOKEN_MAP.json | framework adapter output root |
| VALUE_CANON.json | framework adapter output root |
| COMPONENT_API manifests | framework adapter output root |
| GOTCHAS.index.json | framework adapter output root |
| LOADABILITY_REPORT.json | workspace |
| IDEMPOTENCY_REPORT.json | workspace |

### Sequencing

Implementation system bridges design to product-development:

```
design-foundation (DESIGN_TOKENS.json) -> implementation-system -> design-compliance
```

Invoke after design-foundation produces or updates DESIGN_TOKENS.json. Re-invoke
in evolution mode whenever tokens change (triggered via design-evolve → change-propagation
ring-1 cascade).

### Evolution Mode

When tokens change, implementation-system re-executes in evolution mode:
- Detects delta against recorded input checksums
- Updates only affected primitives
- Emits CHANGE_MANIFEST to `.sulis/change-manifests/implementation-system.json`
- Inherits `ring_context.propagation_id` from upstream CHANGE_MANIFEST (does not generate new UUID)

---

## View Mode

When invoked without a subcommand, display the current state:

1. Check if TOKEN_MAP.json, VALUE_CANON.json, GOTCHAS.index.json exist at adapter output root
2. Check LOADABILITY_REPORT.json and IDEMPOTENCY_REPORT.json status
3. Check recorded_checksums.json against current DESIGN_TOKENS.json (detect stale primitives)
4. Summarise primitive coverage and whether product-development can consume the current state
