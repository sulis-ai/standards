---
name: outcome-definition
description: |
  Define well-formed outcomes using PACER + SMART frameworks before any design work begins.
  This is Phase 0 of the Generative Feature Framework—the entry point that validates
  whether a goal is worth pursuing.

  TRIGGER KEYWORDS: define outcome, outcome definition, pacer, smart goal, well-formed goal,
  is this achievable, should we build, viability check, goal definition, what should we build,
  clarify goal, refine goal, validate idea, idea validation, before we start.

  USE WHEN:
  - User has an idea but hasn't validated it's well-formed
  - Starting a new feature or product
  - User says "I want to build X" without clear success criteria
  - Need to validate achievability before investing effort
  - Unclear if idea is viable

  GENERATES:
  - OUTCOMES.md - PACER + SMART analysis with lens perspectives
  - Living Context File initialization
  - Viability assessment with PROCEED | REFINE | ABANDON recommendation

allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion, Task, WebSearch, WebFetch, mcp__github__get_file_contents
---

# Outcome Definition Skill - Phase 0

> **Purpose:** Validate that a goal is well-formed before any other work begins.
> This is the "engagement letter" that ensures alignment between what the user wants
> and what is achievable.
>
> **Framework:** Implements **Phase 0 of the Outcome-First Methodology (OFM)**
> See: `product/research/platform/OFM_TRIAD_ARCHITECTURE.md`

---

## Core Principles

> **"If you can't articulate a clear outcome, you don't know what you're building."**
>
> **"Honest assessment is more valuable than false optimism."**
>
> **"Well-formed goals prevent wasted effort—this phase is NOT optional."**

---

## The Three Lenses

> **Phase 0 uses the Outcome Definition Triad.**
> Each lens asks a different question to ensure the goal is well-formed.

| Lens | Question | Focus |
|------|----------|-------|
| **User Advocate** | "What does success mean for the user?" | Outcomes, emotions, jobs-to-be-done, what "done" looks like |
| **Evidence Analyst** | "What does data say is achievable?" | Market precedents, comparable outcomes, realistic constraints |
| **Resource Strategist** | "What will this require and return?" | Investment needed, timeline, expected ROI, opportunity cost |

**Lead Lens:** User Advocate (it's their outcome that drives everything)

---

## Required Reading

Before starting outcome definition:

1. **`.sulis/planning/templates/OUTCOMES_TEMPLATE.md`** - Template structure
2. **`product/offerings/primary/VISION.md`** - Product vision (if exists)
3. **`product/offerings/primary/STRATEGY.md`** - Current strategy (if exists)
4. **`product/offerings/primary/ANTI_GOALS.md`** - What we won't do (if exists)

---

## Process

### Step 1: Capture the Idea

> **Do NOT interpret or refine yet—preserve the original intent.**

1. Record the user's exact statement
2. Note any initial context provided (constraints, expertise, resources)
3. Ask clarifying questions if the idea is too vague to analyze

**Coaching Questions:**
- "What problem are you trying to solve?"
- "Who is this for?"
- "What does success look like to you?"

---

### Step 2: User Advocate Analysis

> **Lens Focus:** What does the user truly want?

**Tasks:**
1. Interview user about desired outcome
2. Capture emotional drivers ("Why do you want this?")
3. Define success criteria ("How will you know you've succeeded?")
4. Produce draft PACER-P (Positively Stated) and PACER-A (Achievement Focused)

**Coaching Questions:**
- "What will be different when this is done?"
- "How will you feel when this succeeds?"
- "What would make you disappointed even if we technically delivered?"
- "What's the ONE thing this must do to be worthwhile?"

**Output:**
```
PACER-P: [What the user wants, stated positively]
PACER-A: [Concrete success indicators]
User's True Need: [What they really want, which may differ from stated]
Emotional Drivers: [Why this matters to them personally]
```

---

### Step 3: Evidence Analyst Analysis

> **Lens Focus:** Is this achievable? What does evidence say?

**Tasks:**
1. Search for comparable outcomes (similar products, projects, achievements)
2. Identify realistic constraints from evidence
3. Assess achievability with data, not assumptions
4. Produce PACER-C (Contextual) assessment and achievability rating

**Research Protocol:**
- Search for "X achieved by Y" (precedent)
- Search for "X failed because" (counter-evidence)
- Search for "X constraints" or "X challenges" (realistic limits)

**Achievability Rating:**

| Rating | Criteria |
|--------|----------|
| **HIGH** | 3+ examples of similar outcomes achieved in similar contexts |
| **MEDIUM** | Some precedent exists, but context differs significantly |
| **LOW** | No precedent found, or significant constraints identified |
| **UNKNOWN** | Insufficient evidence to assess |

**Output:**
```
PACER-C: [Context and constraints from evidence]
Comparable Outcomes: [List with sources]
Constraints Identified: [List with sources]
Achievability: [HIGH | MEDIUM | LOW | UNKNOWN]
Counter-Evidence: [What suggests this might NOT work]
```

---

### Step 4: Resource Strategist Analysis

> **Lens Focus:** What will this require and return?

**Tasks:**
1. Map required resources (capabilities, expertise, time, budget)
2. Identify what's available vs what's missing
3. Calculate rough ROI/payback
4. Produce PACER-E (Ecological) and PACER-R (Resources) assessment

**Resource Categories:**
- **Platform Capabilities:** What does the platform provide?
- **Domain Expertise:** What knowledge is needed?
- **Time:** How long will this take?
- **Budget:** What's the cost?
- **Opportunity Cost:** What else could we be doing?

**Output:**
```
PACER-E: [How this fits in the broader system]
PACER-R: [Resources required vs available]
Investment Required: [Time, cost, effort]
Expected Return: [Value created, ROI timeline]
Opportunity Cost: [What we're NOT doing]
Resource Gaps: [What's missing]
```

---

### Step 5: Synthesis Process

> **This is a PROCESS, not an agent. The User Advocate leads.**

1. **User Advocate drafts OUTCOMES.md** using template
2. **Evidence Analyst reviews** and adds findings
3. **Resource Strategist reviews** and adds findings
4. **Identify tensions** between lenses
5. **Document tensions explicitly** (do NOT average them away)
6. **Escalate unresolved tensions** to user for decision
7. **All three lenses sign off** or document outstanding concerns

---

### Step 6: Viability Assessment

> **This is the decision gate—be honest.**

**Blocking Concern Categories:**

| Category | Examples |
|----------|----------|
| **Market** | No evidence of demand, problem already solved |
| **Technical** | Required capability doesn't exist, can't be built |
| **Resource** | Insufficient time/budget/expertise, critical gap |
| **Strategic** | Conflicts with vision, violates anti-goals |
| **Timing** | Market window closed, dependencies unavailable |

**Recommendation Criteria:**

| Recommendation | When to Use |
|----------------|-------------|
| **PROCEED** | All PACER elements defined, all lenses signed off, no blocking concerns |
| **REFINE** | Outcome not well-formed, tensions need resolution, gaps need filling |
| **ABANDON** | Blocking concerns identified that cannot be addressed |

**If ABANDON:** Be compassionate but clear. Explain:
- What the blocking concern is
- Why it can't be addressed
- What alternatives might exist
- Why stopping now saves time and effort

---

### Step 7: Gate Approval

> **All criteria must be met to proceed to Phase 1.**

| Criterion | Required |
|-----------|----------|
| All PACER elements defined | Yes |
| SMART goals specified | Yes |
| All three lenses signed off | Yes |
| No unresolved blocking concerns | Yes |
| Recommendation is PROCEED | Yes |
| User confirms understanding | Yes |

**If criteria not met:** Return to Step 5 (Synthesis) and iterate.

---

## Output Artifacts

```
features/{feature-name}/
└── OUTCOMES.md
    ├── The Idea (original statement)
    ├── PACER Analysis (with lens attribution)
    ├── SMART Goals
    ├── Lens Perspectives
    ├── Documented Tensions
    ├── MECE Validation
    ├── Sign-Off Record
    ├── Viability Assessment
    └── Approval
```

**Template:** `.sulis/planning/templates/OUTCOMES_TEMPLATE.md`

---

## Living Context File Initialization

> **Phase 0 initializes the Living Context File that persists across all phases.**

After OUTCOMES.md is approved, create initial context:

```json
{
  "living_context": {
    "feature": "{feature-name}",
    "created_at": "{timestamp}",
    "last_updated": "{timestamp}",

    "user_provided": {
      "original_idea": "{exact user statement}",
      "first_hand_insights": [
        {
          "phase": "outcome_definition",
          "lens": "user_advocate",
          "timestamp": "...",
          "insight": "{key insight about user's true needs}",
          "relevance": "{why this matters downstream}"
        }
      ],
      "constraints": ["{constraint 1}", "{constraint 2}"],
      "decisions": []
    },

    "lens_outputs": {
      "phase_0": {
        "user_advocate": {
          "findings": "{summary}",
          "concerns": "{any outstanding}",
          "signed_off": true
        },
        "evidence_analyst": {
          "findings": "{summary}",
          "concerns": "{any outstanding}",
          "signed_off": true
        },
        "resource_strategist": {
          "findings": "{summary}",
          "concerns": "{any outstanding}",
          "signed_off": true
        },
        "tensions": ["{documented tensions}"],
        "resolution": "{how resolved}"
      }
    },

    "bridge_handoffs": [
      {
        "from_phase": 0,
        "to_phase": 1,
        "context_summary": "{what the next phase needs to know}",
        "key_constraints": ["{constraint 1}", "{constraint 2}"],
        "open_questions": ["{what still needs validation}"]
      }
    ]
  }
}
```

---

## What Happens Next

| Recommendation | Next Phase |
|----------------|------------|
| **PROCEED** (new product) | Phase 0.5: Strategic Foundation |
| **PROCEED** (existing product) | Phase 1: Journey Definition |
| **REFINE** | Iterate on OUTCOMES.md |
| **ABANDON** | Stop—document learnings |

---

## Anti-Patterns to Avoid

| Anti-Pattern | Why It's Wrong | What to Do Instead |
|--------------|----------------|-------------------|
| Skip Phase 0 | Leads to building wrong thing | Always validate outcome first |
| Assume achievability | Leads to wasted effort | Search for evidence |
| Average tensions | Loses valuable trade-off info | Document tensions explicitly |
| False optimism | Leads to disappointed users | Be honest about viability |
| Rush to solution | Misses user's true need | Spend time on User Advocate |
| Ignore counter-evidence | Leads to blind spots | Actively search for disconfirming data |

---

## Example Output Summary

```
✅ Outcome Definition Complete

📁 Feature: {feature-name}
📍 Location: features/{feature-name}/OUTCOMES.md

PACER Analysis:
✓ P (Positively Stated): Clear positive outcome defined
✓ A (Achievement): 4 measurable success indicators
✓ C (Contextual): 2 comparable precedents found
✓ E (Ecological): Aligns with vision, no anti-goal conflicts
✓ R (Resources): All required resources available

SMART Goals:
✓ Specific: Scope clearly bounded
✓ Measurable: 3 quantified metrics
✓ Achievable: HIGH confidence (3 precedents)
✓ Relevant: Supports primary journey
✓ Time-bound: 2-week timeline

Lens Sign-Off:
✓ User Advocate: Signed off
✓ Evidence Analyst: Signed off
✓ Resource Strategist: Signed off

Viability Assessment:
✓ Blocking Concerns: None identified
✓ Open Questions: 1 (to be validated in Phase 1)
✓ Recommendation: PROCEED

Living Context File: Initialized

Next Steps:
→ Phase 0.5: Strategic Foundation (if new product)
→ Phase 1: Journey Definition (if existing product)
```

---

## Reference

- **Template:** `.sulis/planning/templates/OUTCOMES_TEMPLATE.md`
- **Triad Architecture:** `product/research/platform/OFM_TRIAD_ARCHITECTURE.md`
- **PACER Framework:** `product/research/goals.md`
- **OFM:** `architecture/GENERATIVE_FEATURE_FRAMEWORK.md`
