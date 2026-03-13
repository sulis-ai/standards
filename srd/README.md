# SRD: Requirements Analyst Plugin for Claude Code

A Claude Code plugin that facilitates building Software Requirements Documents through
guided conversation. It acts as a requirements analyst — asking questions, tracking
coverage, and producing structured specifications with UML artifacts in Mermaid.

---

## What It Does

SRD guides you through a structured requirements gathering process. Instead of staring at
a blank document, you have a conversation with an analyst agent that:

- Asks targeted questions across six exploration domains
- Tracks which areas have been covered and which need more detail
- Maps your existing codebase to ground questions in what's already built
- Produces a complete Software Requirements Document with diagrams
- Verifies the specification is complete enough for a development team to implement

All UML artifacts (process flows, sequence diagrams, state diagrams, use case diagrams)
are produced in Mermaid syntax for easy rendering in any Markdown viewer.

---

## Who It's For

- **People learning product management or systems analysis** who want a structured process
  to follow and a skilled collaborator to practice with.
- **People with ideas who need structured specifications** — founders, product owners,
  developers who know what they want to build but need to capture it formally before
  starting development.

---

## Installation

**Local (development):**
```bash
claude --plugin-dir ./srd
```

---

## Usage

### Starting a facilitation session

Activate the requirements analyst agent to begin a facilitation session:

```
/agents → select requirements-analyst
```

Or start Claude Code with the agent active:

```bash
claude --plugin-dir ./srd --agent requirements-analyst
```

The agent begins Phase 1 (Orientation) immediately — understanding what you want to
specify, launching a background codebase mapping if applicable, and asking its first
question.

### Standalone skills

These skills can be used independently or are triggered by the agent during facilitation:

**`/srd:codebase-mapping`** — Map an existing codebase. Produces `CODEBASE_INDEX.json`
with technology stack, services, integrations, and data models. Triggered automatically
by the agent at session start, or run independently to generate or refresh the index.

**`/srd:requirements-validation`** — Run completeness verification on a specification
folder. Checks traceability, integration completeness, NFR coverage, and content quality.
Produces `COMPLETENESS_REPORT.md` with a PASS or GAPS_FOUND verdict.

---

## What It Produces

Each facilitation session creates a specification folder at `.specifications/{project-name}/`
containing:

```
.specifications/{project-name}/
  SRD.md                      # The Software Requirements Document
  EXPLORATION_JOURNAL.md      # Coverage tracking and session notes
  CODEBASE_INDEX.json         # Existing codebase map (if applicable)
  diagrams/
    use-cases.md              # Actor-capability diagrams
    process-flows.md          # Workflow diagrams in Mermaid
    sequence-diagrams.md      # Integration interaction diagrams
    state-diagrams.md         # Entity lifecycle diagrams
    data-flows.md             # Data movement diagrams
  NFR.md                      # Non-functional requirements
  GLOSSARY.md                 # Domain glossary
  COMPLETENESS_REPORT.md      # Verification results
  HANDOVER.md                 # Execution agent handover brief
```

---

## The Facilitation Process

The agent follows a six-phase process:

1. **Orientation** — Understand the high-level idea. What problem are you solving? Who is
   it for? Set up the specification folder.

2. **Divergent Exploration** — Systematically explore six domains: Actors & Stakeholders,
   Capabilities & Use Cases, Business Rules & Logic, Integrations & Data, Process & Workflow,
   and Constraints & NFRs. The agent asks one question at a time, follows threads, and
   checks understanding every 3-4 exchanges.

3. **Convergent Synthesis** — Consolidate findings. Resolve contradictions. Confirm the
   complete picture with you before writing anything.

4. **Artifact Generation** — Produce the SRD and all supporting diagrams from the gathered
   requirements. All generated content follows the Content Quality Standard.

5. **Verification** — Run the completeness assessment. Fix small gaps automatically.
   Surface remaining gaps for your review.

6. **Handover** — Deliver the complete specification folder, ready for a development team
   to use as their implementation guide.

---

## Standards

The agent follows four standards throughout the facilitation process:

- **Cognitive Load** — One question at a time. Plain language. Summarise before moving on.
  Never overwhelm with jargon or compound questions.

- **Coaching Without Conflict** — Guide without prescribing. Ask questions that help you
  think through decisions rather than making decisions for you. Surface trade-offs and
  let you choose.

- **Critical Thinking** — Challenge assumptions constructively. Ask "What would happen
  if that's not true?" Surface risks and edge cases. Distinguish between what is known,
  what is assumed, and what is unknown.

- **Content Quality** — All generated artifacts follow the summary + detail pattern, use
  varied sentence rhythm, plain language, and avoid AI-tell anti-patterns.

---

## License

MIT
