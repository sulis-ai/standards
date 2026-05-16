# Founder English

<!-- summary -->
Plain-language translation patterns for the Concierge. Defers heavily to
the canonical AAF-03 lexicon at
`plugins/srd/references/audience-adapted-framing-standard.md` — this file
adds **concierge-specific patterns** for translating between marketplace
internal vocabulary (artifact names, phase IDs, primitive names) and
founder English. Always composes with AAF-03; never re-defines an entry
that AAF-03 already covers.
<!-- /summary -->

---

## Marketplace Artifact Translation

When summarising what a specialist produced, translate the artifact name
into what it *is* for the founder. Never use the canonical filename in
founder-facing text without an inline translation.

| Marketplace artifact | Founder-facing description |
|---|---|
| `SRD.md` | "the requirements document" |
| `NFR.md` | "the quality requirements (how fast / how secure / how reliable)" |
| `MISUSE_CASES.md` | "abuse scenarios and how the system defends against them" |
| `PRIMITIVE_TREE.jsonld` | "the building-block map" |
| `GLOSSARY.md` | "the dictionary of project-specific terms" |
| `COMPLETENESS_REPORT.md` | "the quality check report" |
| `RECONCILIATION_MAP.md` | "the requirements-vs-code reconciliation table" |
| `EXPLORATION_JOURNAL.md` | "the conversation history with reasoning notes" |
| `TDD.md` | "the technical blueprint" |
| `ADR-NNN.md` | "a recorded technical decision" |
| `WP-NNN.md` | "a single task in the to-do list" |
| `INDEX.md` (work-packages) | "the ordered to-do list" |
| `SIZING.md` | "the project size estimate" |
| `HANDOFF_TO_SEA.md` | "the handover note for the architect" |
| `.context/{project}/INDEX.md` | "the inventory of what already exists" |
| `.security/{project}/viability-report-*.md` | "the security review" |
| `.concierge/{project}/JOURNEY.md` | "your project's journey state (where you are, what's been decided)" |

---

## Phase-Number Translation

Don't refer to phases by number. Translate to the activity.

| Internal phase | Founder-facing label |
|---|---|
| Phase 1 (Greet) | "getting set up" |
| Phase 2 (Discover) | "checking what already exists" |
| Phase 3 (Specify) | "writing down what we're building" |
| Phase 4 (Design) | "designing how it'll work" |
| Phase 5 (Implement) | "building it" |
| Phase 6 (Verify) | "checking the build" |
| Phase 7 (Secure) | "security review" |

Likewise for Phase 1-6 inside the SRD analyst's facilitation (which the
founder sees as one continuous conversation — they don't need to know
about its internal phases).

---

## Primitive-Name Translation (per `plugins/sea/references/change-primitives.md`)

When a Work Package's primitive surfaces, translate. Internal names
should never appear in founder-facing text.

| Primitive (internal) | Group | Founder-facing description |
|---|---|---|
| Reuse | EXPAND | "use something we already have" |
| Compose | EXPAND | "combine existing pieces" |
| Extend | EXPAND | "add to something that exists" |
| Create | EXPAND | "build something new" |
| Refactor | REORGANISE | "rearrange existing code for clarity" |
| Move | REORGANISE | "move code to where it belongs" |
| Decompose | REORGANISE | "split a big piece into smaller ones" |
| Substitute (Replace) | SUBSTITUTE | "replace one thing with another" |
| Strangle | SUBSTITUTE | "gradually replace an old approach with a new one" |
| Wrap | SUBSTITUTE | "put a friendlier layer around something external" |
| Contract | CONTRACT | "remove something we don't need" |
| Retire | CONTRACT | "delete an obsolete piece" |
| Reinforce-Resilience | REINFORCE | "make it survive failures better" |
| Reinforce-Observability | REINFORCE | "make it easier to see what's happening" |
| Reinforce-Security | REINFORCE | "tighten the security" |
| ...etc. | | |

Default: when a primitive appears whose translation isn't above, fall
back to one of the five group descriptions (EXPAND → "adding
something"; REORGANISE → "rearranging existing code"; SUBSTITUTE →
"swapping one approach for another"; CONTRACT → "removing something";
REINFORCE → "making something more robust").

---

## Severity-Name Translation (for security findings)

The security reviewer uses CRITICAL / CONCERN / ADVISORY / PASS /
NOT-ASSESSED / HYPOTHESIS. Translate by business risk.

| Internal severity | Founder-facing language |
|---|---|
| CRITICAL | "must fix before you ship — [plain-language impact]" |
| CONCERN | "medium-priority issue — [plain-language impact]; not blocking but plan to fix" |
| ADVISORY | "minor note for when you have time" |
| PASS | (don't surface individually; aggregate as "all clear") |
| NOT-ASSESSED | "the security tool couldn't check this — would need a specialist look" |
| HYPOTHESIS | "the security tool thinks there might be an issue but isn't sure — worth investigating" |

---

## Specialist-Output Translation Patterns

When a specialist returns a summary, follow this translation discipline:

1. **Strip all IDs and acronyms.** UC-08, FR-11, NFR-S04, ADR-201,
   MUC-09 — never appear in founder-facing text.
2. **Translate counts to plain descriptions.** "13 WPs in slice 1" →
   "13 tasks in the first batch".
3. **Translate states.** `status: pending` → "not started yet";
   `status: in_progress` → "being built now"; `status: done` →
   "finished and tested"; `status: blocked` → "stuck on something".
4. **Drop methodology jargon.** "OODA spiral", "Two-Model
   Reconciliation", "Convention Preference", "AAF triage" — these are
   how the marketplace works internally; the founder doesn't need to
   know.
5. **Convert numerical claims to scale words where appropriate.** "47
   files in 12 modules" → "your project is medium-sized — a couple of
   dozen files across a handful of components".

---

## When to Use Show-Don't-Tell (AAF-02)

For UX trade-offs surfaced by specialists, replace abstract options with
concrete scenario walkthroughs. Pattern:

> *"Here's what your first user sees in their first 60 seconds if I do A:
> 1. [step 1 from user POV]
> 2. [step 2 from user POV]
> 3. [step 3 from user POV]
>
> Here's option B:
> 1. ...
>
> A matches [stated principle / dominant industry pattern].
> B matches [different stated principle / different pattern].
> Which feels right for [target user / first founder]?"*

The user reacts to lived experience, not architectural options. You
then translate the answer back into the technical decision and pass it
to the specialist.

---

## Anti-Patterns

### "I read the SRD and it says..."

The founder doesn't know what the SRD is. Don't reference it by name.
Instead: *"From the requirements document, I see you said X, Y, Z. Does
that still match what you want?"*

### "The TDD recommends ADR-007 with primitive Extend..."

Pure marketplace internal vocabulary. Translate: *"The architect's
blueprint says to add to the existing user-management module rather than
build a separate one. They wrote down why (recorded for engineers)."*

### "Want me to recommend the next command?"

AAF-08 violation (permission-theater). Decided actions don't get
permission gates. Just announce: *"Run `/sea:blueprint` next."*

### "Phase 4 is the design phase, would you like to start Phase 4?"

Internal phase numbering exposed AND permission-theater. Translate:
*"Now we design how it'll work. Run `/sea:blueprint`."*

---

## Version History

| Version | Date | Change | Author |
|---|---|---|---|
| 0.1.0 | 2026-05-16 | Initial founder-english translation guide. Defers to AAF-03 lexicon; adds concierge-specific patterns for marketplace artifacts, phase numbers, primitive names, severity labels. | Standards team |
