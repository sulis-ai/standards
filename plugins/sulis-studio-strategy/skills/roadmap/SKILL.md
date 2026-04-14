# Roadmap Management Skill

> **"Roadmaps sequence value delivery across journeys."**
>
> This skill manages the product roadmap that spans journeys and features.
> It prioritizes based on user value, dependencies, and strategic goals.
>
> **Philosophy:** Roadmapping is fundamentally a human decision-making process.
> AI can analyze, suggest, and visualize - but approval and prioritization
> decisions are yours to make.

---

## Command Integration

This skill is invoked via `/sulis roadmap`:

```bash
/sulis roadmap                  # View current roadmap
/sulis roadmap view             # Same as above
/sulis roadmap prioritize       # Re-prioritize features
/sulis roadmap update           # Sync from journeys/features
/sulis roadmap add {feature}    # Add feature to roadmap
/sulis roadmap status {feature} # Show feature roadmap status
```

### Roadmap Artifacts

```
product/roadmap/
├── ROADMAP.md              # Current roadmap view
├── PRIORITIES.md           # Prioritization rationale
├── DEPENDENCIES.md         # Feature dependencies
└── PROGRESS.md             # Progress tracking
```

---

## Integration with Journeys

The roadmap now integrates with the journey-driven development model:

```
┌─────────────────────────────────────────────────────────────────────────┐
│  JOURNEYS (product/offerings/primary/journeys/{name}/)                                            │
│  Define user goals and identify capability gaps                          │
│                                                                          │
│  GAP_ANALYSIS.md → Features needed                                      │
└─────────────────────────────────────────────────────────────────────────┘
                                   │
                                   │ Gaps become roadmap items
                                   ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  ROADMAP (product/roadmap/)                                                     │
│  Prioritize and sequence features across journeys                        │
│                                                                          │
│  ROADMAP.md → Now / Next / Later                                        │
│  PRIORITIES.md → Scoring rationale                                      │
└─────────────────────────────────────────────────────────────────────────┘
                                   │
                                   │ Features designed and implemented
                                   ▼
┌─────────────────────────────────────────────────────────────────────────┐
│  FEATURES (features/{name}/)                                            │
│  Execute via feature lifecycle                                               │
│                                                                          │
│  /sulis design → /sulis implement → /sulis deploy           │
└─────────────────────────────────────────────────────────────────────────┘
```

### Journey Progress Tracking

The roadmap tracks progress toward journey completion:

```markdown
| Journey | Status | Milestones | Features | Completion |
|---------|--------|------------|----------|------------|
| first-app-deployment | IN_PROGRESS | 2/4 | 3/5 | 60% |
| team-collaboration | PROPOSED | 0/3 | 0/4 | 0% |
```

---

## TRIGGER KEYWORDS

> **Disambiguation:** This skill is for MANAGING what to build (prioritization, sequencing).
> Feature-lifecycle is for BUILDING things. Research is for INVESTIGATING things.
>
> - "What should we build next?" → Roadmap skill (this one)
> - "Build feature X" → Feature-lifecycle
> - "Research how X works" → Research skill

### Exact Match Phrases (High Confidence - These ARE roadmap tasks)

**Roadmap/Backlog Management:**
- "add to backlog", "add to the backlog", "put on backlog"
- "review the roadmap", "show roadmap", "roadmap status"
- "update roadmap", "roadmap planning", "product roadmap"
- "feature backlog", "review backlog", "backlog review"
- "approve feature", "reject feature", "defer feature"

**Prioritization (Kano Method):**
- "kano analysis", "kano classification", "kano category"
- "must-be feature", "performance feature", "delighter feature"
- "what should we build next", "what to build next", "which feature first"
- "prioritize features", "feature prioritization", "priority order"
- "rank features", "order features", "feature ranking"
- "value effort", "value vs effort", "effort vs value"
- "priority matrix", "priority score"

**Dependency Analysis:**
- "dependency graph", "dependency analysis", "analyze dependencies"
- "critical path", "show dependencies", "what blocks what"
- "blocked by", "blocking", "prerequisite features"
- "feature dependencies", "roadmap dependencies"

### Broad Match Terms (Need Context - May overlap with other skills)

> **IMPORTANT:** These terms ALONE do not trigger this skill.
> They only trigger when combined with roadmap/prioritization context.

| Term | Triggers Roadmap When... | Triggers Other Skill When... |
|------|--------------------------|------------------------------|
| "roadmap" | "review the roadmap", "roadmap priorities" | "build a roadmap feature" → feature-lifecycle |
| "backlog" | "add to backlog", "backlog items" | "backlog item for X feature" → feature-lifecycle |
| "priority" | "set priority", "priority order" | "priority queue implementation" → feature-lifecycle |
| "plan" | "plan features", "planning session" | "implementation plan" → feature-lifecycle |
| "planning" | "roadmap planning", "quarterly planning" | "planning to build X" → feature-lifecycle |
| "dependency" | "feature dependencies", "dependency graph" | "add dependency to package" → feature-lifecycle |

### Explicit Exclusions (NEVER trigger this skill)

**These trigger feature-lifecycle instead:**
- "build", "implement", "create", "add", "fix", "change" + feature/capability
- "implement roadmap feature" → building a feature CALLED roadmap
- "add dependency" → adding a code dependency, not a feature dependency
- "planning to implement X" → intent to build, not roadmap planning

**These trigger research skill instead:**
- "research", "investigate", "explore", "study", "compare"
- "research best practices for X"
- "compare approaches for X"

---

## When This Skill Activates

**ACTIVATE for (roadmap management intent):**
- "Help me prioritize the roadmap"
- "What Kano category is feature X?"
- "Analyze dependencies in the backlog"
- "Add this idea to the backlog"
- "Show me the critical path"
- "What should we build next?"
- "Review the roadmap"
- "Let's do a prioritization session"
- "What's on the roadmap?"
- "Approve/reject this feature proposal"

**DO NOT ACTIVATE for (these go to other skills):**

| User Says | Correct Skill | Why |
|-----------|---------------|-----|
| "Build feature X" | feature-lifecycle | Building, not prioritizing |
| "Implement rate limiting" | feature-lifecycle | Building, not prioritizing |
| "Research best practices" | research | Investigating, not prioritizing |
| "Add a roadmap page to the UI" | feature-lifecycle | Building a feature called "roadmap" |
| "Fix the backlog service" | feature-lifecycle | Fixing code, not managing backlog |
| "Plan the implementation" | feature-lifecycle | Implementation planning, not roadmap planning |
| "Analyze performance issues" | feature-lifecycle/research | Technical analysis, not priority analysis |

---

## What This Skill Does

### 1. Backlog Item Capture

When user provides a feature idea, help capture it properly:

```
User: "I have an idea for a notification system"

Response:
1. Ask clarifying questions if needed
2. Suggest category and effort estimate
3. Identify obvious dependencies
4. Create entry in BACKLOG.md
5. Optionally create proposals/{name}.md for complex ideas
```

### 2. Kano Classification Assistance

Help suggest Kano classification based on evidence:

```
User: "What Kano category is rate limiting?"

Process:
1. Check for market evidence (features/*/MARKET_EVIDENCE.md)
2. Look for user complaints/requests
3. Consider competitive landscape
4. Suggest classification with reasoning:

"Based on evidence:
- Community complaints about missing rate limiting (5 sources)
- All competitors have this feature
- Users explicitly expect this

Suggested: MUST-BE
Rationale: Absence would cause dissatisfaction. This is table stakes."
```

**Kano Decision Guide:**

| Signal | Likely Category |
|--------|-----------------|
| Users complain when missing | Must-Be |
| Users compare to competitors | Performance |
| Users don't mention but would love | Delighter |
| Users don't care either way | Indifferent |

### 3. Dependency Analysis

Analyze and visualize dependencies:

```
User: "Analyze dependencies for the backlog"

Process:
1. Read BACKLOG.md and ROADMAP.md
2. Identify explicit dependencies
3. Infer implicit dependencies (shared code, data, concepts)
4. Generate dependency graph
5. Identify critical path
6. Flag circular dependencies or orphans

Output:
- Text-based dependency graph
- Critical path highlighted
- Blocked items identified
- Recommendations for parallelization
```

**Dependency Types:**

| Type | Notation | Meaning |
|------|----------|---------|
| Hard | `A → B` | A MUST complete before B starts |
| Soft | `A ~> B` | A makes B easier but not required |
| Related | `A <> B` | Consider together, shared concerns |

### 4. Priority Analysis

Help analyze priorities without making decisions:

```
User: "Help me prioritize the roadmap"

Process:
1. Read current ROADMAP.md
2. For each item, gather:
   - Kano classification
   - Estimated effort
   - Dependencies
   - Evidence strength
3. Calculate suggested priority score
4. Present analysis for human decision

Output:
- Priority matrix by Kano category
- Value/Effort analysis
- Dependency-aware ordering
- Recommendations (not decisions)
```

**Priority Framework:**

```
Score = (Kano Weight × Value) - (Effort × Risk) + Dependency Bonus

Kano Weights:
- Must-Be: 3 (highest urgency)
- Performance: 2
- Delighter: 1
- Indifferent: 0 (should reconsider)

Dependency Bonus: +2 if enables multiple high-value items
```

### 5. Roadmap Status Report

Generate status overview:

```
User: "Show roadmap status"

Output:
- Summary counts by status
- In-progress items with blockers
- Upcoming items by priority
- Completed items this period
- Critical path visualization
- Recommendations
```

---

## Analysis Templates

### Kano Analysis Template

```markdown
## Kano Analysis: {Feature Name}

### Evidence Reviewed
- [ ] MARKET_EVIDENCE.md (if exists)
- [ ] User requests/complaints
- [ ] Competitor analysis
- [ ] Internal observations

### Classification Signals

| Signal | Present? | Evidence |
|--------|----------|----------|
| User complaints when missing | Yes/No | {evidence} |
| Competitor comparison point | Yes/No | {evidence} |
| Unexpected delight potential | Yes/No | {evidence} |
| User indifference | Yes/No | {evidence} |

### Suggested Classification: {Category}

**Confidence:** High/Medium/Low

**Rationale:**
{Why this classification based on evidence}

### Your Decision
> This is a suggestion. You make the final classification.
```

### Dependency Analysis Template

```markdown
## Dependency Analysis

### Dependency Graph

```
{text-based graph}
```

### Critical Path

```
{longest chain of dependencies}
```

**Critical Path Duration:** {estimated time}

### Blocked Items

| Item | Blocked By | Blocker Status | ETA |
|------|------------|----------------|-----|
| {item} | {blocker} | {status} | {eta} |

### Parallelization Opportunities

| Items | Can Run In Parallel | Notes |
|-------|---------------------|-------|
| {items} | Yes/No | {notes} |

### Issues Found

- [ ] Circular dependencies: {list or "None"}
- [ ] Missing dependencies: {list or "None"}
- [ ] Orphan items (no dependencies, not depended on): {list}

### Recommendations

1. {recommendation}
2. {recommendation}
```

### Priority Analysis Template

```markdown
## Priority Analysis

### Current State

| Kano Category | Count | Items |
|---------------|-------|-------|
| Must-Be | {n} | {list} |
| Performance | {n} | {list} |
| Delighter | {n} | {list} |
| Unclassified | {n} | {list} |

### Suggested Priority Order

> Based on Kano + Dependencies + Value/Effort

| Rank | Item | Kano | Value | Effort | Score | Notes |
|------|------|------|-------|--------|-------|-------|
| 1 | {item} | Must-Be | 5 | M | {score} | {notes} |
| 2 | {item} | Must-Be | 4 | L | {score} | {notes} |
| ... | ... | ... | ... | ... | ... | ... |

### Recommendations

**Immediate (This Sprint/Week):**
- {item}: {rationale}

**Next (This Month/Quarter):**
- {item}: {rationale}

**Later (Next Quarter+):**
- {item}: {rationale}

### Items to Reconsider

| Item | Issue | Recommendation |
|------|-------|----------------|
| {item} | Indifferent Kano | Consider removing |
| {item} | High effort, low value | Descope or defer |

### Your Decision
> These are suggestions. You set the final priorities.
```

---

## Guidance Principles

### What This Skill Does

1. **Analyzes** - Reads backlog/roadmap, identifies patterns
2. **Suggests** - Proposes classifications, priorities, orderings
3. **Visualizes** - Creates graphs, matrices, reports
4. **Questions** - Asks clarifying questions to improve analysis
5. **Educates** - Explains Kano, dependencies, prioritization concepts

### What This Skill Does NOT Do

1. **Decide** - Approval/rejection is your call
2. **Prioritize** - Final ordering is your call
3. **Commit** - Adding to roadmap requires your approval
4. **Override** - Never changes your decisions without asking

### Interaction Pattern

```
User: "Add rate limiting to the backlog"

Claude:
1. "I'll help add rate limiting to the backlog. A few questions first:
   - What's the source of this idea? (Research, user request, internal)
   - Any known dependencies?
   - Initial effort estimate?"

2. [After answers]
   "Here's the proposed entry:
   | R-001 | Rate Limiting | User request | TBD | Auth system | PROPOSED |

   Shall I add this to BACKLOG.md?"

3. [After confirmation]
   "Added to BACKLOG.md. Would you like me to:
   - Create a detailed proposal?
   - Suggest a Kano classification?
   - Analyze dependencies?"
```

---

## Reference Files

| File | Path | Purpose |
|------|------|---------|
| Process Doc | `.sulis/planning/roadmap/README.md` | Full workflow documentation |
| Backlog | `.sulis/planning/roadmap/BACKLOG.md` | All ideas and proposals |
| Roadmap | `.sulis/planning/roadmap/ROADMAP.md` | Approved, prioritized items |
| Proposals | `.sulis/planning/roadmap/proposals/` | Detailed proposal files |
| Proposal Template | `methodology/templates/journey/ROADMAP_PROPOSAL_TEMPLATE.md` | Template for proposals |

---

## Integration with Other Skills

### From Research Skill

When market research produces feature recommendations:

```
MARKET_EVIDENCE.md
└── Feature Recommendations
    ├── Enhancement: Include in current feature scope
    └── New Feature: → Add to BACKLOG.md
```

### To Feature Lifecycle

When roadmap item is ready to build:

```
ROADMAP.md (status: IN_PROGRESS)
    └── Create features/{name}/
        └── Begin feature-lifecycle (design phase)
```

---

## Common Workflows

### Adding Ideas from Research

```
1. Research produces MARKET_EVIDENCE.md
2. Review Feature Recommendations section
3. For each new feature idea:
   a. Add to BACKLOG.md as PROPOSED
   b. Link back to MARKET_EVIDENCE.md
   c. Note "Source: Research - {feature-name}"
```

### Prioritization Session

```
1. User: "Let's prioritize the roadmap"
2. Claude: Read BACKLOG.md and ROADMAP.md
3. Claude: Generate priority analysis
4. User: Reviews and makes decisions
5. Claude: Updates files based on user decisions
```

### Dependency Planning

```
1. User: "What's blocking what?"
2. Claude: Analyze all items for dependencies
3. Claude: Generate dependency graph
4. Claude: Identify critical path
5. User: Adjusts priorities based on analysis
```

---

## Example Session

```
User: I want to add a webhooks feature to the roadmap

Claude: I'll help you add webhooks to the backlog. Let me gather some information:

1. **Source:** Is this from research, a user request, or internal observation?
2. **Problem:** What problem does webhooks solve for users?
3. **Dependencies:** Does this depend on any existing or planned features?
4. **Effort:** Initial estimate - XS/S/M/L/XL?

User: It's from the notifications research. Users want real-time updates.
      Depends on the events system. Probably M effort.

Claude: Great. Here's the proposed backlog entry:

| ID | Name | Source | Category | Effort | Dependencies | Status |
|----|------|--------|----------|--------|--------------|--------|
| R-015 | Webhooks | [Research](features/notifications/MARKET_EVIDENCE.md) | New Feature | M | Events System | PROPOSED |

Shall I:
1. Add this to BACKLOG.md?
2. Create a detailed proposal in proposals/webhooks.md?
3. Both?

User: Both please

Claude: Done. I've created:
- Entry in BACKLOG.md (R-015)
- Detailed proposal at proposals/webhooks.md

Would you like me to suggest a Kano classification based on the research evidence?

User: Yes

Claude: Based on the MARKET_EVIDENCE.md for notifications:

**Kano Analysis: Webhooks**

| Signal | Present? | Evidence |
|--------|----------|----------|
| User complaints when missing | Yes | "Why can't I get notified when X happens?" (3 sources) |
| Competitor comparison | Yes | Stripe, GitHub all have webhooks |
| Delight potential | No | This is expected, not surprising |

**Suggested Classification: Performance**

Rationale: Users will compare this to competitors. More webhook event types = more value.
Not Must-Be because polling exists as a workaround, but clearly a competitive differentiator.

Would you like me to update the backlog entry with this classification?
```

---

## Kano Reference

### The Kano Model

```
                    Satisfaction
                         ↑
                         │    ╱ Delighter
                         │   ╱  (unexpected joy)
                         │  ╱
    ─────────────────────┼─────────────────→ Implementation
                        ╱│
                       ╱ │
    Performance ──────╱  │
    (more is better)     │
                         │
                        ╱
    Must-Be ───────────╱
    (expected, absence hurts)
```

### Classification Questions

| Category | Functional Question | Dysfunctional Question |
|----------|--------------------|-----------------------|
| Must-Be | "If we have this, how do you feel?" → Neutral | "If we don't have this, how do you feel?" → Very bad |
| Performance | "If we have this, how do you feel?" → Good | "If we don't have this, how do you feel?" → Bad |
| Delighter | "If we have this, how do you feel?" → Very good | "If we don't have this, how do you feel?" → Neutral |

### Simplified Heuristic

| If users say... | It's probably... |
|-----------------|------------------|
| "Of course it should have X" | Must-Be |
| "I wish it had more X" | Performance |
| "Wow, I didn't expect X!" | Delighter |
| "I don't really care about X" | Indifferent |

---

## Cross-References

- **Command:** `commands/sulis-roadmap.md`
- **Journey Skill:** `skills/journey/SKILL.md`
- **Feature Lifecycle:** `skills/design/SKILL.md`
- **Research:** `skills/research/SKILL.md`
- **Journey Registry:** `product/offerings/primary/journeys/index.md`
- **Feature Registry:** `features/index.md`
- **OFM:** `methodology/architecture/GENERATIVE_FEATURE_FRAMEWORK.md`