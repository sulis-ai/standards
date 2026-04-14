---
name: test-scenarios
description: |
  Guidance for implementing test scenarios following the dual-mode adapter pattern.
  Helps translate design specifications into implementable tests that run locally
  (in-memory) and in CI/CD (real infrastructure).

  TRIGGER KEYWORDS (SEO-OPTIMIZED):

  ## Testing Action Verbs
  test, testing, write test, create test, implement test, add test,
  write tests, create tests, implement tests, add tests,
  unit test, integration test, e2e test, end-to-end test,
  verify, validate, check, assert, expect, confirm,
  cover, coverage, test coverage, increase coverage

  ## Test Types
  unit, integration, e2e, end-to-end, acceptance, regression,
  smoke, sanity, load, stress, performance, security, penetration,
  happy path, edge case, error case, boundary, negative test,
  positive test, golden path, sad path, unhappy path

  ## Test Infrastructure
  fixture, mock, stub, fake, spy, double, test double,
  setup, teardown, before, after, beforeEach, afterEach,
  conftest, pytest, test runner, test framework,
  in-memory, memory adapter, test adapter, dual-mode,
  factory, provider, repository, handler test

  ## Test Scenarios
  scenario, test case, test scenario, test spec, specification,
  given when then, arrange act assert, AAA, GWT,
  precondition, postcondition, assertion, expectation,
  TS-01, TS-02, AC-01, acceptance criteria

  ## CI/CD Testing
  CI/CD, continuous integration, pipeline, workflow,
  github actions, deploy, deployment test, integration test suite,
  SDK mode, HTTP mode, real infrastructure, live test,
  test orchestrator, test suite, cleanup manager

  ## Test Problems
  flaky, intermittent, failing, broken test, test failure,
  false positive, false negative, unreliable, unstable,
  slow test, timeout, test isolation, test pollution,
  missing test, no test, untested, test gap

  USE WHEN:
  - User wants to implement test scenarios from a DESIGN.md
  - User asks how to write tests for a feature
  - User needs guidance on dual-mode testing (in-memory vs SDK)
  - User wants to add tests to the CI/CD integration test suite
  - User asks about test fixtures, mocks, or adapters
  - User mentions TDD, RED-GREEN-REFACTOR, or test-first
  - User has a TEST_SCENARIOS.md and wants to implement it
  - User wants to understand the testing architecture

  WORKFLOW: Understand Requirements -> Pattern Selection -> Implementation Guidance
allowed-tools: Read, Glob, Grep
---

# Test Scenarios Implementation Guide

Guidance for implementing test scenarios following the dual-mode adapter pattern
used in Sulis Platform. This skill helps translate design specifications into working
tests that run both locally (zero dependencies) and in CI/CD (real infrastructure).

## Required Reading

Before implementing tests, review:

1. **`features/PLATFORM_CONVENTIONS.md`** - For consistent naming and terminology
   - Section 1.8: Entity IDs (prefixed: `usr_abc123`, `org_def456`)
   - Section 3: Standard Terminology (sys/data structure)

2. **`tests/README.md`** - Test organization and location guidelines

## When to Use

This skill should be invoked when:
- Implementing test scenarios from a DESIGN.md or TEST_SCENARIOS.md
- Writing new tests for a feature
- Understanding the dual-mode testing architecture
- Adding tests to the CI/CD integration test suite
- Debugging test issues or improving test reliability

---

## Core Concepts

### The Dual-Mode Testing Pattern

Sulis Platform uses a dual-mode pattern that allows the same test logic to run:
1. **Locally** - Fast, in-memory, zero external dependencies
2. **CI/CD** - Against real GCP infrastructure via SDK

```
┌─────────────────────────────────────────────────────────────┐
│                     TEST SCENARIO                           │
│  (Same business logic, same assertions)                     │
└─────────────────────────────────────────────────────────────┘
                              │
              ┌───────────────┼───────────────┐
              │                               │
              ▼                               ▼
┌─────────────────────────┐   ┌─────────────────────────┐
│    MEMORY MODE          │   │    SDK MODE             │
│                         │   │                         │
│  MemoryProvider         │   │  SulisClient        │
│  In-memory dicts        │   │  HTTP to Cloud Run      │
│  pytest fixtures        │   │  Real Firestore         │
│  ~10ms per test         │   │  ~500ms per test        │
│                         │   │                         │
│  WHEN: Local dev, TDD   │   │  WHEN: CI/CD pipeline   │
└─────────────────────────┘   └─────────────────────────┘
```

### Why This Pattern?

1. **Fast Local Development:** In-memory tests run in milliseconds
2. **No Dependencies:** Developers don't need GCP credentials locally
3. **Real Validation:** CI/CD tests catch infrastructure issues
4. **Same Logic:** Business logic tested identically in both modes
5. **TDD-Friendly:** Supports RED → GREEN → REFACTOR cycle

---

## Implementation Patterns

### Pattern 1: Unit Test with Memory Adapter

**Use for:** TS-01 through TS-08 (happy path, edge cases, errors)

**Location:** `tests/unit/services/{service}/service_layer/test_{entity}_handler.py`

```python
"""Unit tests for {Entity} handler.

These tests use in-memory adapters and run locally without external dependencies.
They validate business logic in the handler layer.
"""

import pytest
from src.services.{service}.infrastructure.memory_{provider} import Memory{Provider}
from src.services.{service}.service_layer.{entity}_handler import {Entity}Handler


@pytest.fixture
def provider() -> Memory{Provider}:
    """Fresh in-memory provider for each test."""
    return Memory{Provider}()


@pytest.fixture
def handler(provider: Memory{Provider}) -> {Entity}Handler:
    """Handler with test provider (no auth for unit tests)."""
    return {Entity}Handler(provider=provider)


class Test{Entity}Create:
    """Test scenarios for entity creation (TS-01, TS-02)."""

    @pytest.mark.asyncio
    async def test_ts01_create_success(self, handler: {Entity}Handler):
        """TS-01: Create entity with valid input succeeds.

        Given: Valid input data
        When: Create is called
        Then: Entity is created with correct attributes
        """
        # Arrange
        name = "Test Entity"

        # Act
        result = await handler.create(name=name)

        # Assert
        assert result.success is True
        assert result.data is not None
        assert result.data.name == name
        assert result.data.id is not None
        assert result.error is None

    @pytest.mark.asyncio
    async def test_ts02_create_with_optional_fields(self, handler: {Entity}Handler):
        """TS-02: Create entity with optional fields succeeds."""
        result = await handler.create(
            name="Test Entity",
            description="Optional description",
        )
        assert result.success is True
        assert result.data.description == "Optional description"


class Test{Entity}EdgeCases:
    """Test scenarios for edge cases (TS-03, TS-04, TS-05)."""

    @pytest.mark.asyncio
    async def test_ts03_boundary_max_length(self, handler: {Entity}Handler):
        """TS-03: Name at maximum length (255 chars) succeeds."""
        max_name = "a" * 255
        result = await handler.create(name=max_name)
        assert result.success is True
        assert len(result.data.name) == 255

    @pytest.mark.asyncio
    @pytest.mark.parametrize("invalid_name,expected_error", [
        ("", "empty"),
        (None, "required"),
        ("   ", "blank"),
    ])
    async def test_ts04_empty_null_input(
        self,
        handler: {Entity}Handler,
        invalid_name: str | None,
        expected_error: str,
    ):
        """TS-04: Empty/null input is rejected."""
        result = await handler.create(name=invalid_name)
        assert result.success is False
        assert expected_error in result.error.lower()

    @pytest.mark.asyncio
    async def test_ts05_exceeds_max_length(self, handler: {Entity}Handler):
        """TS-05: Name exceeding max length (256 chars) fails."""
        too_long = "a" * 256
        result = await handler.create(name=too_long)
        assert result.success is False
        assert "maximum" in result.error.lower() or "length" in result.error.lower()


class Test{Entity}Errors:
    """Test scenarios for error handling (TS-06, TS-07, TS-08)."""

    @pytest.mark.asyncio
    @pytest.mark.parametrize("injection_payload", [
        "'; DROP TABLE users; --",
        '{"$gt": ""}',
        "<script>alert('xss')</script>",
        "../../../etc/passwd",
    ])
    async def test_ts06_injection_prevention(
        self,
        handler: {Entity}Handler,
        injection_payload: str,
    ):
        """TS-06: Injection payloads are safely handled."""
        result = await handler.create(name=injection_payload)
        if result.success:
            # Stored safely as literal string
            stored = await handler.get(result.data.id)
            assert stored.data.name == injection_payload  # Not executed
        else:
            # Rejected as invalid
            assert "invalid" in result.error.lower()

    @pytest.mark.asyncio
    async def test_ts07_unauthorized_access(self, provider: Memory{Provider}):
        """TS-07: Unauthorized access is denied."""
        from unittest.mock import AsyncMock, Mock
        from src.shared.authorization.service_layer.authorization_service import (
            AuthorizationService,
            PermissionDenied,
        )

        # Setup mock auth service that denies access
        mock_auth = Mock(spec=AuthorizationService)
        mock_auth.check_permission = AsyncMock(
            side_effect=PermissionDenied("No access")
        )

        handler = {Entity}Handler(provider=provider, auth_service=mock_auth)

        result = await handler.create(
            name="test",
            user_id="unauthorized-user",
            platform_id="platform-123",
        )

        assert result.success is False
        assert "permission" in result.error.lower()

    @pytest.mark.asyncio
    async def test_ts08_not_found(self, handler: {Entity}Handler):
        """TS-08: Non-existent resource returns appropriate error."""
        result = await handler.get("non-existent-id")
        assert result.success is True
        assert result.data is None

        result = await handler.update("non-existent-id", name="new")
        assert result.success is False
        assert "not found" in result.error.lower()
```

---

### Pattern 2: Integration Test Suite (CI/CD)

**Use for:** TS-09 through TS-13 (security, e2e, multi-service)

**Location:** `src/services/platform/service_layer/integration_testing/test_suites/{feature}_tests.py`

```python
"""Integration tests for {Feature}.

These tests run in CI/CD against real infrastructure using the SDK.
They validate security, cross-tenant isolation, and end-to-end workflows.
"""

import logging
import time
from typing import TYPE_CHECKING

from src.services.platform.service_layer.integration_testing.cleanup_manager import (
    CleanupManager,
    EntityType,
)
from src.services.platform.service_layer.integration_testing.test_orchestrator import (
    TestResult,
    TestStatus,
    TestSuiteResult,
)

if TYPE_CHECKING:
    from src.services.platform.service_layer.integration_testing.adapters.protocol import (
        TestServiceAdapter,
    )

logger = logging.getLogger(__name__)


async def {feature}_test_suite(
    service: "TestServiceAdapter",
    test_run_id: str,
    cleanup_manager: CleanupManager,
) -> TestSuiteResult:
    """Test {feature} operations.

    Security and integration tests that require real infrastructure.

    Args:
        service: Test service adapter (SDK mode)
        test_run_id: Unique test run identifier
        cleanup_manager: Cleanup manager for entity tracking

    Returns:
        TestSuiteResult with test execution details
    """
    suite_name = "{Feature}Tests"
    tests: list[TestResult] = []
    start_time = time.time()

    # Setup: Create test resources
    platform = None
    try:
        platform = await service.create_platform(
            name=f"Test Platform {test_run_id}",
            slug=f"test-platform-{test_run_id}",
        )
        cleanup_manager.track_entity(test_run_id, EntityType.PLATFORM, platform.id)
        logger.info(f"✓ Test platform created: {platform.id}")
    except Exception as e:
        logger.error(f"✗ Setup failed: {e}")
        return TestSuiteResult(
            suite_name=suite_name,
            total_tests=0,
            passed_count=0,
            failed_count=1,
            status=TestStatus.FAILURE,
            tests=[],
            duration_seconds=time.time() - start_time,
            error_message=f"Setup failed: {e}",
        )

    # TS-09: Cross-Tenant Isolation
    test_start = time.time()
    try:
        # Create attacker tenant
        attacker_platform = await service.create_platform(
            name=f"Attacker Platform {test_run_id}",
            slug=f"attacker-platform-{test_run_id}",
        )
        cleanup_manager.track_entity(
            test_run_id, EntityType.PLATFORM, attacker_platform.id
        )

        attacker_org = await service.create_organization(
            platform_id=attacker_platform.id,
            name=f"Attacker Org {test_run_id}",
            slug=f"attacker-org-{test_run_id}",
        )
        cleanup_manager.track_entity(
            test_run_id, EntityType.ORGANIZATION, attacker_org.id
        )

        attacker_key = await service.create_api_key(
            organization_id=attacker_org.id,
            name=f"attacker-key-{test_run_id}",
        )
        cleanup_manager.track_entity(test_run_id, EntityType.API_KEY, attacker_key.id)

        # Create victim resource
        victim_org = await service.create_organization(
            platform_id=platform.id,
            name=f"Victim Org {test_run_id}",
            slug=f"victim-org-{test_run_id}",
        )
        cleanup_manager.track_entity(test_run_id, EntityType.ORGANIZATION, victim_org.id)

        # Attempt cross-tenant access using attacker's key
        if service.is_sdk_mode:
            from src.sdk.sulis.client import SulisClient

            attacker_client = SulisClient(
                api_key=attacker_key.key_value,
                base_url=service.base_url,
            )

            try:
                attacker_client.organizations.get(victim_org.id)
                # If we get here, security is broken
                tests.append(TestResult(
                    test_name="test_ts09_cross_tenant_isolation",
                    status=TestStatus.FAILURE,
                    duration_seconds=time.time() - test_start,
                    error_message="SECURITY: Attacker accessed victim's organization",
                ))
            except Exception as e:
                if "403" in str(e) or "404" in str(e) or "forbidden" in str(e).lower():
                    tests.append(TestResult(
                        test_name="test_ts09_cross_tenant_isolation",
                        status=TestStatus.SUCCESS,
                        duration_seconds=time.time() - test_start,
                    ))
                    logger.info("✓ TS-09: Cross-tenant isolation verified")
                else:
                    raise
        else:
            tests.append(TestResult(
                test_name="test_ts09_cross_tenant_isolation",
                status=TestStatus.SKIPPED,
                duration_seconds=0,
                error_message="Requires SDK mode",
            ))

    except Exception as e:
        tests.append(TestResult(
            test_name="test_ts09_cross_tenant_isolation",
            status=TestStatus.FAILURE,
            duration_seconds=time.time() - test_start,
            error_message=str(e),
        ))
        logger.error(f"✗ TS-09 failed: {e}")

    # TS-12: End-to-End Workflow
    test_start = time.time()
    try:
        # Complete workflow test
        workflow_org = await service.create_organization(
            platform_id=platform.id,
            name=f"Workflow Org {test_run_id}",
            slug=f"workflow-org-{test_run_id}",
        )
        cleanup_manager.track_entity(
            test_run_id, EntityType.ORGANIZATION, workflow_org.id
        )

        workflow_user = await service.create_user(
            platform_id=platform.id,
            email=f"workflow-{test_run_id}@test.com",
            given_name="Workflow",
            family_name="Test",
            provider="test",
            provider_user_id=f"test_workflow_{test_run_id[:12]}",
        )
        cleanup_manager.track_entity(test_run_id, EntityType.USER, workflow_user.id)

        workflow_key = await service.create_api_key(
            organization_id=workflow_org.id,
            name=f"workflow-key-{test_run_id}",
        )
        cleanup_manager.track_entity(test_run_id, EntityType.API_KEY, workflow_key.id)

        # Verify all entities retrievable
        retrieved_org = await service.get_organization(workflow_org.id)
        retrieved_user = await service.get_user(workflow_user.id)

        assert retrieved_org.id == workflow_org.id
        assert retrieved_user.id == workflow_user.id

        tests.append(TestResult(
            test_name="test_ts12_e2e_workflow",
            status=TestStatus.SUCCESS,
            duration_seconds=time.time() - test_start,
        ))
        logger.info("✓ TS-12: E2E workflow completed")

    except Exception as e:
        tests.append(TestResult(
            test_name="test_ts12_e2e_workflow",
            status=TestStatus.FAILURE,
            duration_seconds=time.time() - test_start,
            error_message=str(e),
        ))
        logger.error(f"✗ TS-12 failed: {e}")

    # Calculate results
    total_tests = len(tests)
    passed_count = sum(1 for t in tests if t.status == TestStatus.SUCCESS)
    failed_count = sum(1 for t in tests if t.status == TestStatus.FAILURE)
    suite_status = TestStatus.SUCCESS if failed_count == 0 else TestStatus.FAILURE

    return TestSuiteResult(
        suite_name=suite_name,
        total_tests=total_tests,
        passed_count=passed_count,
        failed_count=failed_count,
        status=suite_status,
        tests=tests,
        duration_seconds=time.time() - start_time,
    )
```

---

### Pattern 3: Registering in CI/CD Pipeline

**Location:** `.github/scripts/run_integration_tests.py`

Add your test suite to the orchestrator:

```python
# In the test suites list (around line 50-80)
from src.services.platform.service_layer.integration_testing.test_suites.{feature}_tests import (
    {feature}_test_suite,
)

# In the test_suites list
test_suites = [
    # ... existing suites ...
    ("{Feature}Tests", {feature}_test_suite),
]
```

---

## Test Fixture Patterns

### Memory Provider Fixture

```python
@pytest.fixture
def provider() -> Memory{Provider}:
    """Fresh in-memory provider for each test.

    Creates a new instance for test isolation.
    """
    return Memory{Provider}()
```

### Handler Fixture (No Auth)

```python
@pytest.fixture
def handler(provider: Memory{Provider}) -> {Entity}Handler:
    """Handler without auth service for unit tests.

    Business logic tests don't need authorization checks.
    """
    return {Entity}Handler(provider=provider)
```

### Handler Fixture (With Auth)

```python
@pytest.fixture
def handler_with_auth(
    provider: Memory{Provider},
    mock_auth_service: AuthorizationService,
) -> {Entity}Handler:
    """Handler with auth service for permission tests."""
    return {Entity}Handler(
        provider=provider,
        auth_service=mock_auth_service,
    )
```

### Factory Reset Fixture

```python
@pytest.fixture(autouse=True)
def reset_factory():
    """Reset factory singletons after each test.

    Ensures test isolation when factories use module-level singletons.
    """
    from src.services.{service}.infrastructure.factory import reset_{provider}
    yield
    reset_{provider}()
```

### Test Run ID Fixture

```python
@pytest.fixture
def test_run_id() -> str:
    """Unique identifier for this test run.

    Used to namespace test data and enable cleanup.
    """
    from uuid import uuid4
    return f"test-{uuid4().hex[:8]}"
```

---

## Test Data Patterns

### Parameterized Test Data

```python
@pytest.mark.parametrize("input_data,expected", [
    ({"name": "valid"}, True),
    ({"name": ""}, False),
    ({"name": None}, False),
    ({"name": "a" * 256}, False),
])
async def test_validation(handler, input_data, expected):
    result = await handler.create(**input_data)
    assert result.success is expected
```

### Test Data Constants

```python
# tests/conftest.py or tests/data/test_data.py

VALID_ENTITY_DATA = {
    "name": "Test Entity",
    "description": "A test entity",
    "status": "active",
}

INJECTION_PAYLOADS = [
    "'; DROP TABLE users; --",  # SQL
    '{"$gt": ""}',              # NoSQL
    "<script>alert(1)</script>", # XSS
    "{{7*7}}",                   # Template
    "../../../etc/passwd",       # Path traversal
]
```

---

## Common Test Assertions

### Result Pattern Assertions

```python
# Success assertion
assert result.success is True
assert result.data is not None
assert result.error is None

# Failure assertion
assert result.success is False
assert result.data is None
assert "expected error text" in result.error.lower()
```

### Entity Assertions

```python
# Entity created correctly
assert entity.id is not None
assert entity.name == expected_name
assert entity.status == "active"
assert entity.created_at is not None

# Entity updated correctly
assert updated.name == new_name
assert updated.id == original.id  # ID unchanged
```

### Security Assertions

```python
# Permission denied
assert result.success is False
assert "permission" in result.error.lower() or "denied" in result.error.lower()

# Not found (could be 404 or 403 for security)
assert result.success is False
assert "not found" in result.error.lower() or "forbidden" in result.error.lower()
```

---

## Debugging Test Failures

### Verbose Output

```bash
# See all output including prints
uv run pytest -vvs tests/path/to/test.py

# See full assertion diff
uv run pytest --tb=long tests/path/to/test.py

# Stop on first failure
uv run pytest -x tests/path/to/test.py
```

### Interactive Debugging

```bash
# Drop into debugger on failure
uv run pytest --pdb tests/path/to/test.py

# Drop into debugger at specific point
# Add this in test: import pdb; pdb.set_trace()
```

### Logging

```python
import logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

async def test_something(handler):
    logger.debug("Starting test with handler: %s", handler)
    result = await handler.create(name="test")
    logger.debug("Result: %s", result)
```

---

## Checklist: Implementing Test Scenarios

### Before Writing Tests

- [ ] Read the TEST_SCENARIOS.md for the feature
- [ ] Understand which scenarios are Memory mode vs SDK mode
- [ ] Check existing test patterns in similar services
- [ ] Identify required fixtures

### Writing Unit Tests (Memory Mode)

- [ ] Create test file in `tests/unit/services/{service}/`
- [ ] Add Memory provider fixture
- [ ] Add Handler fixture
- [ ] Implement TS-01 through TS-08 scenarios
- [ ] Use descriptive test names: `test_ts01_create_success`
- [ ] Include Given/When/Then comments
- [ ] Add parametrized tests for variations

### Writing Integration Tests (SDK Mode)

- [ ] Create test suite in `integration_testing/test_suites/`
- [ ] Follow the TestSuiteResult pattern
- [ ] Track all created entities for cleanup
- [ ] Implement TS-09 through TS-13 scenarios
- [ ] Register suite in `run_integration_tests.py`

### After Writing Tests

- [ ] Run locally: `uv run pytest tests/unit/ -v`
- [ ] Check coverage: `uv run pytest --cov=src/`
- [ ] Run pre-commit: `uv run nox -s pre-commit`
- [ ] Verify CI/CD passes after merge

---

## Related Documentation

- **Architecture:** `architecture/ARCHITECTURE.md` - Testing principles
- **Templates:** `methodology templates/feature/TEST_SCENARIOS_TEMPLATE.md` - Scenario format
- **Integration Tests:** `.github/scripts/run_integration_tests.py` - CI/CD runner
- **Test Suites:** `src/services/platform/service_layer/integration_testing/test_suites/` - Examples
