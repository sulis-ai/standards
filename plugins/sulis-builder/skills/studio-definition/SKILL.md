---
name: studio-definition
description: |
  Create or migrate studio definitions using the studio-creation sequence.
  Runs studio-definition outcome + platform integration + tail outcomes
  via the outcome-orchestrator. All steps read from the sequence definition.

  TRIGGER KEYWORDS: define studio, create studio, studio definition, new studio,
  migrate function, function to studio, studio bundle, domain codification,
  encode domain, studio-definition, define function.

  USE WHEN:
  - Creating a new studio from external domain expertise (creation mode)
  - Migrating an existing Part 6 function to a studio (extraction mode)
  - User says "create a studio for X" or "define a studio"
  - User says "migrate the product function to a studio"

  METHODOLOGY SOURCE: methodology/sequences/studio-creation/SEQUENCE.md

  GENERATES:
  - 7-file studio bundle at methodology/studios/{slug}/
  - Agent pointer, studio index, sequence registry updates
  - ADR + documentation updates via tail outcomes

  ARGUMENTS:
  - description: What domain to encode (required)
  - --mode: creation | extraction (optional, will ask if not provided)
  - --slug: Target studio slug (optional, derived from description if not provided)
  - --source: Path to existing Part 6 bundle (extraction mode only)

allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion, Task, WebSearch, WebFetch, mcp__github__get_file_contents
---

# Studio Definition

> **This skill runs the `studio-creation` sequence via the outcome-orchestrator.**
>
> **Sequence:** `methodology/sequences/studio-creation/SEQUENCE.md` (AUTHORITATIVE)
> **Orchestrator:** `skills/outcome-orchestrator/SKILL.md`

---

## When Triggered

1. Parse studio description, mode, and slug from user input
2. Read the sequence definition and orchestrator:

```
Read: methodology/sequences/studio-creation/SEQUENCE.md    → sequence definition (AUTHORITATIVE)
Read: skills/outcome-orchestrator/SKILL.md          → orchestration protocol

Run sequence: studio-creation for {studio description}
  Mode: {creation | extraction}
  Slug: {studio-slug}
  Source: {path to Part 6 bundle, extraction only}
```

**The sequence definition is the single source of truth for steps, gates, and tail outcomes.**
**The outcome definitions referenced by the sequence are the source of truth for each step's process.**
Do NOT hardcode steps, gates, or outcomes — read them dynamically from the definitions.

---

## Invocation

```bash
# Create a new studio
/studio-definition "Standards lifecycle governance"
/studio-definition "Standards lifecycle governance" --mode creation --slug quality-governance

# Migrate an existing function to a studio
/studio-definition "Product development" --mode extraction --source methodology/delivery/product/
```

---

## Prerequisites

| Prerequisite | Required | Location |
|-------------|----------|----------|
| STUDIO_SCHEMA.md | Yes | `methodology/studios/STUDIO_SCHEMA.md` |
| Decomposition procedure standard | Yes | `methodology/standards/decomposition-procedure.md` |
| Existing Part 6 bundle | Extraction only | `methodology/delivery/{function}/` |

---

## Reference

- **Sequence:** `methodology/sequences/studio-creation/SEQUENCE.md` (AUTHORITATIVE)
- **Orchestrator:** `skills/outcome-orchestrator/SKILL.md`
- **Studio schema:** `methodology/studios/STUDIO_SCHEMA.md`
- **Studio registry:** `methodology/studios/index.md`

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-03-18 | Initial skill. Thin adapter for studio-definition outcome v1.0.0. |
| 2.0.0 | 2026-03-18 | Upgraded to run studio-creation sequence via orchestrator. Thin adapter — reads steps from sequence definition dynamically. |
