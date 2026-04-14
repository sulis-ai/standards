# ServiceSpec Compliance Rules

> **Purpose:** Define verification rules that map SERVICE_SPECIFICATION checklist items to code patterns.
> These rules are used by Production Guardian to scan code for compliance.

---

## Overview

The SERVICE_SPECIFICATION.md contains ~100+ checklist items in §22 (Approval Checklist).
This document defines **automated verification rules** for each category.

**Rule Categories:**
- `META-ENT-*` - Entity Display Metadata
- `META-FORM-*` - Form-Drivable Metadata
- `META-OP-*` - Operation Decorators
- `META-ERR-*` - Error Catalog
- `META-I18N-*` - Internationalization
- `META-DISC-*` - AI Discoverability
- `META-EVENT-*` - Domain Events
- `META-BILLING-*` - Consumption/Billing Events
- `META-CACHE-*` - Caching & Conditional Requests
- `META-BIND-*` - Bindings (Platform, SDK, External)

---

## Rule Format

Each rule specifies:
- **Rule ID**: Unique identifier (e.g., META-OP-01)
- **Checklist Item**: The SERVICE_SPECIFICATION requirement
- **Verification Method**: How to verify compliance
- **Code Pattern**: What to search for in code
- **Expected Source**: Where to find expected count/values
- **Blocking**: Whether failure blocks deployment (all are BLOCKING)

---

## Entity Display Metadata (META-ENT-*)

> **ServiceSpec Section:** §2
> **Purpose:** Verify entities have proper display metadata for UI rendering

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-ENT-01 | Entity display metadata defined | Scan Pydantic models for display config | `"display":` in json_schema_extra | ONTOLOGY.jsonld entities |
| META-ENT-02 | Icons use Heroicons format | Check icon strings match pattern | `heroicons:{size}/{style}/{name}` | SERVICE_SPECIFICATION §2 |
| META-ENT-03 | Primary field defined | Check display.primaryField exists | `"primaryField":` | Each entity in ONTOLOGY |
| META-ENT-04 | Badge fields defined | Check display.badges array | `"badges":` | Each entity in ONTOLOGY |
| META-ENT-05 | Lifecycle states documented | Check entity has state enum | `status: Literal[` or `class.*Status.*Enum` | SERVICE_SPECIFICATION §2.x |

### Verification Commands

```bash
# META-ENT-01: Count entities with display metadata
grep -r '"display":' src/services/{service}/domain/models/ | wc -l

# META-ENT-02: Verify Heroicons format
grep -r 'heroicons:' src/services/{service}/ | grep -E 'heroicons:(16|20|24)/(outline|solid)/[a-z-]+' | wc -l

# META-ENT-03: Check primaryField
grep -r '"primaryField":' src/services/{service}/domain/models/ | wc -l

# META-ENT-04: Check badges
grep -r '"badges":' src/services/{service}/domain/models/ | wc -l
```

### Python Verification

```python
def verify_meta_ent(service_path: Path, ontology: dict) -> list[RuleResult]:
    """Verify META-ENT-* rules."""
    results = []

    # META-ENT-01: Entity display metadata
    expected_entities = len(ontology.get("entities", {}))
    actual = count_pattern(service_path / "domain/models", '"display":')
    results.append(RuleResult(
        rule_id="META-ENT-01",
        expected=expected_entities,
        actual=actual,
        status="PASS" if actual >= expected_entities else "BLOCK"
    ))

    return results
```

---

## Form-Drivable Metadata (META-FORM-*)

> **ServiceSpec Section:** §2
> **Purpose:** Verify fields have metadata for form generation

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-FORM-01 | x-display on fields | Scan Field definitions | `"x-display":` | SERVICE_SPECIFICATION §2 |
| META-FORM-02 | x-enum-labels defined | Scan enum fields | `"x-enum-labels":` | Enum fields in ONTOLOGY |
| META-FORM-03 | x-enum-source for dynamic | Scan API-driven fields | `"x-enum-source":` | Dynamic fields in spec |
| META-FORM-04 | x-visibility conditions | Scan conditional fields | `"x-visibility":` | Conditional fields in spec |
| META-FORM-05 | x-field-groups defined | Scan complex forms | `"x-field-groups":` | Forms with grouping |
| META-FORM-06 | x-validation-messages | Scan required fields | `"x-validation-messages":` | Required fields |
| META-FORM-07 | Field order defined | Check order property | `"order":` | All form fields |
| META-FORM-08 | Input types specified | Check inputType property | `"inputType":` | All editable fields |

### Verification Commands

```bash
# META-FORM-01: Count x-display metadata
grep -r '"x-display":' src/services/{service}/domain/models/ | wc -l

# META-FORM-02: Count x-enum-labels
grep -r '"x-enum-labels":' src/services/{service}/ | wc -l

# META-FORM-03: Count x-enum-source
grep -r '"x-enum-source":' src/services/{service}/ | wc -l

# META-FORM-04: Count x-visibility
grep -r '"x-visibility":' src/services/{service}/ | wc -l
```

---

## Operation Decorators (META-OP-*)

> **ServiceSpec Section:** §3
> **Purpose:** Verify handler methods have @operation decorators with complete metadata

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-OP-01 | @operation decorator present | Grep handler files | `@operation(` | ONTOLOGY.jsonld operations |
| META-OP-02 | name parameter | Check decorator params | `name="` | Each operation |
| META-OP-03 | description parameter | Check decorator params | `description="` | Each operation |
| META-OP-04 | permissions list | Check decorator params | `permissions=[` | Each operation |
| META-OP-05 | errors list | Check decorator params | `errors=[` | Each operation |
| META-OP-06 | user_guide present | Check decorator params | `user_guide=UserGuide(` | Each operation |
| META-OP-07 | user_guide.summary | Check UserGuide fields | `summary="` | Each operation |
| META-OP-08 | user_guide.when_to_use | Check UserGuide fields | `when_to_use="` | Each operation |
| META-OP-09 | leads_to navigation | Check decorator params | `leads_to=[` | State-changing operations |
| META-OP-10 | causes_transition | Check decorator params | `causes_transition=` | State-changing operations |
| META-OP-11 | async_operation flag | Check decorator params | `async_operation=True` | Async operations |
| META-OP-12 | idempotent flag | Check decorator params | `idempotent=True` | Idempotent operations |

### Verification Commands

```bash
# META-OP-01: Count @operation decorators
grep -r "@operation(" src/services/{service}/service_layer/handlers/ | wc -l

# META-OP-06: Count user_guide in decorators
grep -r "user_guide=UserGuide(" src/services/{service}/service_layer/handlers/ | wc -l

# META-OP-09: Count leads_to
grep -r "leads_to=\[" src/services/{service}/service_layer/handlers/ | wc -l
```

### Python Verification

```python
def verify_meta_op(service_path: Path, ontology: dict) -> list[RuleResult]:
    """Verify META-OP-* rules."""
    from src.core.service.decorators import get_registered_operations

    # Import handlers to trigger registration
    import_handlers(service_path)

    ops = get_registered_operations()
    service_ops = {k: v for k, v in ops.items() if service_name in k}

    results = []
    expected_count = len(ontology.get("operations", {}))

    # META-OP-01: Decorator count
    results.append(RuleResult(
        rule_id="META-OP-01",
        expected=expected_count,
        actual=len(service_ops),
        status="PASS" if len(service_ops) >= expected_count else "BLOCK"
    ))

    # META-OP-06: user_guide presence
    with_guide = sum(1 for op in service_ops.values() if op.user_guide)
    results.append(RuleResult(
        rule_id="META-OP-06",
        expected=expected_count,
        actual=with_guide,
        status="PASS" if with_guide >= expected_count else "BLOCK"
    ))

    return results
```

---

## Error Catalog (META-ERR-*)

> **ServiceSpec Section:** §10
> **Purpose:** Verify error definitions have actionable remediation guidance

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-ERR-01 | user_action defined | Scan error definitions | `user_action=` or `"user_action":` | ONTOLOGY.jsonld errors |
| META-ERR-02 | developer_action defined | Scan error definitions | `developer_action=` | ONTOLOGY.jsonld errors |
| META-ERR-03 | retryable flag | Scan error definitions | `retryable=` | ONTOLOGY.jsonld errors |
| META-ERR-04 | http_status defined | Scan error definitions | `http_status=` | ONTOLOGY.jsonld errors |
| META-ERR-05 | cause documented | Scan error definitions | `cause=` | ONTOLOGY.jsonld errors |

### Verification Commands

```bash
# META-ERR-01: Count errors with user_action
grep -r "user_action=" src/services/{service}/domain/errors.py | wc -l

# META-ERR-03: Count errors with retryable
grep -r "retryable=" src/services/{service}/domain/errors.py | wc -l
```

### Python Verification

```python
def verify_meta_err(service_path: Path, ontology: dict) -> list[RuleResult]:
    """Verify META-ERR-* rules."""
    results = []

    expected_errors = len(ontology.get("errors", {}))
    error_file = service_path / "domain/errors.py"

    if not error_file.exists():
        return [RuleResult("META-ERR-01", expected_errors, 0, "BLOCK")]

    content = error_file.read_text()

    # META-ERR-01: user_action count
    user_action_count = content.count("user_action=")
    results.append(RuleResult(
        rule_id="META-ERR-01",
        expected=expected_errors,
        actual=user_action_count,
        status="PASS" if user_action_count >= expected_errors else "BLOCK"
    ))

    return results
```

---

## Operation/Action/Permission Triad (META-TRIAD-*)

> **Architecture Reference:** `methodology standards/ACTION_HANDLER_PATTERN.md`
> **Purpose:** Verify consistency between @operation decorators, Action classes, and permissions
>
> The triad ensures:
> 1. Every operation has a corresponding Action class
> 2. Every Action class declares its `action_type` and `permission`
> 3. Permission in @operation matches Action class permission
> 4. ActionRegistry can look up actions by `action_type`

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-TRIAD-01 | Action class has action_type | Scan action files | `action_type: str = ` | All Action classes |
| META-TRIAD-02 | action_type format valid | Check format | `{domain}.{operation}` pattern | e.g., "platform.create" |
| META-TRIAD-03 | Action class has permission | Scan action files | `permission: str = ` or `required_permission` | All Action classes |
| META-TRIAD-04 | @operation references action_type | Check decorator | `action_type=` in decorator | ONTOLOGY operations |
| META-TRIAD-05 | Permission consistency | Compare values | @operation.permissions[0] == Action.permission | All operations |
| META-TRIAD-06 | Handler method uses Action | Check signature | `action: {ActionClass}` | Handler methods |
| META-TRIAD-07 | ONTOLOGY has action_type | Check ONTOLOGY | `"action_type":` in operations | ONTOLOGY.jsonld |

### Triad Alignment Diagram

```
┌────────────────────────────────────────────────────────────────────────────┐
│                    REQUIRED ALIGNMENT                                       │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  @operation decorator          Action class              ONTOLOGY.jsonld    │
│  ┌─────────────────────┐      ┌─────────────────────┐   ┌───────────────┐  │
│  │ action_type=        │◄────►│ action_type: str =  │◄─►│ "action_type":│  │
│  │   "platform.create" │      │   "platform.create" │   │ "platform.    │  │
│  │                     │      │                     │   │  create"      │  │
│  │ permissions=[       │◄────►│ permission: str =   │   │               │  │
│  │   "platform.        │      │   "platform.        │   │ "permissions":│  │
│  │    platforms:create"│      │    platforms:create"│   │ [...]         │  │
│  │ ]                   │      │                     │   │               │  │
│  └─────────────────────┘      └─────────────────────┘   └───────────────┘  │
│           │                            │                                    │
│           │     MUST MATCH             │                                    │
│           └────────────────────────────┘                                    │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
```

### Verification Commands

```bash
# META-TRIAD-01: Count Action classes with action_type
grep -r "action_type: str = " src/services/{service}/domain/actions/ | wc -l

# META-TRIAD-02: Verify action_type format (domain.operation)
grep -r 'action_type: str = "' src/services/{service}/domain/actions/ | \
    grep -E '"[a-z_]+\.[a-z_]+"' | wc -l

# META-TRIAD-03: Count Action classes with permission field
grep -r "permission: str = \|required_permission" src/services/{service}/domain/actions/ | wc -l

# META-TRIAD-06: Check handler signatures use Action classes
grep -r "action: .*Action\)" src/services/{service}/service_layer/handlers/ | wc -l

# META-TRIAD-07: Check ONTOLOGY has action_type
jq '.operations[] | select(.action_type != null) | .action_type' \
    features/{feature}/ONTOLOGY.jsonld | wc -l
```

### Python Verification

```python
def verify_meta_triad(service_path: Path, ontology: dict) -> list[RuleResult]:
    """Verify META-TRIAD-* rules for Operation/Action/Permission alignment."""
    results = []

    # Get all Action classes in service
    action_files = list((service_path / "domain/actions").glob("*_actions.py"))

    actions_with_type = 0
    actions_with_permission = 0
    total_actions = 0

    for action_file in action_files:
        content = action_file.read_text()

        # Count Action classes (class ...Action)
        import re
        action_classes = re.findall(r'class (\w+Action)\(', content)
        total_actions += len(action_classes)

        # Count action_type definitions
        actions_with_type += content.count('action_type: str = ')

        # Count permission definitions
        actions_with_permission += content.count('permission: str = ')
        actions_with_permission += content.count('required_permission')

    # META-TRIAD-01: action_type presence
    results.append(RuleResult(
        rule_id="META-TRIAD-01",
        expected=total_actions,
        actual=actions_with_type,
        status="PASS" if actions_with_type >= total_actions else "BLOCK",
        message=f"Actions with action_type: {actions_with_type}/{total_actions}"
    ))

    # META-TRIAD-03: permission presence
    results.append(RuleResult(
        rule_id="META-TRIAD-03",
        expected=total_actions,
        actual=actions_with_permission,
        status="PASS" if actions_with_permission >= total_actions else "BLOCK",
        message=f"Actions with permission: {actions_with_permission}/{total_actions}"
    ))

    # META-TRIAD-07: ONTOLOGY action_type
    ontology_ops = ontology.get("operations", [])
    if isinstance(ontology_ops, dict):
        ontology_ops = list(ontology_ops.values())

    ops_with_action_type = sum(
        1 for op in ontology_ops
        if op.get("action_type") is not None
    )
    results.append(RuleResult(
        rule_id="META-TRIAD-07",
        expected=len(ontology_ops),
        actual=ops_with_action_type,
        status="PASS" if ops_with_action_type >= len(ontology_ops) else "BLOCK",
        message=f"ONTOLOGY operations with action_type: {ops_with_action_type}/{len(ontology_ops)}"
    ))

    return results
```

### Cross-Reference Validation

```python
def verify_triad_consistency(service_path: Path, ontology: dict) -> list[RuleResult]:
    """Cross-reference validation between @operation, Action, and ONTOLOGY."""
    results = []

    # Build lookup: action_type -> Action class permission
    action_permissions = {}
    for action_file in (service_path / "domain/actions").glob("*_actions.py"):
        content = action_file.read_text()
        # Parse action_type and permission pairs
        # (simplified - real implementation would use AST)
        import re
        for match in re.finditer(
            r'action_type: str = "([^"]+)".*?permission: str = "([^"]+)"',
            content, re.DOTALL
        ):
            action_permissions[match.group(1)] = match.group(2)

    # Build lookup: action_type -> @operation permission
    from src.core.service.decorators import get_registered_operations
    decorator_permissions = {}
    for key, op in get_registered_operations().items():
        if hasattr(op, 'action_type') and op.action_type:
            decorator_permissions[op.action_type] = op.permissions[0] if op.permissions else None

    # META-TRIAD-05: Permission consistency
    mismatches = []
    for action_type in set(action_permissions.keys()) & set(decorator_permissions.keys()):
        if action_permissions[action_type] != decorator_permissions[action_type]:
            mismatches.append(f"{action_type}: Action={action_permissions[action_type]} != Decorator={decorator_permissions[action_type]}")

    results.append(RuleResult(
        rule_id="META-TRIAD-05",
        expected=0,
        actual=len(mismatches),
        status="PASS" if len(mismatches) == 0 else "BLOCK",
        message=f"Permission mismatches: {mismatches}" if mismatches else "All permissions consistent"
    ))

    return results
```

---

## Internationalization (META-I18N-*)

> **ServiceSpec Section:** §12
> **Purpose:** Verify i18n infrastructure is in place

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-I18N-01 | i18n_key in display | Scan display metadata | `"i18n_key":` | Fields with labels |
| META-I18N-02 | Default locale configured | Check config | `default_locale` | SERVICE_SPECIFICATION §12 |
| META-I18N-03 | Supported locales listed | Check config | `supported_locales` | SERVICE_SPECIFICATION §12 |
| META-I18N-04 | Translation files exist | Check locale files | `locales/{locale}.json` | Supported locales |
| META-I18N-05 | Accept-Language handling | Check middleware | `accept-language` | HTTP middleware |
| META-I18N-06 | Badge colors use HEX | Check color values | `#[0-9A-Fa-f]{6}` | Badge definitions |

### Verification Commands

```bash
# META-I18N-01: Count i18n_key fields
grep -r '"i18n_key":' src/services/{service}/ | wc -l

# META-I18N-04: Check locale files exist
ls locales/*.json 2>/dev/null | wc -l

# META-I18N-06: Check HEX colors (not color names)
grep -rE '"color":\s*"#[0-9A-Fa-f]{6}"' src/services/{service}/ | wc -l
```

---

## AI Discoverability (META-DISC-*)

> **ServiceSpec Section:** §14
> **Purpose:** Verify service is discoverable by AI agents

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-DISC-01 | /spec endpoint exists | Check router | `@router.get.*spec` | SERVICE_SPECIFICATION §14 |
| META-DISC-02 | ONTOLOGY.jsonld exists | Check feature folder | `features/{feature}/ONTOLOGY.jsonld` | Feature folder |
| META-DISC-03 | Operations match ONTOLOGY | Compare code to spec | decorator count = ONTOLOGY count | ONTOLOGY.jsonld |
| META-DISC-04 | Entities match ONTOLOGY | Compare models to spec | model count = ONTOLOGY count | ONTOLOGY.jsonld |
| META-DISC-05 | Errors match ONTOLOGY | Compare errors to spec | error count = ONTOLOGY count | ONTOLOGY.jsonld |
| META-DISC-06 | Workflows documented | Check ONTOLOGY workflows | `"workflows":` | ONTOLOGY.jsonld |
| META-DISC-07 | Troubleshooting entries | Check ONTOLOGY troubleshooting | `"troubleshooting":` | ONTOLOGY.jsonld |
| META-DISC-08 | Spec validation endpoint | Check router | `@router.get.*spec/validate` | SERVICE_SPECIFICATION §14.2 |

### Verification Commands

```bash
# META-DISC-01: Check /spec endpoint
grep -r '@router.get.*"/spec"' src/services/{service}/entrypoints/http/ | wc -l

# META-DISC-02: Check ONTOLOGY.jsonld exists
test -f features/{feature}/ONTOLOGY.jsonld && echo "EXISTS" || echo "MISSING"

# META-DISC-03: Compare operation counts
ONTOLOGY_OPS=$(jq '.operations | length' features/{feature}/ONTOLOGY.jsonld)
CODE_OPS=$(grep -r "@operation(" src/services/{service}/service_layer/handlers/ | wc -l)
[ "$CODE_OPS" -ge "$ONTOLOGY_OPS" ] && echo "PASS" || echo "BLOCK"
```

---

## Domain Events (META-EVENT-*)

> **ServiceSpec Section:** §8
> **Purpose:** Verify CloudEvents are properly emitted

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EVENT-01 | CloudEvents format | Scan event emission | `CloudEvent(` or `publish_event(` | SERVICE_SPECIFICATION §8 |
| META-EVENT-02 | Event type prefix | Check event types | `{domain}.{entity}.{action}` | SERVICE_SPECIFICATION §8.1 |
| META-EVENT-03 | Platform extensions | Check event attributes | `platformid`, `actorid` | SERVICE_SPECIFICATION §8.2 |
| META-EVENT-04 | State change events | Verify state transitions emit | Operation with causes_transition | ONTOLOGY.jsonld operations |

### Verification Commands

```bash
# META-EVENT-01: Count CloudEvent emissions
grep -r "publish_event\|CloudEvent(" src/services/{service}/ | wc -l

# META-EVENT-03: Check platform extensions
grep -r "platformid\|actorid" src/services/{service}/infrastructure/events.py | wc -l
```

---

## Consumption/Billing Events (META-BILLING-*)

> **ServiceSpec Section:** §8.7-8.12
> **Purpose:** Verify billable operations emit consumption events

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-BILLING-01 | Billable operations identified | Check SERVICE_SPECIFICATION | `billable: true` | SERVICE_SPECIFICATION §8.7 |
| META-BILLING-02 | Consumption events emitted | Scan for billing events | `emit_consumption_event(` | Billable operations |
| META-BILLING-03 | Metric IDs defined | Check event params | `metric_id=` | SERVICE_SPECIFICATION §8.8 |
| META-BILLING-04 | Bundling declarations | Check suppression | `suppressedby` | SERVICE_SPECIFICATION §8.10 |

### Verification Commands

```bash
# META-BILLING-02: Count consumption event emissions
grep -r "emit_consumption_event\|consumption_event" src/services/{service}/ | wc -l

# META-BILLING-03: Count metric_id usages
grep -r "metric_id=" src/services/{service}/ | wc -l
```

---

## Caching & Conditional Requests (META-CACHE-*)

> **ServiceSpec Section:** §3.4
> **Purpose:** Verify ETag and caching support

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-CACHE-01 | ETag generation | Check GET endpoints | `ETag` header | SERVICE_SPECIFICATION §3.4 |
| META-CACHE-02 | If-None-Match support | Check conditional GET | `If-None-Match` | SERVICE_SPECIFICATION §3.4 |
| META-CACHE-03 | If-Match support | Check conditional UPDATE | `If-Match` | SERVICE_SPECIFICATION §3.4 |
| META-CACHE-04 | Cache-Control headers | Check response headers | `Cache-Control` | SERVICE_SPECIFICATION §3.4 |

### Verification Commands

```bash
# META-CACHE-01: Check ETag support
grep -r "ETag\|etag" src/services/{service}/entrypoints/http/ | wc -l

# META-CACHE-02: Check If-None-Match
grep -r "If-None-Match\|if_none_match" src/services/{service}/ | wc -l
```

---

## Bindings (META-BIND-*)

> **ServiceSpec Section:** §11
> **Purpose:** Verify platform, SDK, and external bindings

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-BIND-01 | Platform binding exists | Check handler routing | Handler class exists | SERVICE_SPECIFICATION §11.1 |
| META-BIND-02 | SDK methods added | Check SDK resource | SDK resource class exists | SERVICE_SPECIFICATION §11.2 |
| META-BIND-03 | External auth uses secret_ref | Check credential handling | `secret_ref` pattern | SERVICE_SPECIFICATION §11.3 |
| META-BIND-04 | Resilience configuration | Check timeouts/retries | `timeout=`, `retries=` | SERVICE_SPECIFICATION §11.3.3 |

### Verification Commands

```bash
# META-BIND-02: Check SDK resource exists
test -f src/sdk/platform/resources/{service}.py && echo "EXISTS" || echo "MISSING"

# META-BIND-03: Check secret_ref pattern
grep -r "secret_ref\|secret:" src/services/{service}/ | wc -l
```

---

## Compliance Summary Matrix

Use this matrix to track compliance across all categories:

| Category | Rule Count | Blocking | Verification Type |
|----------|------------|----------|-------------------|
| META-ENT-* | 5 | ALL | Code scan + ONTOLOGY comparison |
| META-FORM-* | 8 | ALL | Code scan |
| META-OP-* | 12 | ALL | Decorator introspection + ONTOLOGY comparison |
| META-ERR-* | 5 | ALL | Code scan + ONTOLOGY comparison |
| META-I18N-* | 6 | ALL | Code scan + file existence |
| META-DISC-* | 8 | ALL | File existence + count comparison |
| META-EVENT-* | 4 | ALL | Code scan |
| META-BILLING-* | 4 | ALL | Code scan |
| META-CACHE-* | 4 | ALL | Code scan |
| META-BIND-* | 4 | ALL | File existence + code scan |
| **TOTAL** | **60** | **ALL** | |

---

## Integration with Production Guardian

Production Guardian should run these rules as **Phase N: ServiceSpec Compliance Scan**:

```python
def run_servicespec_compliance_scan(feature_folder: Path, service_path: Path) -> ComplianceReport:
    """Run all META-* rules and produce compliance report."""

    # Load ONTOLOGY.jsonld for expected values
    ontology = load_ontology(feature_folder / "ONTOLOGY.jsonld")

    # Run all rule categories
    results = []
    results.extend(verify_meta_ent(service_path, ontology))
    results.extend(verify_meta_form(service_path, ontology))
    results.extend(verify_meta_op(service_path, ontology))
    results.extend(verify_meta_err(service_path, ontology))
    results.extend(verify_meta_i18n(service_path, ontology))
    results.extend(verify_meta_disc(feature_folder, service_path, ontology))
    results.extend(verify_meta_event(service_path, ontology))
    results.extend(verify_meta_billing(service_path, ontology))
    results.extend(verify_meta_cache(service_path, ontology))
    results.extend(verify_meta_bind(service_path, ontology))

    # Any BLOCK = overall BLOCK
    blocking = [r for r in results if r.status == "BLOCK"]

    return ComplianceReport(
        total_rules=len(results),
        passed=len([r for r in results if r.status == "PASS"]),
        blocked=len(blocking),
        blocking_issues=blocking,
        overall_status="BLOCK" if blocking else "PASS"
    )
```

---

## Test Coverage

Each META-* category should have corresponding tests in:
`tests/unit/core/service/test_servicespec_compliance.py`

See the test file for implementation details.

---

# ServiceSpec EXTENSION Compliance Rules (META-EXT-*)

> **Applies to:** SERVICE_SPECIFICATION_EXTENSION (cross-cutting capabilities)
>
> **Template:** `methodology templates/specification/SERVICE_SPECIFICATION_EXTENSION_TEMPLATE.md`
>
> Extensions are different from Services - they add capabilities to ALL operations
> across ALL services, not new entities. The verification rules are different.

## Extension vs Service Applicability

| Rule Category | Services | Extensions |
|---------------|----------|------------|
| META-ENT-* | **YES** | NO (extensions don't have entities) |
| META-FORM-* | **YES** | NO (extensions don't have entities) |
| META-OP-* | **YES** | PARTIAL (decorator field, not full handler) |
| META-ERR-* | **YES** | **YES** (extension-specific errors) |
| META-I18N-* | **YES** | **YES** (error messages, headers) |
| META-DISC-* | **YES** | PARTIAL (no separate ONTOLOGY) |
| META-EVENT-* | **YES** | **YES** (extension events) |
| META-BILLING-* | **YES** | Rare (usually infrastructure) |
| META-CACHE-* | **YES** | N/A (caching is itself an extension) |
| META-BIND-* | **YES** | PARTIAL (middleware, not SDK resource) |
| **META-EXT-*** | NO | **YES** (extension-specific rules below) |

---

## Extension-Specific Rules (META-EXT-*)

### META-EXT-MW-* (Middleware Integration)

> **ServiceSpec Extension Section:** §4
> **Purpose:** Verify extension middleware is properly integrated

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-MW-01 | Middleware class exists | Check middleware folder | `class {Extension}Middleware` | §4.1 |
| META-EXT-MW-02 | Stack position documented | Check middleware order | Position in middleware stack | §4.1 |
| META-EXT-MW-03 | Resolution flow implemented | Check resolution logic | Resolution method exists | §4.2 |
| META-EXT-MW-04 | ServiceSpec extraction | Gets config from ServiceSpec | `get_{metadata_field}` | §4.2 |

### META-EXT-DEGRADE-* (Graceful Degradation)

> **ServiceSpec Extension Section:** §3.3
> **Purpose:** Verify extension degrades gracefully when misconfigured or unavailable

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-DEGRADE-01 | Default behavior defined | Check defaults | `get_default_config()` | §3.1 |
| META-EXT-DEGRADE-02 | Exempt operations documented | Check bypass list | `EXEMPT_OPERATIONS` | §3.2 |
| META-EXT-DEGRADE-03 | Invalid config fallback | Validation with fallback | `try...except ValidationError` | §3.3 |
| META-EXT-DEGRADE-04 | Fail-safe principle | Never fail on config | Request continues on error | §3.3 |

### META-EXT-CIRCUIT-* (Circuit Breaker)

> **ServiceSpec Extension Section:** §5.5
> **Purpose:** Verify circuit breaker pattern for external dependencies

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-CIRCUIT-01 | Circuit breaker exists | Check decorator/class | `@circuit_breaker` or `CircuitBreaker` | §5.5 |
| META-EXT-CIRCUIT-02 | Failure threshold defined | Check config | `failure_threshold=` | §5.5 |
| META-EXT-CIRCUIT-03 | Recovery timeout defined | Check config | `recovery_timeout=` | §5.5 |
| META-EXT-CIRCUIT-04 | Fallback behavior | Check fallback | Open circuit behavior | §5.5 |
| META-EXT-CIRCUIT-05 | Circuit metrics | Check observability | `circuit_state`, `circuit_failures` | §5.5 |

### META-EXT-BYPASS-* (Bypass Mechanisms)

> **ServiceSpec Extension Section:** §13
> **Purpose:** Verify admin and emergency bypass capabilities

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-BYPASS-01 | Admin bypass header | Check header handling | `X-Bypass-{Extension}` | §13.1 |
| META-EXT-BYPASS-02 | Bypass permission required | Check authorization | `{extension}.bypass` permission | §13.1 |
| META-EXT-BYPASS-03 | Bypass reason required | Check header | `X-Bypass-Reason` | §13.1 |
| META-EXT-BYPASS-04 | Bypass audit logging | Check logging | Bypass events logged | §13.3 |
| META-EXT-BYPASS-05 | Emergency bypass endpoint | Check admin API | `POST /admin/{extension}/bypass` | §13.2 |

### META-EXT-SLO-* (Performance Budget)

> **ServiceSpec Extension Section:** §10.4
> **Purpose:** Verify extension latency overhead is acceptable

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-SLO-01 | Latency budget documented | Check spec | p50 < 5ms, p99 < 50ms | §10.4 |
| META-EXT-SLO-02 | Duration metric exists | Check metrics | `{extension}_duration_ms` | §10.1 |
| META-EXT-SLO-03 | Availability SLO defined | Check spec | 99.99% availability target | §10.4 |
| META-EXT-SLO-04 | Latency alert configured | Check alerts | `{Extension}LatencyRegression` | §10.4 |
| META-EXT-SLO-05 | Error budget defined | Check spec | Budget calculation documented | §10.4 |

### META-EXT-ROLLOUT-* (Feature Flags & Rollout)

> **ServiceSpec Extension Section:** §12
> **Purpose:** Verify gradual rollout capability

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-ROLLOUT-01 | Feature flag integration | Check flag usage | `@feature_flag` or `is_feature_enabled` | §12.1 |
| META-EXT-ROLLOUT-02 | Rollout stages defined | Check spec | Canary → Early → Gradual → GA | §12.2 |
| META-EXT-ROLLOUT-03 | Sticky assignment | Check flag config | `sticky: true` | §12.3 |
| META-EXT-ROLLOUT-04 | Rollback procedure | Check docs | Documented rollback steps | §12.4 |

### META-EXT-COMPAT-* (Backward Compatibility)

> **ServiceSpec Extension Section:** §14
> **Purpose:** Verify deprecation and migration support

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-COMPAT-01 | Version in config | Check schema | `version` field | §14.1 |
| META-EXT-COMPAT-02 | Deprecation headers | Check response | `X-{Extension}-Deprecated` | §14.2 |
| META-EXT-COMPAT-03 | Sunset date header | Check response | `X-{Extension}-Sunset` | §14.2 |
| META-EXT-COMPAT-04 | Legacy mode support | Check config | `legacyMode` option | §14.3 |

### META-EXT-OP-* (Extension Metadata in @operation)

> **ServiceSpec Extension Section:** §17
> **Purpose:** Verify extension metadata field is added to @operation decorator

| Rule ID | Checklist Item | Verification Method | Code Pattern | Expected Source |
|---------|----------------|---------------------|--------------|-----------------|
| META-EXT-OP-01 | Metadata field defined | Check types.py | `{metadata_field}: {ExtensionConfig}` | §2.1 |
| META-EXT-OP-02 | @operation accepts field | Check decorator | `{metadata_field}=` parameter | §17.1 |
| META-EXT-OP-03 | Class-level defaults | Check decorator | `default_{metadata_field}` | §17.2 |
| META-EXT-OP-04 | Runtime extraction | Check middleware | Extracts config from operation | §4.2 |

---

## Extension Compliance Summary Matrix

| Category | Rule Count | Blocking | Description |
|----------|------------|----------|-------------|
| META-EXT-MW-* | 4 | ALL | Middleware integration |
| META-EXT-DEGRADE-* | 4 | ALL | Graceful degradation |
| META-EXT-CIRCUIT-* | 5 | ALL | Circuit breaker pattern |
| META-EXT-BYPASS-* | 5 | ALL | Admin/emergency bypass |
| META-EXT-SLO-* | 5 | ALL | Performance budget |
| META-EXT-ROLLOUT-* | 4 | ALL | Feature flag rollout |
| META-EXT-COMPAT-* | 4 | ALL | Backward compatibility |
| META-EXT-OP-* | 4 | ALL | Decorator integration |
| **TOTAL EXT** | **35** | **ALL** | Extension-specific |

**Plus applicable service rules:**
- META-ERR-* (5 rules) - Extension-specific errors
- META-I18N-* (6 rules) - Localized content
- META-EVENT-* (4 rules) - Extension events

**Total for Extensions:** ~50 rules (35 extension-specific + 15 shared)

---

## Extension Verification Commands

```bash
# META-EXT-MW-01: Check middleware class exists
grep -r "class.*Middleware" src/shared/middleware/{extension}/ | wc -l

# META-EXT-DEGRADE-01: Check default config function
grep -r "get_default_config\|default_config" src/shared/middleware/{extension}/ | wc -l

# META-EXT-CIRCUIT-01: Check circuit breaker
grep -r "@circuit_breaker\|CircuitBreaker" src/shared/{extension}/ | wc -l

# META-EXT-BYPASS-01: Check bypass header handling
grep -r "X-Bypass-" src/shared/middleware/{extension}/ | wc -l

# META-EXT-SLO-02: Check duration metric
grep -r "{extension}_duration" src/shared/{extension}/ | wc -l

# META-EXT-ROLLOUT-01: Check feature flag
grep -r "@feature_flag\|is_feature_enabled" src/shared/middleware/{extension}/ | wc -l

# META-EXT-OP-01: Check metadata field in types
grep -r "{metadata_field}:" src/core/service/types.py | wc -l
```

---

## Production Guardian: Extension Classification Detection

Production Guardian should detect classification and apply appropriate rules:

```python
def get_applicable_rules(lifecycle_state: dict) -> list[str]:
    """Determine which META-* rules apply based on classification."""

    classification = lifecycle_state.get("classification", "")

    if classification in ["service", "service_enhancement"]:
        # Services: All META-* rules including triad alignment
        return ["META-ENT-*", "META-FORM-*", "META-OP-*", "META-ERR-*",
                "META-TRIAD-*",  # Operation/Action/Permission alignment
                "META-I18N-*", "META-DISC-*", "META-EVENT-*", "META-BILLING-*",
                "META-CACHE-*", "META-BIND-*"]

    elif classification in ["servicespec_extension", "extension_enhancement"]:
        # Extensions: Extension-specific + shared rules
        return ["META-EXT-*",  # All extension-specific
                "META-ERR-*",  # Extension errors
                "META-I18N-*", # Localization
                "META-EVENT-*"]  # Extension events

    elif classification == "infrastructure":
        # Infrastructure: Minimal rules
        return ["META-BIND-01"]  # Just check handler exists

    else:
        # Unknown: Apply service rules as default
        return ["META-*"]
```
