---
name: implementation-context
description: |
  Thin adapter invoking OFM outcomes for implementation context assessment.

  For FEATURE class work: Invokes project-context → implementation-assessment sequence.
  For BUG/SMALL class work: Performs lightweight tech radar check (no formal assessment).

  TRIGGER KEYWORDS: implementation context, tech stack, what technologies, how to implement,
  implementation approach, what language, what framework, deployment approach, tech assessment,
  implementation assessment, technology assessment.

  USE WHEN:
  - During design phase, BEFORE writing DESIGN.md
  - When determining appropriate implementation language/framework
  - When considering introducing new technology

  RETURNS:
  - For Feature: IMPLEMENTATION_ASSESSMENT.md (via OFM outcome)
  - For Bug/Small: Lightweight IMPLEMENTATION_CONTEXT.md section for DESIGN.md

allowed-tools: Read, Glob, Grep, WebSearch, WebFetch, mcp__github__get_file_contents
---

# Implementation Context Assessment

> **Thin adapter — methodology lives in OFM outcomes.**
>
> - **Feature class:** Fetch via GitHub MCP: `outcomes/utility/project-context/OUTCOME.md` → `outcomes/utility/implementation-assessment/OUTCOME.md`
> - **Bug/Small class:** Lightweight tech radar check below
>
> Fetch outcome definitions before executing:
> ```
> mcp__github__get_file_contents(owner, repo, path="methodology/outcomes/utility/project-context/OUTCOME.md", ref)
> mcp__github__get_file_contents(owner, repo, path="methodology/outcomes/utility/implementation-assessment/OUTCOME.md", ref)
> ```
> Use `ofm-bindings.yaml` for repo config. See `skills/shared/bindings.md` for resolution pattern.

---

## Feature Class (Full Assessment)

For Feature-class work, this skill is superseded by the new-feature sequence Steps 2-3:

1. **Step 2: project-context** — Gathers existing capabilities, constraints, TECH_RADAR.md
2. **Step 3: implementation-assessment** — Produces IMPLEMENTATION_ASSESSMENT.md with fitness ratings (FIT/ADAPTABLE/UNFIT), claim verification, and binding conditions (IA-BC-01 to IA-BC-07)

These steps execute automatically as part of the new-feature sequence. Do not invoke this skill separately for Feature-class work — the sequence orchestrator handles it.

**OFM outcomes:**
- Project context: fetch `outcomes/utility/project-context/OUTCOME.md` via GitHub MCP
- Implementation assessment: fetch `outcomes/utility/implementation-assessment/OUTCOME.md` via GitHub MCP

---

## Bug/Small Class (Lightweight Assessment)

For Bug/Small-class work that doesn't use the full new-feature sequence:

1. Read `architecture/TECH_RADAR.md` for approved technologies
2. Identify which existing patterns apply to the change
3. Confirm no new technology introduction is needed
4. If new tech IS needed, escalate to Feature class (triggers full sequence)

**Output:** A brief "Implementation Context" section for DESIGN.md:

```markdown
## Implementation Context

**Classification:** Bug/Small
**Tech Radar Check:** All technologies in approved radar
**Existing Patterns:** {which patterns apply}
**New Technology:** None required
```

---

## Files Referenced

```
methodology/outcomes/utility/project-context/OUTCOME.md        # Full project context outcome
methodology/outcomes/utility/implementation-assessment/OUTCOME.md  # Full assessment outcome
architecture/TECH_RADAR.md                               # Approved technologies
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-02-01 | Initial implementation (full assessment in skill) |
| 2.0.0 | 2026-02-15 | Rewritten as thin adapter; Feature class delegates to OFM outcomes (project-context + implementation-assessment); Bug/Small retains lightweight tech radar check |
