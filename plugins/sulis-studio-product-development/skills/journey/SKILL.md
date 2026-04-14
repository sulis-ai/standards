# Journey Definition Skill

> **Thin adapter that invokes the journey-lifecycle sequence.**
> **DC-09 Compliant:** Methodology is in the outcome, not here.

---

## Purpose

Invoke the **journey-lifecycle** sequence to define validated user journeys that drive feature development. The sequence definition is the single source of truth for steps, gates, and handoff contracts.

> **"Journeys are the unit of value. Features are implementation details."**

---

## Command Integration

```bash
/sulis journey "deploy my first application"    # Create new journey
/sulis journey status {name}                    # Show journey status
/sulis journey list                             # List all journeys
```

---

## Invocation

```
Fetch: mcp__github__get_file_contents(owner, repo, path="methodology/delivery/product/SEQUENCES.md", ref) → sequence definition (AUTHORITATIVE)
Read: skills/outcome-orchestrator/SKILL.md → orchestration protocol
Run sequence: journey-lifecycle for {journey-name}
```
Use `ofm-bindings.yaml` for repo config. See `skills/shared/bindings.md` for resolution pattern.

**The sequence definition in SEQUENCES.md is the single source of truth.**
Do NOT hardcode steps, gates, or outcomes here — read them from the definition.

---

## Output Location

All artifacts are created in `product/offerings/primary/journeys/{journey-name}/`.
The exact artifact set is defined by the journey-definition outcome — read its OUTCOME.md.

---

## Related

- **Sequence:** fetch `delivery/product/SEQUENCES.md` via GitHub MCP (journey-lifecycle)
- **Core outcome:** fetch `delivery/product/outcomes/journey-definition/OUTCOME.md` via GitHub MCP
- **Command:** `/sulis-studio-product-development:journey`

---

## Version

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-22 | Initial definition |
| 2.0.0 | 2026-02-01 | DC-09 migration: Thin adapter. Methodology moved to outcome |
| 3.0.0 | 2026-02-24 | Sequence migration: Invokes journey-lifecycle sequence (not just journey-definition outcome). References product SEQUENCES.md as canonical. |
| 4.0.0 | 2026-03-19 | Remove baked-in sequence chain. SEQUENCES.md is the single source of truth — read it at invocation time, don't duplicate here. |
