# Primitive Scaffolds

Per-primitive Red-Green-Blue scaffolds. The executor branches on the
WP's `primitive` field (one of 22 from `change-primitives.md`) to
apply the right shape.

**v0.1 covers the EXPAND group (5 primitives).**

v0.5 will add REORGANISE (6 primitives, characterisation-test-first),
SUBSTITUTE (3 primitives), CONTRACT (2 primitives), and REINFORCE
beyond Test (5 additional primitives).

When the executor encounters a WP with a primitive outside the v0.1
scope, it halts and writes a BLOCKER record noting "primitive
coverage not yet implemented; wait for sulis-execution v0.5 or hand-
implement."

---

## EXPAND group (v0.1)

The EXPAND group adds new behaviour to the system. Listed cheapest →
most invasive (CP-01 priority 0 favours the cheapest applicable).

### 1. Reuse

**Definition.** The new behaviour comes entirely from calling an
existing primitive at a new site. No new logic is introduced.

**Red.**

```
# Test that the existing primitive is now consumed at the new site.
# The test asserts the behaviour at the new site, not the primitive's
# internal behaviour (that has its own tests).
def test_<new_site>_calls_<existing_primitive>():
    # Arrange the new site's input
    # Act: invoke the new site
    # Assert: the outcome that the existing primitive produces
```

**Green.**

```python
# At the new call site:
from <module> import <existing_primitive>

def <new_site>(...):
    return <existing_primitive>(...)
```

The Green step adds the import + the call. Nothing else.

**Blue.** Look for duplicated wrappers — if multiple call sites wrap
the same primitive in similar boilerplate, extract the wrapper.

**Anti-pattern.** Re-implementing the primitive at the new site
instead of calling the existing one. CP-01 priority 0 (internal
prior art) is non-negotiable; if the existing primitive doesn't quite
fit, the right move is `Extend` (next primitive), not re-implementation.

---

### 2. Compose

**Definition.** The new behaviour comes from wiring existing pieces
together. No new logic; the composition is the contribution.

**Red.**

```
# Integration test of the composition's contract.
def test_<composition>_produces_<expected_outcome>():
    # Arrange: the inputs the composition takes
    # Act: invoke the composition
    # Assert: the end-to-end outcome
```

**Green.**

```python
def <composition>(input):
    a = <existing_primitive_1>(input)
    b = <existing_primitive_2>(a)
    return <existing_primitive_3>(b)
```

The Green step wires the pieces. Each piece's internal behaviour is
already tested; the composition's tests cover the wiring.

**Blue.** If the composition appears ≥ 2 times across the codebase,
extract it as a named primitive. (If only at this one site, leave it
inline.)

**Anti-pattern.** Reaching into a primitive's internals to "tweak"
it during composition. If the primitive doesn't quite fit, use
`Extend` (which modifies the primitive itself in a controlled way),
not a tweak that bypasses the primitive's contract.

---

### 3. Extend

**Definition.** The new behaviour adds a branch / parameter / overload
to an existing primitive without disrupting its existing callers.

**Red.**

```
# Test the new branch/parameter/overload specifically.
def test_<existing_primitive>_with_<new_param>():
    # Arrange: input that exercises the new branch
    # Act: invoke with the new param
    # Assert: the new branch's behaviour

# Plus: existing tests for <existing_primitive> still pass
# unchanged (regression check).
```

**Green.** Add the minimum change to the primitive:

- **New optional parameter** with a default that preserves existing
  behaviour. Old callers don't notice.
- **New branch** keyed off a flag or input shape, with the existing
  behaviour as the default path.
- **New overload** when the language supports it (TypeScript
  overloads, Python `@overload` decorator, Go variadic).

**Blue.** Refactor to keep the extension narrow. If the primitive
is now branchy enough that comprehension is suffering, the next
primitive to consider is `Refactor` (REORGANISE group — extract the
branches into named helpers).

**Anti-pattern.** Extending in a way that breaks existing callers.
The contract is: existing callers don't notice. If you have to
update other call sites for compilation to succeed, the extension
is wrong — either find a backward-compatible shape or escalate
(this is now a SUBSTITUTE pattern: `Strangle` or `Replace`,
v0.5).

---

### 4. Generate

**Definition.** The new behaviour is produced by a templating or
codegen rule applied to a source definition (schema, IDL, OpenAPI,
GraphQL SDL, protobuf, etc.).

**Red.**

```
# Test the generator's output shape, not its internals.
def test_<generator>_produces_<expected_artifact>():
    # Arrange: the source definition
    # Act: run the generator
    # Assert: the generated artifact has the expected shape
```

Plus integration tests: the generated artifact is consumed
correctly by the rest of the system.

**Green.**

```bash
# Add the generator rule (Makefile, package.json script, etc).
generate:
    <generator-binary> --input schema.proto --output generated/
```

Run the generator; commit the generated artifacts AND the rule.

**Blue.** Look for duplicated generator templates — if multiple
generation rules use near-identical templates, consolidate.

**Anti-pattern.** Hand-editing generated artifacts. If the generator
doesn't produce what's needed, fix the generator (or extend the
source definition); don't hand-edit downstream.

---

### 5. Create

**Definition.** The new behaviour is genuinely new code — no
existing primitive applies (Reuse), no composition of existing
primitives fits (Compose), no extension preserves contracts
(Extend), and no generator pattern applies (Generate).

**Internal-prior-art check is mandatory before Create** (EP-03 +
CP-01 priority 0). If a search of the codebase (and of
`.architecture/{project}/probe-raw/1_2_capabilities.json` if it
exists) surfaces a near-match, the WP's primitive is wrong — halt
and escalate; the WP should be re-classified as one of the cheaper
primitives.

**Red.**

```
# Failing test for the genuinely-new behaviour.
def test_<new_behaviour>():
    # Arrange: input
    # Act: invoke the new code
    # Assert: outcome per WP Contract
```

Plus edge cases and hardening assertions per RGB-01.

**Green.** Write the minimum implementation. Boring per CP-01..05:

- Explicit types.
- Explicit error handling (no bare `except`, no swallowed errors).
- No metaprogramming, no clever shortcuts.
- Convention-defaulted protocol / format / library choices.

**Blue.** Refactor to boring shape. Common Blue cleanups for Create:

- Extract magic numbers / strings to named constants.
- Split functions ≥ 30 lines into named smaller functions.
- Replace nested conditionals with early returns or guard clauses.
- Add docstrings / doc comments per language convention.

**Anti-pattern.** Creating from scratch what already exists. The
internal-prior-art check is the gate; if it surfaces a match, the
WP's classification is wrong.

---

## Primitive selection check at step 3 (GREEN)

Before writing any Green-step code, the executor verifies the WP's
declared `primitive` field is consistent with the codebase state:

1. **Reuse / Compose / Extend / Generate** declared but no existing
   primitive matches → halt + escalate. The WP's classification is
   wrong; SEA should re-decompose.
2. **Create** declared but a near-match exists in the codebase →
   halt + escalate. The WP should be re-classified to Reuse,
   Compose, or Extend.
3. **Primitive declared in the v0.5 scope** (REORGANISE / SUBSTITUTE /
   CONTRACT / REINFORCE beyond Test) → halt + escalate. v0.5 not
   yet shipped; WP needs to wait or hand-implementation.

In all three cases the BLOCKER record's "Suggested next step" names
the specific re-classification or wait condition.

---

## Future primitive coverage (v0.5)

### REORGANISE (6 primitives, characterisation-test-first)

All REORGANISE primitives (Move, Refactor, Inline, Merge, Decompose,
Abstract) require a **characterisation test** before the refactor —
captures current behaviour as the spec the refactor must preserve.
The executor reads the WP's `characterisation_test` field, runs the
characterisation test, refactors, re-runs the characterisation test,
confirms no drift.

### SUBSTITUTE (3 primitives)

- **Replace** — swap one implementation for another with the same
  contract. New impl passes the same tests as the old.
- **Strangle** — gradual replacement (the Fowler Strangler-Fig
  pattern). New impl ramps up behind a flag; old impl deprecated;
  removal plan in WP frontmatter.
- **Wrap** — adapter pattern around something out of the system's
  control (external SDK, legacy system). Subject ownership and
  removal plan required per change-primitives.md.

### CONTRACT (2 primitives)

- **Deprecate** — add deprecation warning + migration guide; do not
  remove yet.
- **Delete** — remove the deprecated primitive. Always
  Deprecate → Delete in sequence; never Delete without prior
  Deprecate.

### REINFORCE (5 primitives beyond Test)

- **Instrument** — add observability (logs, traces, metrics) per
  OpenTelemetry conventions.
- **Secure** — apply security control per the security-standard.
- **Harden** — wrap calls in resilience policies (timeouts, retries,
  circuit breakers).
- **Gate** — add a feature flag / kill switch.
- **Document** — write or update docs (README, ADR, runbook).
