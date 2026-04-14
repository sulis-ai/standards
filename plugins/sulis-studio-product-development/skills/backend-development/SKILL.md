---
name: backend-development
description: |
  Guide backend development following Sulis Platform architecture patterns: handlers, ports, adapters,
  actions, routers, and workflow tools.

  TRIGGER KEYWORDS: backend, handler, service, port, adapter, action, repository, domain model,
  create service, add endpoint, new API, router, tool, workflow tool, provider, factory,
  infrastructure, TDD backend, domain-driven design, DDD, hexagonal architecture, ports and adapters,
  create handler, add handler method, new entity, add operation, implement provider.

  USE WHEN:
  - Creating a new backend service or capability
  - Adding handlers, ports, adapters, or actions
  - Implementing HTTP routes or workflow tools
  - Adding domain models
  - Setting up factory patterns for infrastructure
  - Working on service_layer, domain, infrastructure, or entrypoints directories
  - User says: "create handler", "add endpoint", "implement provider", "new service"

  PATTERNS: Handler-centric design, Ports & Adapters (Hexagonal), Repository, Action, Factory, Result, TDD.
allowed-tools: Bash, Read, Edit, Write, Glob, Grep
---

# Backend Development Guide

> **PORTABILITY NOTE:** This skill contains project-specific patterns (directory layout,
> framework conventions, adapter modes). When using this plugin outside the Sulis monorepo,
> adapt the directory paths and patterns to match your project's `scope-profile.yaml` and
> architecture. The TDD methodology and quality standards are universal; the implementation
> patterns are reference examples.

Guide for creating backend components that comply with architecture patterns.

## When to Use

This skill should be invoked when:
- **Creating a new backend capability** (service, feature, or API endpoint)
- **Adding to an existing service** (new handler methods, routes, tools)
- **Implementing infrastructure abstraction** (new provider/adapter)
- **Working in these directories:**
  - `src/services/{service}/domain/` - Domain models, ports, actions
  - `src/services/{service}/infrastructure/` - Adapters, factories, converters
  - `src/services/{service}/service_layer/` - Handlers
  - `src/services/{service}/entrypoints/` - HTTP routes, workflow tools
  - `src/shared/` - Cross-cutting infrastructure adapters

## Required Reading

Before implementing, read these documents:

1. **`features/PLATFORM_CONVENTIONS.md`** - Naming conventions, terminology, patterns
   - Section 1: Naming Conventions (camelCase for JSON, snake_case for Python)
   - Section 3: Standard Terminology (sys/data entity structure)
   - Section 4: Authentication patterns (PolicyResolver)

2. **`architecture/ARCHITECTURE.md`** - Core architecture principles

---

## Architecture Overview

Sulis Platform follows **Handler-Centric Design** with **Ports & Adapters** (Hexagonal Architecture):

```
                        ENTRYPOINTS
    (HTTP Router)    (Workflow Tool)    (SDK)
          |                |              |
          +--------+-------+-------+------+
                   |
                   v
    +--------------------------------------+
    |         HANDLER (service_layer/)     |
    |  - Single source of truth            |
    |  - Authorization checks FIRST        |
    |  - Returns Result[T] or Action       |
    +------------------+-------------------+
                       |
    +------------------v-------------------+
    |            DOMAIN (domain/)          |
    |  - Models: Pure data structures      |
    |  - Ports: Protocol interfaces        |
    |  - Actions: Typed operations         |
    +------------------+-------------------+
                       |
    +------------------v-------------------+
    |     INFRASTRUCTURE (infrastructure/) |
    |  - Memory adapters (testing)         |
    |  - Firestore/GCP adapters (prod)     |
    |  - Factory functions (selection)     |
    +--------------------------------------+
```

**Key Principles:**
1. **Handler is the single source of truth** - HTTP, Tools, SDK all call the same handler
2. **Authorization at handler level** - Check permissions before business logic
3. **Ports abstract infrastructure** - Protocol classes define interfaces
4. **Factory selects implementation** - Environment-based adapter selection
5. **In-memory first** - Always implement memory adapter for testing
6. **TDD always** - RED -> GREEN -> REFACTOR for all code

## Component Decision Tree

**What are you building?**

```
START
  |
  +-> "I need to store/retrieve data for a new entity"
  |     -> Create: Domain Model -> Port -> Memory Adapter -> Factory -> Handler -> Tests
  |
  +-> "I need to expose functionality via HTTP"
  |     -> Create: HTTP Router (uses existing Handler)
  |
  +-> "I need AI agents to use this functionality"
  |     -> Create: Workflow Tool (uses existing Handler)
  |
  +-> "I need a new operation for an existing entity"
  |     -> Add method to: Existing Handler -> Port (if needed) -> Tests
  |
  +-> "I need to integrate with external infrastructure"
  |     -> Create: Port -> Memory Adapter -> Production Adapter -> Factory
  |
  +-> "I need workflow-style operations with status tracking"
        -> Create: Action classes -> Handler integration
```

**Order of implementation (Double-Loop TDD):**

```
┌─────────────────────────────────────────────────────────────┐
│  OUTER LOOP: Integration Tests (write FIRST, all FAILING)   │
│  INT-HP-*, INT-ALT-*, INT-SEC-*, INT-RI-*, INT-J-*          │
│  Run locally with InMemoryServiceAdapter                     │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  INNER LOOP: Unit TDD (RED → GREEN → REFACTOR)              │
│  Domain → Infrastructure → Handler → Entrypoints             │
│  Continue until outer loop tests pass                        │
└─────────────────────────────────────────────────────────────┘
```

0. **Integration Tests** (outer loop - write FIRST, verify FAILING)
1. Domain Model (define the data)
2. Port (define the interface)
3. Memory Adapter (implement for testing)
4. Factory (select implementation)
5. Handler (business logic)
6. Unit Tests (inner loop TDD throughout)
7. Entrypoints (HTTP, Tools)
8. **Verify Integration Tests PASS** (outer loop complete)

---

## Step-by-Step Guides

### 1. Creating a Domain Model

**Location:** `src/services/{service}/domain/models/{entity}.py`

**Template:**

```python
"""Domain model for {Entity}.

This module defines the core domain model for {entity} management.
These models are pure domain objects with no infrastructure dependencies.
"""

from __future__ import annotations

from datetime import UTC, datetime
from enum import Enum
from uuid import uuid4

from pydantic import BaseModel, Field, field_validator


class {Entity}Status(str, Enum):
    """Status values for {entity}."""

    ACTIVE = "active"
    ARCHIVED = "archived"
    # Add domain-specific statuses


class {Entity}(BaseModel):
    """A {entity} domain model.

    Attributes:
        id: Unique identifier
        name: Human-readable name
        status: Current status
        created_at: Creation timestamp
        created_by: ID of creator
    """

    id: str = Field(default_factory=lambda: str(uuid4()))
    name: str = Field(..., description="{Entity} name")
    status: {Entity}Status = Field(default={Entity}Status.ACTIVE)
    created_at: datetime = Field(default_factory=lambda: datetime.now(UTC))
    created_by: str = Field(..., description="ID of user who created this")

    @field_validator("name")
    @classmethod
    def validate_name(cls, v: str) -> str:
        """Validate name is not empty."""
        if not v or not v.strip():
            raise ValueError("Name cannot be empty")
        return v.strip()

    model_config = {"frozen": False}
```

---

### 2. Creating a Port (Protocol Interface)

**Location:** `src/services/{service}/domain/ports/{provider}.py`

**Template:**

```python
"""Provider Port Interface.

This module defines the {Provider} Protocol - the interface that all
implementations must follow. This is the "port" in Ports & Adapters.

Implementations:
- Memory{Provider}: In-memory implementation for testing
- Firestore{Provider}: Firestore implementation for production
"""

from __future__ import annotations

from typing import TYPE_CHECKING, Protocol, runtime_checkable

if TYPE_CHECKING:
    from src.services.{service}.domain.models.{entity} import {Entity}


@runtime_checkable
class {Provider}(Protocol):
    """Protocol for {entity} provider implementations.

    All implementations (in-memory, Firestore, GCP, etc.) must implement
    this interface. This enables:
    - Edge-to-edge testing without external dependencies
    - Vendor independence (swap providers without code changes)
    - Local development without cloud credentials
    """

    async def create(self, entity: {Entity}) -> {Entity}:
        """Create a new {entity}.

        Args:
            entity: The {entity} to create

        Returns:
            The created {Entity}

        Raises:
            ValueError: If {entity} already exists
        """
        ...

    async def get(self, entity_id: str) -> {Entity} | None:
        """Get a {entity} by ID.

        Args:
            entity_id: ID to retrieve

        Returns:
            The {Entity} if found, None otherwise
        """
        ...

    async def update(self, entity: {Entity}) -> {Entity}:
        """Update an existing {entity}.

        Args:
            entity: The {entity} with updated fields

        Returns:
            The updated {Entity}

        Raises:
            ValueError: If {entity} not found
        """
        ...

    async def delete(self, entity_id: str) -> bool:
        """Delete a {entity}.

        Args:
            entity_id: ID to delete

        Returns:
            True if deleted, False if not found
        """
        ...

    async def list(
        self,
        limit: int = 100,
        offset: int = 0,
    ) -> list[{Entity}]:
        """List {entities} with pagination.

        Args:
            limit: Maximum number to return
            offset: Number to skip

        Returns:
            List of {Entity} objects
        """
        ...

    def clear(self) -> None:
        """Clear all data (test helper - optional)."""
        ...
```

---

### 3. Creating a Memory Adapter

**Location:** `src/services/{service}/infrastructure/memory_{provider}.py`

**Template:**

```python
"""In-memory {provider} implementation.

This module provides an in-memory implementation for testing and
local development. It stores all data in memory dictionaries.

Benefits:
- Fast (no I/O)
- No external dependencies
- Deterministic behavior for tests
- Works in any environment
"""

from __future__ import annotations

from src.services.{service}.domain.models.{entity} import {Entity}


class Memory{Provider}:
    """In-memory implementation of {Provider} protocol.

    Stores data in memory dictionaries. Thread-safe for single-threaded
    async operations.

    Example:
        provider = Memory{Provider}()
        entity = await provider.create({Entity}(name="test", created_by="user1"))
    """

    def __init__(self) -> None:
        """Initialize with empty storage."""
        self._entities: dict[str, {Entity}] = {}

    async def create(self, entity: {Entity}) -> {Entity}:
        """Create a new {entity}."""
        if entity.id in self._entities:
            raise ValueError(f"{Entity} '{entity.id}' already exists")
        self._entities[entity.id] = entity
        return entity

    async def get(self, entity_id: str) -> {Entity} | None:
        """Get a {entity} by ID."""
        return self._entities.get(entity_id)

    async def update(self, entity: {Entity}) -> {Entity}:
        """Update an existing {entity}."""
        if entity.id not in self._entities:
            raise ValueError(f"{Entity} '{entity.id}' not found")
        self._entities[entity.id] = entity
        return entity

    async def delete(self, entity_id: str) -> bool:
        """Delete a {entity}."""
        if entity_id in self._entities:
            del self._entities[entity_id]
            return True
        return False

    async def list(
        self,
        limit: int = 100,
        offset: int = 0,
    ) -> list[{Entity}]:
        """List {entities} with pagination."""
        entities = list(self._entities.values())
        return entities[offset : offset + limit]

    def clear(self) -> None:
        """Clear all data (test helper)."""
        self._entities.clear()
```

---

### 4. Creating a Factory

**Location:** `src/services/{service}/infrastructure/factory.py`

**Template:**

```python
"""Factory functions for provider instances.

Environment Variables:
    INFRA_PROVIDER: The provider to use
        - "memory" (default): In-memory for local dev/testing
        - "firestore": Firestore-backed for production
        - "gcp": GCP native services (real GCP APIs)
    GCP_PROJECT_ID: Required when INFRA_PROVIDER=gcp
"""

from __future__ import annotations

import os
from typing import TYPE_CHECKING

from src.services.{service}.infrastructure.memory_{provider} import Memory{Provider}

if TYPE_CHECKING:
    from src.services.{service}.domain.ports.{provider} import {Provider}

# Module-level singleton
_{provider}_instance: {Provider} | None = None


def _get_provider_type() -> str:
    """Get configured provider type from environment."""
    return os.environ.get("INFRA_PROVIDER", "memory").lower()


def get_{provider}() -> {Provider}:
    """Get the {provider} instance.

    Returns singleton instance, creating appropriate implementation
    based on environment configuration.

    Returns:
        The {provider} instance
    """
    global _{provider}_instance

    if _{provider}_instance is None:
        provider_type = _get_provider_type()

        if provider_type == "firestore":
            # Lazy import for production dependencies
            from src.services.{service}.infrastructure.firestore_{provider} import (
                Firestore{Provider},
            )
            _{provider}_instance = Firestore{Provider}()
        elif provider_type == "gcp":
            # Lazy import for GCP dependencies
            from src.shared.adapters.google.{service} import GCP{Provider}
            project_id = os.environ.get("GCP_PROJECT_ID", "")
            _{provider}_instance = GCP{Provider}(project_id=project_id)
        else:
            # Default to in-memory
            _{provider}_instance = Memory{Provider}()

    return _{provider}_instance


def set_{provider}(provider: {Provider}) -> None:
    """Set the {provider} instance (for testing).

    Args:
        provider: The provider instance to use
    """
    global _{provider}_instance
    _{provider}_instance = provider


def reset_{provider}() -> None:
    """Reset {provider} to None (for test isolation)."""
    global _{provider}_instance
    _{provider}_instance = None
```

---

### 5. Creating a Handler (with Result Pattern)

**Location:** `src/services/{service}/service_layer/{entity}_handler.py`

**Template:**

```python
"""{Entity} Handler - Single source of truth for {entity} operations.

This handler is called by:
- HTTP routes (entrypoints/http/{entity}_router.py)
- Agent tools (entrypoints/tools/{entity}_tool.py)
- SDK clients (when added)

Permissions:
- {service}.{entities}:create - Create {entities}
- {service}.{entities}:read - Read {entity} details
- {service}.{entities}:update - Update {entities}
- {service}.{entities}:delete - Delete {entities}
- {service}.{entities}:list - List {entities}
"""

from __future__ import annotations

import logging
from dataclasses import dataclass
from typing import TYPE_CHECKING, Generic, TypeVar

from src.shared.authorization.service_layer.authorization_service import PermissionDenied

if TYPE_CHECKING:
    from src.services.{service}.domain.models.{entity} import {Entity}
    from src.services.{service}.domain.ports.{provider} import {Provider}
    from src.shared.authorization.service_layer.authorization_service import (
        AuthorizationService,
    )

logger = logging.getLogger(__name__)

T = TypeVar("T")


@dataclass
class Result(Generic[T]):
    """Result wrapper for handler operations."""

    success: bool
    data: T | None = None
    error: str | None = None

    @classmethod
    def ok(cls, data: T) -> Result[T]:
        """Create successful result."""
        return cls(success=True, data=data, error=None)

    @classmethod
    def fail(cls, error: str) -> Result[T]:
        """Create failed result."""
        return cls(success=False, data=None, error=error)


class {Entity}Handler:
    """Handler for {entity} operations - the single source of truth.

    All business logic for {entity} operations lives here. HTTP routes,
    workflow tools, and SDK clients all delegate to this handler.
    """

    def __init__(
        self,
        provider: {Provider},
        auth_service: AuthorizationService | None = None,
    ) -> None:
        """Initialize with provider and optional auth service.

        Args:
            provider: The {provider} implementation to use
            auth_service: Optional authorization service for permission checks
        """
        self._provider = provider
        self._auth_service = auth_service

    async def _check_permission(
        self,
        permission: str,
        user_id: str | None,
        platform_id: str | None,
    ) -> str | None:
        """Check permission and return error message if denied.

        This helper adapts the exception-based AuthorizationService to the
        error-string pattern used by handlers.

        Args:
            permission: Permission string to check (e.g., "{service}.{entities}:create")
            user_id: User ID for authorization
            platform_id: Platform ID for authorization

        Returns:
            None if allowed, error message string if denied
        """
        # No auth service = testing mode, allow all
        if self._auth_service is None:
            return None

        # Missing user_id or platform_id = skip auth (internal calls)
        if user_id is None or platform_id is None:
            return None

        try:
            await self._auth_service.check_permission(
                user_id=user_id,
                platform_id=platform_id,
                permission=permission,
            )
            return None  # Allowed
        except PermissionDenied as e:
            logger.warning(
                "Permission denied: user=%s, permission=%s, platform=%s",
                user_id,
                permission,
                platform_id,
            )
            return f"Permission denied: {e}"

    async def create(
        self,
        name: str,
        user_id: str | None = None,
        platform_id: str | None = None,
    ) -> Result[{Entity}]:
        """Create a new {entity}.

        Args:
            name: {Entity} name
            user_id: User ID for authorization and audit
            platform_id: Platform ID for authorization

        Returns:
            Result containing created {entity} or error
        """
        # Authorization check FIRST - before any business logic
        auth_error = await self._check_permission(
            "{service}.{entities}:create", user_id, platform_id
        )
        if auth_error is not None:
            return Result.fail(auth_error)

        try:
            from src.services.{service}.domain.models.{entity} import {Entity}

            entity = {Entity}(name=name, created_by=user_id or "system")
            created = await self._provider.create(entity)
            return Result.ok(created)
        except ValueError as e:
            return Result.fail(str(e))
        except Exception as e:
            return Result.fail(f"Failed to create {entity}: {e}")

    async def get(
        self,
        entity_id: str,
        user_id: str | None = None,
        platform_id: str | None = None,
    ) -> Result[{Entity} | None]:
        """Get a {entity} by ID.

        Args:
            entity_id: ID of the {entity} to retrieve
            user_id: User ID for authorization
            platform_id: Platform ID for authorization

        Returns:
            Result containing {entity} or None if not found
        """
        auth_error = await self._check_permission(
            "{service}.{entities}:read", user_id, platform_id
        )
        if auth_error is not None:
            return Result.fail(auth_error)

        try:
            entity = await self._provider.get(entity_id)
            return Result.ok(entity)
        except Exception as e:
            return Result.fail(f"Failed to get {entity}: {e}")

    async def update(
        self,
        entity_id: str,
        name: str | None = None,
        user_id: str | None = None,
        platform_id: str | None = None,
    ) -> Result[{Entity}]:
        """Update a {entity}.

        Args:
            entity_id: ID of the {entity} to update
            name: New name (optional)
            user_id: User ID for authorization
            platform_id: Platform ID for authorization

        Returns:
            Result containing updated {entity} or error
        """
        auth_error = await self._check_permission(
            "{service}.{entities}:update", user_id, platform_id
        )
        if auth_error is not None:
            return Result.fail(auth_error)

        try:
            entity = await self._provider.get(entity_id)
            if entity is None:
                return Result.fail(f"{Entity} '{entity_id}' not found")

            if name is not None:
                entity.name = name

            updated = await self._provider.update(entity)
            return Result.ok(updated)
        except ValueError as e:
            return Result.fail(str(e))
        except Exception as e:
            return Result.fail(f"Failed to update {entity}: {e}")

    async def delete(
        self,
        entity_id: str,
        user_id: str | None = None,
        platform_id: str | None = None,
    ) -> Result[bool]:
        """Delete a {entity}.

        Args:
            entity_id: ID of the {entity} to delete
            user_id: User ID for authorization
            platform_id: Platform ID for authorization

        Returns:
            Result containing True if deleted, False if not found
        """
        auth_error = await self._check_permission(
            "{service}.{entities}:delete", user_id, platform_id
        )
        if auth_error is not None:
            return Result.fail(auth_error)

        try:
            deleted = await self._provider.delete(entity_id)
            return Result.ok(deleted)
        except Exception as e:
            return Result.fail(f"Failed to delete {entity}: {e}")

    async def list(
        self,
        limit: int = 100,
        offset: int = 0,
        user_id: str | None = None,
        platform_id: str | None = None,
    ) -> Result[list[{Entity}]]:
        """List all {entities}.

        Args:
            limit: Maximum number to return
            offset: Number to skip
            user_id: User ID for authorization
            platform_id: Platform ID for authorization

        Returns:
            Result containing list of {entities}
        """
        auth_error = await self._check_permission(
            "{service}.{entities}:list", user_id, platform_id
        )
        if auth_error is not None:
            return Result.fail(auth_error)

        try:
            entities = await self._provider.list(limit=limit, offset=offset)
            return Result.ok(entities)
        except Exception as e:
            return Result.fail(f"Failed to list {entities}: {e}")
```

---

### 6. Creating an Action (with Typed Inputs/Outputs)

**Location:** `src/services/{service}/domain/actions/{entity}_actions.py`

**Template:**

```python
"""Actions for {entity} operations.

Actions define WHAT to do (business rules in docstring).
Handlers define HOW to do it (implementation).

Each action has:
- Typed input (Pydantic model)
- Typed output (domain model)
- Status tracking (ProcessStatus, ResultStatus)
- Rollback support for write operations
"""

from __future__ import annotations

from typing import TYPE_CHECKING, Any

from pydantic import BaseModel, Field

from src.shared.service_layer.action_base import Action
from src.shared.service_layer.common_types import ProcessType

if TYPE_CHECKING:
    from src.services.{service}.domain.models.{entity} import {Entity}
    from src.services.{service}.service_layer.handlers.{entity}_handler import (
        {Entity}Handler,
    )


# Input Models
class Create{Entity}Input(BaseModel):
    """Input model for {entity} creation."""

    name: str = Field(..., min_length=1, description="{Entity} name")
    # Add more fields as needed


class Update{Entity}Input(BaseModel):
    """Input model for {entity} update."""

    name: str | None = Field(None, description="New name (optional)")
    # Add more fields as needed


# Actions
class Create{Entity}Action(Action[Create{Entity}Input, "{Entity}"]):
    """Action to create a new {entity}.

    Business Rules:
    - Generate {entity} ID
    - Validate name is unique (if required)
    - Store in repository
    - Publish {entity}.created event (if events enabled)

    Rollback:
    - Delete created {entity}
    """

    handler: type["{Entity}Handler"] | None = None

    def __init__(
        self,
        input_data: Create{Entity}Input,
        created_by: str,
        platform_id: str | None = None,
        **kwargs: Any,
    ) -> None:
        """Initialize create {entity} action.

        Args:
            input_data: {Entity} creation data (strongly typed)
            created_by: ID of user creating this {entity}
            platform_id: Platform ID for authorization
            **kwargs: Additional action parameters
        """
        self.created_by = created_by
        self.platform_id = platform_id

        super().__init__(
            input_data=input_data,
            process_type=ProcessType.CREATE,
            should_persist=True,  # Log action to repository
            **kwargs,
        )

    async def rollback(self) -> bool:
        """Rollback {entity} creation by deleting the {entity}.

        Returns:
            bool: True if rollback successful, False otherwise
        """
        if self.result and self.handler:
            try:
                # Delete the created entity
                # await self.handler.delete(self.result.id)
                return True
            except Exception as e:
                self.set_warning(f"Failed to rollback {entity} creation: {e}")
                return False
        return False


class Get{Entity}Action(Action[None, "{Entity} | None"]):
    """Action to get a {entity} by ID.

    Business Rules:
    - Load {entity} from repository
    - Return None if not found
    """

    handler: type["{Entity}Handler"] | None = None

    def __init__(
        self,
        entity_id: str,
        user_id: str | None = None,
        platform_id: str | None = None,
        **kwargs: Any,
    ) -> None:
        """Initialize get {entity} action.

        Args:
            entity_id: ID of {entity} to retrieve
            user_id: User ID for authorization
            platform_id: Platform ID for authorization
            **kwargs: Additional action parameters
        """
        self.entity_id = entity_id
        self.user_id = user_id
        self.platform_id = platform_id

        super().__init__(
            input_data=None,
            process_type=ProcessType.READ,
            should_persist=False,  # Don't log read operations
            **kwargs,
        )

    async def rollback(self) -> bool:
        """No rollback needed for read operation."""
        return True


class Update{Entity}Action(Action[Update{Entity}Input, "{Entity}"]):
    """Action to update a {entity}.

    Business Rules:
    - Load existing {entity}
    - Apply updates
    - Save changes
    - Publish {entity}.updated event (if events enabled)

    Rollback:
    - Restore previous state
    """

    handler: type["{Entity}Handler"] | None = None

    def __init__(
        self,
        entity_id: str,
        input_data: Update{Entity}Input,
        user_id: str | None = None,
        platform_id: str | None = None,
        **kwargs: Any,
    ) -> None:
        """Initialize update {entity} action.

        Args:
            entity_id: ID of {entity} to update
            input_data: Update data (strongly typed)
            user_id: User ID for authorization
            platform_id: Platform ID for authorization
            **kwargs: Additional action parameters
        """
        self.entity_id = entity_id
        self.user_id = user_id
        self.platform_id = platform_id
        self._previous_state: {Entity} | None = None

        super().__init__(
            input_data=input_data,
            process_type=ProcessType.UPDATE,
            should_persist=True,
            **kwargs,
        )

    async def rollback(self) -> bool:
        """Rollback by restoring previous state."""
        if self._previous_state and self.handler:
            try:
                # Restore previous state
                return True
            except Exception as e:
                self.set_warning(f"Failed to rollback {entity} update: {e}")
                return False
        return False


class Delete{Entity}Action(Action[None, bool]):
    """Action to delete a {entity}.

    Business Rules:
    - Check {entity} exists
    - Delete from repository
    - Publish {entity}.deleted event (if events enabled)

    Rollback:
    - Recreate deleted {entity} (if state preserved)
    """

    handler: type["{Entity}Handler"] | None = None

    def __init__(
        self,
        entity_id: str,
        user_id: str | None = None,
        platform_id: str | None = None,
        **kwargs: Any,
    ) -> None:
        """Initialize delete {entity} action.

        Args:
            entity_id: ID of {entity} to delete
            user_id: User ID for authorization
            platform_id: Platform ID for authorization
            **kwargs: Additional action parameters
        """
        self.entity_id = entity_id
        self.user_id = user_id
        self.platform_id = platform_id
        self._deleted_entity: {Entity} | None = None

        super().__init__(
            input_data=None,
            process_type=ProcessType.DELETE,
            should_persist=True,
            **kwargs,
        )

    async def rollback(self) -> bool:
        """Rollback by recreating deleted {entity}."""
        if self._deleted_entity and self.handler:
            try:
                # Recreate deleted entity
                return True
            except Exception as e:
                self.set_warning(f"Failed to rollback {entity} deletion: {e}")
                return False
        return False
```

---

### 7. Creating an HTTP Router

**Location:** `src/services/{service}/entrypoints/http/{entity}_router.py`

**Naming Conventions (from `features/PLATFORM_CONVENTIONS.md`):**
- **URL paths:** kebab-case (`/api/v1/user-settings`)
- **JSON fields:** camelCase (`customerId`, `createdAt`)
- **Python code:** snake_case (`customer_id`, `created_at`)
- **Query params:** camelCase (`?pageSize=10`)

Use Pydantic aliases to convert Python snake_case to JSON camelCase:

```python
class UserResponse(BaseModel):
    given_name: str = Field(..., alias="givenName", serialization_alias="givenName")
    created_at: datetime = Field(..., alias="createdAt", serialization_alias="createdAt")

    model_config = ConfigDict(populate_by_name=True)
```

**Template:**

```python
"""{Entity} HTTP Router - FastAPI routes for {entity} operations.

This router delegates all operations to {Entity}Handler (single source of truth).
Routes are thin wrappers that translate HTTP requests/responses.
"""

from __future__ import annotations

from typing import Any

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, Field

from src.services.{service}.infrastructure.factory import get_{provider}
from src.services.{service}.service_layer.{entity}_handler import {Entity}Handler

router = APIRouter(prefix="/api/{entities}", tags=["{entities}"])


def get_{entity}_handler() -> {Entity}Handler:
    """Get configured handler instance."""
    provider = get_{provider}()
    return {Entity}Handler(provider=provider)


# Request/Response Models
class Create{Entity}Request(BaseModel):
    """Request model for creating a {entity}."""

    name: str = Field(..., min_length=1, max_length=255)


class Update{Entity}Request(BaseModel):
    """Request model for updating a {entity}."""

    name: str | None = Field(None, min_length=1, max_length=255)


class {Entity}Response(BaseModel):
    """Response model for a {entity}."""

    id: str
    name: str
    status: str
    created_at: str


# Routes
@router.post("", status_code=status.HTTP_201_CREATED)
async def create_{entity}(
    request: Create{Entity}Request,
    handler: {Entity}Handler = Depends(get_{entity}_handler),
) -> dict[str, Any]:
    """Create a new {entity}."""
    result = await handler.create(name=request.name)

    if not result.success:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"error": result.error},
        )

    entity = result.data
    return {
        "success": True,
        "{entity}": {
            "id": entity.id,
            "name": entity.name,
            "status": entity.status.value,
            "created_at": entity.created_at.isoformat(),
        },
    }


@router.get("")
async def list_{entities}(
    limit: int = 100,
    offset: int = 0,
    handler: {Entity}Handler = Depends(get_{entity}_handler),
) -> dict[str, Any]:
    """List all {entities}."""
    result = await handler.list(limit=limit, offset=offset)

    if not result.success:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail={"error": result.error},
        )

    return {
        "success": True,
        "{entities}": [
            {
                "id": e.id,
                "name": e.name,
                "status": e.status.value,
                "created_at": e.created_at.isoformat(),
            }
            for e in (result.data or [])
        ],
    }


@router.get("/{entity_id}")
async def get_{entity}(
    entity_id: str,
    handler: {Entity}Handler = Depends(get_{entity}_handler),
) -> dict[str, Any]:
    """Get a {entity} by ID."""
    result = await handler.get(entity_id)

    if not result.success:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail={"error": result.error},
        )

    if result.data is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"error": f"{Entity} '{entity_id}' not found"},
        )

    entity = result.data
    return {
        "success": True,
        "{entity}": {
            "id": entity.id,
            "name": entity.name,
            "status": entity.status.value,
            "created_at": entity.created_at.isoformat(),
        },
    }


@router.patch("/{entity_id}")
async def update_{entity}(
    entity_id: str,
    request: Update{Entity}Request,
    handler: {Entity}Handler = Depends(get_{entity}_handler),
) -> dict[str, Any]:
    """Update a {entity}."""
    result = await handler.update(entity_id=entity_id, name=request.name)

    if not result.success:
        if "not found" in (result.error or "").lower():
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail={"error": result.error},
            )
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"error": result.error},
        )

    entity = result.data
    return {
        "success": True,
        "{entity}": {
            "id": entity.id,
            "name": entity.name,
            "status": entity.status.value,
            "created_at": entity.created_at.isoformat(),
        },
    }


@router.delete("/{entity_id}")
async def delete_{entity}(
    entity_id: str,
    handler: {Entity}Handler = Depends(get_{entity}_handler),
) -> dict[str, Any]:
    """Delete a {entity}."""
    result = await handler.delete(entity_id)

    if not result.success:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail={"error": result.error},
        )

    if not result.data:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail={"error": f"{Entity} '{entity_id}' not found"},
        )

    return {"success": True, "deleted": True}
```

---

### 7A. Deployment Wiring (CRITICAL)

> **Creating an HTTP router is NOT enough.** The router must be mounted in the service's
> FastAPI app, SDK methods added, and integration tests registered in CI/CD.
>
> **Without these steps, endpoints will return 404 in deployed environments.**

#### 7A.1 Mount Router in Service

**Location:** `src/services/{service}/entrypoints/http/__init__.py`

After creating a router, you MUST mount it in the service's FastAPI app:

```python
# src/services/{service}/entrypoints/http/__init__.py

from fastapi import FastAPI

# Import ALL routers for this service
from .{entity}_router import router as {entity}_router
from .health_router import router as health_router
# ... other routers

app = FastAPI(
    title="{Service} API",
    version="1.0.0",
)

# Mount ALL routers
app.include_router(health_router)
app.include_router({entity}_router)  # <-- ADD YOUR NEW ROUTER HERE
# ... other routers
```

**Verification:**
```bash
# Start service locally
uv run uvicorn src.services.{service}.entrypoints.http:app --reload

# Verify endpoint is accessible
curl http://localhost:8000/api/v1/{resource}
# Expected: 200 OK (or 401 if auth required)
```

#### 7A.2 Add SDK Methods (if user-facing)

**Location:** `src/sdk/platform/resources/{resource}.py`

If the endpoint is user-facing (not internal-only), add SDK methods:

```python
# src/sdk/platform/resources/{resource}.py

from __future__ import annotations

from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from src.sdk.sulis.client import SulisClient


class {Resource}Resource:
    """SDK resource for {resource} operations."""

    def __init__(self, client: "SulisClient") -> None:
        self._client = client

    async def create(self, name: str) -> dict:
        """Create a new {resource}."""
        return await self._client._request(
            "POST",
            "/api/v1/{resource}",
            json={"name": name},
        )

    async def get(self, resource_id: str) -> dict:
        """Get a {resource} by ID."""
        return await self._client._request(
            "GET",
            f"/api/v1/{resource}/{resource_id}",
        )

    async def list(self, limit: int = 100, offset: int = 0) -> dict:
        """List all {resources}."""
        return await self._client._request(
            "GET",
            "/api/v1/{resource}",
            params={"limit": limit, "offset": offset},
        )
```

**Register in Client:**
```python
# src/sdk/platform/client.py

from .resources.{resource} import {Resource}Resource

class SulisClient:
    def __init__(self, ...):
        # ... existing initialization
        self.{resource} = {Resource}Resource(self)  # <-- ADD THIS
```

#### 7A.3 Create Integration Test Suite

**Location:** `src/services/{service}/service_layer/integration_testing/test_suites/{feature}_tests.py`

Create integration tests that run in CI/CD:

```python
# src/services/{service}/service_layer/integration_testing/test_suites/{feature}_tests.py

"""Integration tests for {feature}."""

async def {feature}_test_suite(
    service: "TestServiceAdapter",
    test_run_id: str,
    cleanup_manager: CleanupManager,
) -> TestSuiteResult:
    """Integration tests for {feature}."""
    results = []

    # INT-HP-01: Create {entity} returns success
    async def test_create_success():
        result = await service.{resource}.create(name="test-{entity}")
        assert result is not None
        cleanup_manager.register(EntityType.{ENTITY}, result["id"])
        return True

    # ... more tests

    return build_suite_result("{feature}", results)
```

#### 7A.4 Register in CI/CD Runner

**Location:** `.github/scripts/run_integration_tests.py`

Add your test suite to the CI/CD runner:

```python
# .github/scripts/run_integration_tests.py

from src.services.{service}.service_layer.integration_testing.test_suites.{feature}_tests import (
    {feature}_test_suite,
)

INTEGRATION_TEST_SUITES = [
    # ... existing suites
    {feature}_test_suite,  # <-- ADD YOUR SUITE HERE
]
```

#### 7A.5 Deployment Wiring Checklist

Before considering a feature "deployment ready":

| Step | Location | Action | Verified |
|------|----------|--------|----------|
| 1 | Router file | `router = APIRouter(prefix="/api/v1/{resource}")` | [ ] |
| 2 | Service `__init__.py` | `app.include_router({entity}_router)` | [ ] |
| 3 | Local test | `curl http://localhost:8000/api/v1/{resource}` works | [ ] |
| 4 | SDK resource | Create `{Resource}Resource` class | [ ] (if user-facing) |
| 5 | SDK client | Register `self.{resource} = {Resource}Resource(self)` | [ ] (if user-facing) |
| 6 | Test suite | Create `{feature}_tests.py` | [ ] |
| 7 | CI/CD runner | Add suite to `INTEGRATION_TEST_SUITES` | [ ] |

**Failure to complete these steps will result in:**
- Endpoints returning 404 in deployed environments
- SDK clients unable to access the feature
- No integration test coverage in CI/CD
- Production Guardian blocking deployment (INT-WIRE-* failures)

---

### 8. Creating a Workflow Tool

**Location:** `src/services/{service}/entrypoints/tools/{entity}_tool.py`

**Template:**

```python
"""{Entity} Tool - LangChain tool for {entity} operations.

Wraps {Entity}Handler for AI agent workflows.
"""

from __future__ import annotations

from typing import Any, ClassVar

from langchain.tools import BaseTool
from pydantic import Field

from src.services.{service}.infrastructure.factory import get_{provider}
from src.services.{service}.service_layer.{entity}_handler import {Entity}Handler


class {Entity}Tool(BaseTool):
    """LangChain tool for {entity} operations.

    Supported actions: create, get, update, delete, list
    """

    name: ClassVar[str] = "{entity}"
    description: ClassVar[str] = (
        "Manage {entities}. Actions: create (name), get (entity_id), "
        "update (entity_id, name), delete (entity_id), list."
    )

    handler: {Entity}Handler = Field(exclude=True)

    def _run(self, **kwargs: Any) -> dict[str, Any]:
        """Synchronous execution - not implemented."""
        raise NotImplementedError("Use async version (_arun)")

    async def _arun(
        self,
        action: str = "",
        entity_id: str | None = None,
        name: str | None = None,
        limit: int = 100,
        offset: int = 0,
        **kwargs: Any,
    ) -> dict[str, Any]:
        """Execute {entity} operations asynchronously.

        Args:
            action: Operation to perform (create, get, update, delete, list)
            entity_id: ID of {entity} (for get, update, delete)
            name: Name (for create, update)
            limit: Max results for list
            offset: Skip count for list

        Returns:
            Operation result as dict
        """
        if action == "create":
            return await self._create(name=name or "")
        elif action == "get":
            return await self._get(entity_id=entity_id or "")
        elif action == "update":
            return await self._update(entity_id=entity_id or "", name=name)
        elif action == "delete":
            return await self._delete(entity_id=entity_id or "")
        elif action == "list":
            return await self._list(limit=limit, offset=offset)
        else:
            return {"success": False, "error": f"Unknown action: {action}"}

    async def _create(self, name: str) -> dict[str, Any]:
        """Create a {entity}."""
        result = await self.handler.create(name=name)
        if result.success and result.data:
            return {
                "success": True,
                "{entity}": {"id": result.data.id, "name": result.data.name},
            }
        return {"success": False, "error": result.error}

    async def _get(self, entity_id: str) -> dict[str, Any]:
        """Get a {entity}."""
        result = await self.handler.get(entity_id)
        if result.success:
            if result.data is None:
                return {"success": True, "{entity}": None}
            return {
                "success": True,
                "{entity}": {"id": result.data.id, "name": result.data.name},
            }
        return {"success": False, "error": result.error}

    async def _update(self, entity_id: str, name: str | None) -> dict[str, Any]:
        """Update a {entity}."""
        result = await self.handler.update(entity_id=entity_id, name=name)
        if result.success and result.data:
            return {
                "success": True,
                "{entity}": {"id": result.data.id, "name": result.data.name},
            }
        return {"success": False, "error": result.error}

    async def _delete(self, entity_id: str) -> dict[str, Any]:
        """Delete a {entity}."""
        result = await self.handler.delete(entity_id)
        if result.success:
            return {"success": True, "deleted": result.data}
        return {"success": False, "error": result.error}

    async def _list(self, limit: int, offset: int) -> dict[str, Any]:
        """List {entities}."""
        result = await self.handler.list(limit=limit, offset=offset)
        if result.success:
            return {
                "success": True,
                "{entities}": [
                    {"id": e.id, "name": e.name} for e in (result.data or [])
                ],
            }
        return {"success": False, "error": result.error}


def get_{entity}_tool(handler: {Entity}Handler | None = None) -> {Entity}Tool:
    """Get a {Entity}Tool instance.

    Args:
        handler: Optional handler (creates default if not provided)

    Returns:
        Configured {Entity}Tool
    """
    if handler is None:
        provider = get_{provider}()
        handler = {Entity}Handler(provider=provider)
    return {Entity}Tool(handler=handler)
```

---

## TDD Workflow (Double-Loop / Outside-In TDD)

> **CRITICAL: Integration tests are written FIRST and must be FAILING before
> you begin unit-level TDD. This is the "outer loop" of Double-Loop TDD.**

### Double-Loop TDD Overview

```
┌─────────────────────────────────────────────────────────────┐
│  OUTER LOOP: Integration Tests (This Phase)                 │
│  - Written FIRST, before any implementation                 │
│  - Run locally with InMemoryServiceAdapter (~10ms/test)     │
│  - Same tests run via SDKServiceAdapter in CI/CD            │
│  - All tests FAIL initially (expected - nothing exists yet) │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│  INNER LOOP: Unit Tests (RED → GREEN → REFACTOR)            │
│  - Traditional TDD for handlers, adapters, domain models    │
│  - When inner loop passes → outer loop should pass          │
│  - Continue until ALL integration tests are GREEN           │
└─────────────────────────────────────────────────────────────┘
```

### Step 0: Write Integration Tests FIRST (Outer Loop)

**Before writing ANY implementation code**, create integration tests.

**Location:** `src/services/{service}/service_layer/integration_testing/test_suites/{feature}_tests.py`

**Test Categories:**

| Category | ID Pattern | Source | Example |
|----------|------------|--------|---------|
| Happy Path | INT-HP-* | USER_GUIDE Getting Started | INT-HP-01: Create returns 201 |
| Alternate Path | INT-ALT-* | USER_GUIDE Reference, FAQ | INT-ALT-01: Duplicate returns 409 |
| Security | INT-SEC-* | PR_FAQ security questions | INT-SEC-01: Unauth returns 401 |
| Referential Integrity | INT-RI-* | DESIGN entity relationships | INT-RI-01: Delete parent blocked |
| Journey | INT-J-* | USER_GUIDE Common Tasks | INT-J-01: Complete onboarding |

**Template:**

```python
"""Integration tests for {feature} - run FIRST, expect FAILURES."""
from typing import TYPE_CHECKING

from src.services.platform.service_layer.integration_testing.test_orchestrator import (
    CleanupManager,
    TestSuiteResult,
    test_case,
)

if TYPE_CHECKING:
    from src.services.platform.service_layer.integration_testing.adapters.protocol import (
        TestServiceAdapter,
    )


async def {feature}_test_suite(
    service: "TestServiceAdapter",
    test_run_id: str,
    cleanup_manager: CleanupManager,
) -> TestSuiteResult:
    """Integration tests for {feature}."""
    results = []

    # INT-HP-01: Create {entity} returns success
    @test_case("INT-HP-01: Create {entity} returns success")
    async def test_create_success():
        result = await service.create_{entity}(name="test-{entity}")
        assert result is not None, "{Entity} should be created"
        cleanup_manager.register(EntityType.{ENTITY}, result.id)
        return result.id is not None

    # INT-ALT-01: Duplicate name returns conflict
    @test_case("INT-ALT-01: Duplicate name returns conflict")
    async def test_duplicate_name():
        await service.create_{entity}(name="duplicate")
        try:
            await service.create_{entity}(name="duplicate")
            return False  # Should have raised
        except Exception:
            return True  # Expected

    # INT-SEC-01: Unauthenticated request returns 401
    @test_case("INT-SEC-01: Unauthenticated returns 401")
    async def test_unauthenticated():
        # SDK mode will test this
        return True  # Memory mode skips auth

    # ... more tests

    # Execute all tests
    for test in [test_create_success, test_duplicate_name, test_unauthenticated]:
        results.append(await test())

    return build_suite_result("{feature}", results)
```

**Verify tests FAIL before proceeding:**

```bash
# Run integration tests - they should all FAIL (nothing implemented yet)
pytest src/services/{service}/service_layer/integration_testing/test_suites/{feature}_tests.py -v
# Expected: FAILURES (this is correct at this stage)
```

### Step 1: Inner Loop - RED - Write Failing Unit Test

**Every component follows RED -> GREEN -> REFACTOR:**

```python
# tests/services/{service}/service_layer/test_{entity}_handler.py
import pytest

from src.services.{service}.infrastructure.memory_{provider} import Memory{Provider}
from src.services.{service}.service_layer.{entity}_handler import {Entity}Handler


@pytest.fixture
def provider() -> Memory{Provider}:
    """Fresh provider for each test."""
    return Memory{Provider}()


@pytest.fixture
def handler(provider: Memory{Provider}) -> {Entity}Handler:
    """Handler with test provider."""
    return {Entity}Handler(provider=provider)


class Test{Entity}HandlerCreate:
    """Tests for {entity} creation."""

    @pytest.mark.asyncio
    async def test_create_{entity}_success(self, handler: {Entity}Handler):
        """Should create a {entity} with valid input."""
        result = await handler.create(name="test-{entity}")

        assert result.success is True
        assert result.data is not None
        assert result.data.name == "test-{entity}"
        assert result.error is None

    @pytest.mark.asyncio
    async def test_create_{entity}_empty_name_fails(self, handler: {Entity}Handler):
        """Should fail with empty name."""
        result = await handler.create(name="")

        assert result.success is False
        assert result.error is not None
        assert "empty" in result.error.lower() or "cannot" in result.error.lower()


class Test{Entity}HandlerGet:
    """Tests for {entity} retrieval."""

    @pytest.mark.asyncio
    async def test_get_{entity}_success(self, handler: {Entity}Handler):
        """Should get existing {entity}."""
        # Create first
        create_result = await handler.create(name="test")
        entity_id = create_result.data.id

        # Get
        result = await handler.get(entity_id)

        assert result.success is True
        assert result.data is not None
        assert result.data.id == entity_id

    @pytest.mark.asyncio
    async def test_get_{entity}_not_found(self, handler: {Entity}Handler):
        """Should return None for non-existent {entity}."""
        result = await handler.get("non-existent-id")

        assert result.success is True
        assert result.data is None
```

### Step 2: GREEN - Make Test Pass

Implement minimum code to pass the test. Don't optimize yet.

### Step 3: REFACTOR - Clean Up

- Remove duplication
- Improve naming
- Extract helper methods
- Ensure all tests still pass

---

## Authorization Integration

**Handler-level authorization is REQUIRED for all operations.**

### The `_check_permission()` Helper Pattern

Every handler MUST implement a `_check_permission()` helper that:

1. **Catches `PermissionDenied` specifically** - Not generic `Exception`
2. **Logs denials** - Structured warning logs for security auditing
3. **Handles `None` auth_service** - Allows testing without auth
4. **Returns error string** - Compatible with Result/Action patterns

**Why this pattern exists:**
- `AuthorizationService.check_permission()` throws `PermissionDenied` exceptions
- Handlers use `Result.fail(error_string)` or `action.set_error(error_string)` patterns
- The helper adapts between these two interfaces
- Logging provides audit trail for security events

See the handler template above for the complete implementation.

### Permission Naming Convention

Format: `{domain}.{resource}:{action}`

Examples:
- `dns.zones:create` - Create DNS zones
- `certificates:provision` - Provision certificates
- `platform.users:read` - Read user details
- `{service}.{entities}:*` - All operations on {entities}

### Authorization Check Pattern

```python
async def create(
    self,
    name: str,
    user_id: str | None = None,
    platform_id: str | None = None,
) -> Result[{Entity}]:
    # Authorization check FIRST - before any business logic
    auth_result = await self._check_permission(
        "{service}.{entities}:create", user_id, platform_id
    )
    if auth_result is not None:
        return auth_result

    # THEN business logic...
```

### Test Both Allowed and Denied

```python
@pytest.mark.asyncio
async def test_create_denied_without_permission(self, handler_with_auth):
    """Should deny without permission."""
    result = await handler_with_auth.create(
        name="test",
        user_id="user-without-permission",
        platform_id="platform-123",
    )
    assert result.success is False
    assert "permission" in result.error.lower()
```

---

## Testing Patterns

> **Testing Standard:** [`methodology/standards/testing.md`](../../standards/testing.md) — Testing
> Pyramid with V-Model derivation rules (ADR-131). The adapter mode determines the test level:
> - **Unit** (`tests/unit/`): Memory adapters, handler isolation — derived from DESIGN handler logic
> - **Service Integration** (`tests/service_integration/`): Real adapters, local credentials — derived from DESIGN §10.4
> - **E2E** (`integration_testing/test_suites/`): Deployed system, SDK client — derived from USER_GUIDE
>
> A test using `MemoryRepository` is a unit test regardless of file location.

### Test File Structure

```
tests/services/{service}/
├── conftest.py                     # Service-level fixtures
├── domain/
│   └── test_{entity}_models.py     # Model validation tests
├── infrastructure/
│   ├── test_memory_{provider}.py   # Adapter tests
│   └── test_factory.py             # Factory tests
├── service_layer/
│   └── test_{entity}_handler.py    # Handler tests
└── entrypoints/
    ├── http/
    │   └── test_{entity}_router.py # Route tests
    └── tools/
        └── test_{entity}_tool.py   # Tool tests
```

### Fixture Pattern

```python
# tests/services/{service}/conftest.py
import pytest

from src.services.{service}.infrastructure.memory_{provider} import Memory{Provider}
from src.services.{service}.service_layer.{entity}_handler import {Entity}Handler


@pytest.fixture
def provider() -> Memory{Provider}:
    """Fresh in-memory provider for each test."""
    return Memory{Provider}()


@pytest.fixture
def handler(provider: Memory{Provider}) -> {Entity}Handler:
    """Handler with test provider (no auth)."""
    return {Entity}Handler(provider=provider)


@pytest.fixture(autouse=True)
def reset_factory():
    """Reset factory singletons after each test."""
    from src.services.{service}.infrastructure.factory import reset_{provider}
    yield
    reset_{provider}()
```

---

## Logging Best Practices

**All handlers and services should use structured logging for observability.**

### Import Pattern

```python
import logging
from src.shared.logger.logger import log_operation, set_context, get_logger

logger = logging.getLogger(__name__)
# Or: logger = get_logger(__name__)  # Auto-attaches context filter
```

### Operation Tracking (REQUIRED for multi-step operations)

Use `log_operation()` for any operation that involves external calls or multiple steps:

```python
from src.shared.logger.logger import log_operation

async def delete_platform(self, platform_id: str) -> Result:
    """Delete platform with full operation tracking."""

    # Wraps entire operation with start/end/error logging + timing
    with log_operation("delete_platform", platform_id=platform_id):
        # Delete tenant
        with log_operation("delete_tenant", tenant_id=tenant_id):
            await self._tenant_provider.delete(tenant_id)

        # Delete storage
        with log_operation("delete_storage", bucket_id=bucket_id):
            await self._storage_provider.delete(bucket_id)

        # Delete platform record
        await self._repository.delete(platform_id)

    return Result.ok(True)
```

**Output (in Cloud Logging):**
```json
{"severity": "INFO", "message": "Starting delete_platform", "operation": "delete_platform", "phase": "start", "platform_id": "plat-123"}
{"severity": "INFO", "message": "Starting delete_tenant", "operation": "delete_tenant", "phase": "start", "tenant_id": "tenant-456"}
{"severity": "INFO", "message": "Completed delete_tenant", "operation": "delete_tenant", "phase": "end", "duration_ms": 150.5}
{"severity": "INFO", "message": "Completed delete_platform", "operation": "delete_platform", "phase": "end", "duration_ms": 320.2}
```

### Structured Logging (REQUIRED - no string formatting)

```python
# WRONG: String formatting loses structure
logger.info(f"Deleting platform {platform_id} for user {user_id}")

# CORRECT: Structured extra fields (searchable in Cloud Logging)
logger.info(
    "Deleting platform",
    extra={
        "platform_id": platform_id,
        "user_id": user_id,
        "operation": "delete_platform",
    }
)
```

### Request Context (Set in Middleware)

The middleware sets context automatically. For manual setting:

```python
from src.shared.logger.logger import set_context, clear_context

# Set at request start
set_context(
    request_id=request_id,
    platform_id=platform_id,
    user_id=user_id,
)

# All subsequent logs in this request include context automatically
logger.info("Processing")  # Includes request_id, platform_id, user_id

# Clear at request end (in finally block)
clear_context()
```

### Log Levels

| Level | When to Use |
|-------|------------|
| `DEBUG` | Detailed debugging info (disabled in prod) |
| `INFO` | Normal operations, state changes |
| `WARNING` | Recoverable issues, deprecations |
| `ERROR` | Failures that need attention |
| `CRITICAL` | System-wide failures |

### Anti-Patterns

```python
# WRONG: Logging with Rich markup (broken in Cloud Run)
logger.info(f"[cyan]{platform_id}[/cyan] deleted")

# WRONG: Multi-line log messages (split in Cloud Logging)
logger.info(f"Platform details:\nID: {id}\nName: {name}")

# WRONG: Logging sensitive data
logger.info(f"User authenticated with token {token}")

# CORRECT: Use extra fields, single line, no secrets
logger.info("Platform deleted", extra={"platform_id": id, "name": name})
```

### Handler Logging Template

```python
class {Entity}Handler:
    """Handler with proper logging."""

    def __init__(self, provider, auth_service=None):
        self._provider = provider
        self._auth_service = auth_service
        self._logger = logging.getLogger(__name__)

    async def delete(self, entity_id: str, user_id: str = None) -> Result:
        """Delete with operation tracking."""
        with log_operation("delete_{entity}", entity_id=entity_id, user_id=user_id):
            # Auth check
            auth_error = await self._check_permission(...)
            if auth_error:
                self._logger.warning(
                    "Permission denied",
                    extra={"entity_id": entity_id, "user_id": user_id}
                )
                return Result.fail(auth_error)

            # Business logic
            try:
                deleted = await self._provider.delete(entity_id)
                return Result.ok(deleted)
            except Exception as e:
                self._logger.error(
                    "Delete failed",
                    extra={"entity_id": entity_id, "error": str(e)},
                    exc_info=True,
                )
                return Result.fail(f"Failed to delete: {e}")
```

---

## Infrastructure Reconciliation

> **REQUIRED** when implementing features that create external infrastructure.
> See `architecture/patterns/INFRASTRUCTURE_RECONCILIATION.md` for full pattern.

### When This Applies

If your feature creates, modifies, or depends on:
- Identity Platform tenants
- Storage buckets (GCS)
- DNS zones / records
- SSL certificates
- Load balancers
- Any other cloud resources

### Required Components

Every feature with external infrastructure must implement:

```
┌─────────────────────────────────────────────────────────────────┐
│                 INFRASTRUCTURE LIFECYCLE CONTRACT               │
├─────────────────────────────────────────────────────────────────┤
│  CREATE     READ        DELETE       RECONCILE                  │
│  ───────    ────        ──────       ─────────                  │
│  Provision  Verify      Cleanup      Detect & fix drift         │
│  + Store    exists      + Remove                                │
│  domain ref             domain ref                              │
└─────────────────────────────────────────────────────────────────┘
```

### Provider Port Requirements

```python
class {Resource}Provider(Protocol):
    """Provider must support full lifecycle + reconciliation."""

    async def create_{resource}(self, ...) -> {Resource}:
        """Create resource and return details."""
        ...

    async def get_{resource}(self, resource_id: str) -> {Resource} | None:
        """Get resource, return None if not found."""
        ...

    async def delete_{resource}(self, resource_id: str) -> None:
        """Delete resource."""
        ...

    async def list_{resources}(self) -> list[{Resource}]:
        """List ALL resources (for reconciliation)."""
        ...
```

### ReconciliationHandler Pattern

Add resource type to existing ReconciliationHandler:

```python
# In reconciliation_handler.py

async def _find_orphaned_{resources}(self) -> list[OrphanedResource]:
    """Find {resources} with no parent in domain model."""
    if not self._{resource}_provider:
        return []

    # Get all from infrastructure
    all_{resources} = await self._{resource}_provider.list_{resources}()

    # Get all from domain model
    domain_refs = await self._get_domain_{resource}_refs()

    # Find orphans
    orphans = []
    for r in all_{resources}:
        if r.id not in domain_refs:
            orphans.append(OrphanedResource(
                resource_type=ResourceType.{RESOURCE},
                resource_id=r.id,
                reason=OrphanReason.NO_PARENT,
            ))
    return orphans
```

### Required Tests (TS-R01 to TS-R05)

```python
@pytest.mark.asyncio
async def test_detect_orphaned_{resource}(handler, provider):
    """TS-R01: Orphaned {resource} detected."""
    # Create resource without domain ref (orphan)
    resource_id = await provider.create_{resource}(...)

    # Detect orphan
    orphans, _ = await handler.list_orphaned_resources()
    assert any(o.resource_id == resource_id for o in orphans)


@pytest.mark.asyncio
async def test_cleanup_dry_run(handler, orphan_id):
    """TS-R02: Dry run previews but doesn't delete."""
    results, _ = await handler.cleanup_resources([orphan_id], dry_run=True)
    assert results[0].status == CleanupResultStatus.SKIPPED


@pytest.mark.asyncio
async def test_cleanup_execute(handler, provider, orphan_id):
    """TS-R03: Execute actually deletes orphan."""
    results, _ = await handler.cleanup_resources([orphan_id], dry_run=False)
    assert results[0].status == CleanupResultStatus.DELETED
    assert await provider.get_{resource}(orphan_id) is None


@pytest.mark.asyncio
async def test_protected_resource_blocked(handler, root_resource_id):
    """TS-R04: Protected resources cannot be deleted."""
    results, _ = await handler.cleanup_resources([root_resource_id], dry_run=False)
    assert results[0].status == CleanupResultStatus.FAILED
    assert results[0].failure_reason == CleanupFailureReason.PROTECTED_RESOURCE


@pytest.mark.asyncio
async def test_missing_resource_detected(handler, platform_with_bad_ref):
    """TS-R05: Missing infrastructure detected in report."""
    report = await handler.generate_report(project_id)
    assert platform_with_bad_ref.id in [
        p["platform_id"] for p in report.platforms_missing_resources
    ]
```

### TDD Workflow Extended

```
Standard TDD:     RED → GREEN → REFACTOR
With Infra:       RED → GREEN → REFACTOR → RECONCILE

RECONCILE phase (after REFACTOR):
1. Add orphan detection test (TS-R01)
2. Add cleanup dry-run test (TS-R02)
3. Add cleanup execute test (TS-R03)
4. Add protected resource test (TS-R04)
5. Add missing resource test (TS-R05)
6. Update ReconciliationHandler for new resource type
```

---

## Infrastructure IAM Permissions (Terraform)

> **REQUIRED** when implementing features that require GCP API access.
> All IAM permissions must be codified in Terraform - never manually set in console.

### Why Codify Permissions

1. **Reproducibility** - Permissions are version-controlled and auditable
2. **Consistency** - Same permissions across all environments
3. **Self-healing** - Terraform can detect and fix drift
4. **Documentation** - Code IS documentation
5. **Debugging** - Clear mapping from feature → required permissions

### Permission Requirements by Provider

When implementing a GCP provider, document and add required IAM permissions:

| Provider | Terraform Location | Required Roles |
|----------|-------------------|----------------|
| GCPTenantProvider | `environments/dev/main.tf` | `roles/identityplatform.admin`, `roles/firebaseauth.admin` |
| GCSObjectStorageProvider | `environments/dev/main.tf` | `roles/storage.admin` |
| GCPCloudRunClient | `environments/dev/main.tf` | `roles/run.admin`, `roles/iam.serviceAccountUser` |
| GCPCloudDNSProvider | `environments/dev/main.tf` | `roles/dns.admin` |
| GCPCertificateProvider | `environments/dev/main.tf` | `roles/certificatemanager.editor` |
| GCPLoadBalancerProvider | `environments/dev/main.tf` | `roles/compute.loadBalancerAdmin` |

### Adding Permissions Workflow

When adding a new GCP provider:

```
1. Identify API calls → Determine required permissions
2. Find least-privilege IAM role → Or create custom role
3. Add to Terraform → infrastructure/terraform/environments/dev/main.tf
4. Document in code → Comments explaining what each permission enables
5. Apply via CI/CD → Terraform runs on push to main
```

### Terraform Pattern

```hcl
# infrastructure/terraform/environments/dev/main.tf

# Cloud Run Service Account (used by all deployed services)
resource "google_service_account" "cloudrun_sa" {
  account_id   = "${var.service_name}-${var.environment}"
  display_name = "Cloud Run Service Account (${var.environment})"
  project      = var.project_id
}

# Grant {Service} Admin for {feature description}
# Required for: {list of API calls/methods}
resource "google_project_iam_member" "cloudrun_{service}_admin" {
  project = var.project_id
  role    = "roles/{service}.admin"
  member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}
```

### Complete Permission Set (Dev Environment)

The Cloud Run service account needs these roles for full platform functionality:

```hcl
# Core data services
roles/datastore.user           # Firestore database access
roles/secretmanager.admin      # Secret Manager operations

# Identity & Authentication
roles/identityplatform.admin   # Identity Platform tenant operations
roles/firebaseauth.admin       # Firebase Auth user management

# Storage
roles/storage.admin            # Cloud Storage bucket management

# Compute & Networking
roles/run.admin                # Cloud Run service deployment
roles/dns.admin                # Cloud DNS zone management
roles/certificatemanager.editor # SSL certificate provisioning
roles/compute.loadBalancerAdmin # HTTPS load balancer management
roles/iam.serviceAccountUser   # Service account impersonation
```

### Debugging Permission Errors

When you see "Permission denied" errors:

1. **Check Cloud Run logs** - Look for specific permission error
2. **Identify the API call** - Which provider method failed?
3. **Find required permission** - Check GCP docs for the API
4. **Verify Terraform state** - `terraform plan` shows current bindings
5. **Add missing permission** - Update main.tf with new IAM binding
6. **Apply changes** - Push to trigger Terraform apply

### Common Permission Errors

| Error | Missing Permission | Solution |
|-------|-------------------|----------|
| `PERMISSION_DENIED: identitytoolkit` | `roles/identityplatform.admin` | Add IAM binding for Identity Platform |
| `403 storage.buckets.create` | `roles/storage.admin` | Add Storage Admin role |
| `Caller does not have permission 'run.services.create'` | `roles/run.admin` | Add Cloud Run Admin role |
| `Permission 'dns.managedZones.create' denied` | `roles/dns.admin` | Add DNS Admin role |

### Least Privilege Considerations

For production environments, consider custom roles instead of broad admin roles:

```hcl
# Custom role with only needed permissions
resource "google_project_iam_custom_role" "platform_tenant_manager" {
  role_id     = "platformTenantManager"
  title       = "Platform Tenant Manager"
  description = "Manages Identity Platform tenants for platforms"
  permissions = [
    "identitytoolkit.tenants.create",
    "identitytoolkit.tenants.delete",
    "identitytoolkit.tenants.get",
    "identitytoolkit.tenants.list",
    "identitytoolkit.tenants.update",
  ]
}
```

### CI/CD Service Account

The GitHub Actions service account needs permission to deploy:

```hcl
# In a separate Terraform config or manually set
roles/run.admin               # Deploy Cloud Run services
roles/storage.admin           # Push to Artifact Registry
roles/iam.serviceAccountUser  # Use Cloud Run service account
```

---

## Ontology Integration with @operation Decorator

> **CRITICAL:** All handler methods must use the `@operation` decorator for LLM discoverability.
> See `methodology standards/ONTOLOGY_SPECIFICATION.md` for the complete specification.

### When to Use @operation

**Required for:**
- All handler methods that perform CRUD operations
- All methods that cause state transitions
- All methods exposed via HTTP or SDK

**Not required for:**
- Internal helper methods (prefix with `_`)
- Factory functions
- Test fixtures

### @operation Decorator Template

```python
from src.core.ontology import (
    operation,
    UserGuide,
    AudienceType,
    OperationLink,
    StateTransitionEffect,
)

class {Entity}Handler:
    """Handler with ontology-aware operations."""

    @operation(
        name="Create {Entity}",
        description="Create a new {entity} instance",
        permissions=["{service}.{entities}:create"],
        errors=["VALIDATION_ERROR", "DUPLICATE_NAME"],
        audiences=[AudienceType.ADMIN, AudienceType.CONSUMER],
        user_guide=UserGuide(
            summary="Creates a new {entity} in the platform",
            when_to_use="When onboarding a new {entity}",
            prerequisites=["Valid authentication", "{entity} name"],
            next_steps=["Configure settings", "Assign permissions"],
        ),
        # HATEOAS-style navigation
        leads_to=[
            OperationLink(
                target_operation="{entity}/update",
                relation="next",
                description="Configure {entity} settings",
            ),
            OperationLink(
                target_operation="{entity}/get",
                relation="related",
                description="View {entity} details",
            ),
        ],
        # State transition effects
        causes_transition=StateTransitionEffect(
            entity="{Entity}",
            to_state="active",
        ),
    )
    async def create(
        self,
        name: str,
        user_id: str | None = None,
        platform_id: str | None = None,
    ) -> Result[{Entity}]:
        """Create a new {entity}."""
        # Authorization check FIRST
        auth_error = await self._check_permission(
            "{service}.{entities}:create", user_id, platform_id
        )
        if auth_error is not None:
            return Result.fail(auth_error)
        # ... implementation
```

### Required @operation Fields

| Field | Required | Purpose |
|-------|----------|---------|
| `name` | Yes | Human-readable operation name |
| `description` | Yes | What this operation does |
| `permissions` | Yes | List of required permissions |
| `errors` | Yes | Error codes this operation can produce |
| `audiences` | No | Who can see this operation (defaults to ADMIN) |
| `user_guide` | Yes* | LLM guidance (* for consumer-facing ops) |
| `leads_to` | Yes | HATEOAS navigation links |
| `causes_transition` | If applicable | State transitions caused by operation |

### Entity Lifecycle Registration

For entities with state transitions, register the lifecycle:

```python
from src.core.ontology import EntityLifecycle, StateTransition, WorkflowRegistry

{ENTITY}_LIFECYCLE = EntityLifecycle(
    entity="{Entity}",
    states=["active", "suspended", "archived", "deleted"],
    initial="active",
    final=["deleted"],
    transitions=[
        StateTransition(
            from_state="active",
            to_state="suspended",
            trigger="{entity}/suspend",
            permissions=["{service}.{entities}:admin"],
            description="Temporarily suspend the {entity}",
        ),
        StateTransition(
            from_state="active",
            to_state="archived",
            trigger="{entity}/archive",
            permissions=["{service}.{entities}:update"],
            description="Archive the {entity}",
        ),
        # ... all transitions
    ],
)

# Register in module initialization
workflow_registry.register_lifecycle({ENTITY}_LIFECYCLE)
```

### Error Catalog Registration

Register all error codes with user-facing actions:

```python
from src.core.ontology.types import ErrorDefinition

{SERVICE}_ERRORS = [
    ErrorDefinition(
        code="VALIDATION_ERROR",
        http_status=400,
        message="Invalid input provided",
        user_action="Check input values against the schema requirements",
        retryable=False,
    ),
    ErrorDefinition(
        code="NOT_FOUND",
        http_status=404,
        message="{Entity} not found",
        user_action="Verify the {entity} ID exists",
        retryable=False,
    ),
    ErrorDefinition(
        code="DUPLICATE_NAME",
        http_status=409,
        message="{Entity} with this name already exists",
        user_action="Choose a different name or update the existing {entity}",
        retryable=False,
    ),
]

# Register with ontology registry
ontology_registry.register_handler(
    {Entity}Handler,
    service_name="{service}",
    errors={SERVICE}_ERRORS,
)
```

### Ontology TDD Pattern

When implementing handlers with ontology:

```
1. [TEST] Write test for @operation metadata extraction
2. [IMPL] Add @operation decorator with all fields
3. [TEST] Write test for lifecycle registration
4. [IMPL] Define EntityLifecycle
5. [TEST] Write test for error catalog completeness
6. [IMPL] Register error definitions
7. [REFACTOR] Verify ontology export includes all metadata
```

---

## Implementation & Verification Specification (IVS) Reference

> **CRITICAL:** Before implementing any feature, read the IVS document at
> `features/{feature}/IVS.md`. This document specifies:
>
> 1. **How to implement** - Port-to-API mapping, error handling, retry policies
> 2. **How to verify** - Security, observability, reliability requirements
> 3. **Production readiness criteria** - What the Production Guardian will check

### Using IVS During Development

**Before Starting:**
1. Read `IVS.md` Section 1 (Infrastructure Integration)
2. Read `IVS.md` Section 2 (Port-to-Implementation Mapping)
3. Understand error mapping and retry policies

**During Implementation:**
1. Follow the port-to-API mapping exactly
2. Implement error handling per IVS error mapping table
3. Add logging per OBS-LOG-* requirements
4. Add metrics per OBS-MET-* requirements

**Before Completing:**
1. Verify all SEC-* security requirements are met
2. Verify all REL-* reliability requirements are met
3. Update implementation status in IVS.md (Complete/Partial/Stub)

### IVS Verification Requirements

Each requirement in IVS has a test reference. Ensure you create these tests:

| Requirement Pattern | Test Location | Example |
|---------------------|---------------|---------|
| SEC-AUTH-* | `tests/verification/security/` | `test_sec_auth_required` |
| SEC-AUTHZ-* | `tests/verification/security/` | `test_sec_permission_check` |
| OBS-LOG-* | `tests/verification/observability/` | `test_obs_log_format` |
| REL-ERR-* | `tests/verification/reliability/` | `test_rel_error_handling` |

### Production Guardian Review

After implementation is complete, the Production Guardian agent will:
1. Review ALL changed files against IVS.md
2. Verify each SEC-*, OBS-*, REL-* requirement
3. Check for stubbed methods in production code path
4. Produce APPROVED / BLOCKED / CONDITIONAL decision

**BLOCKED means you must fix issues before deployment.**

---

## Important Rules

### Non-Negotiable

1. **TDD Always** - Write failing test first, then implement
2. **Handler = Single Source of Truth** - Never put business logic in routes or tools
3. **Authorization First** - Check permissions before ANY business logic
4. **In-Memory First** - Always implement memory adapter for testing
5. **Async Everything** - All port methods must be async
6. **Result Pattern** - Handlers return `Result[T]`, not exceptions
7. **Ports as Protocols** - Use `@runtime_checkable` Protocol classes
8. **Factory Singletons** - Use get/set/reset pattern for test isolation
9. **Reference IVS** - Always check IVS.md for implementation specs
10. **No Undocumented Stubs** - If a method is stubbed, document in IVS.md
11. **Structured Logging** - Use `log_operation()` for multi-step ops, `extra={}` for context

### File Locations

| Component | Location |
|-----------|----------|
| Domain Models | `src/services/{service}/domain/models/` |
| Ports | `src/services/{service}/domain/ports/` |
| Actions | `src/services/{service}/domain/actions/` |
| Memory Adapters | `src/services/{service}/infrastructure/` |
| Factory | `src/services/{service}/infrastructure/factory.py` |
| Handlers | `src/services/{service}/service_layer/` |
| HTTP Routes | `src/services/{service}/entrypoints/http/` |
| Workflow Tools | `src/services/{service}/entrypoints/tools/` |

---

## Anti-Patterns to Avoid

### Business Logic in Routes

```python
# WRONG: Business logic in router
@router.post("/entities")
async def create(request: Request):
    entity = Entity(name=request.name)
    await firestore.set(entity)  # Direct infrastructure!

# CORRECT: Delegate to handler
@router.post("/entities")
async def create(request: Request, handler = Depends(get_handler)):
    result = await handler.create(name=request.name)
```

### Direct Infrastructure Imports

```python
# WRONG: Infrastructure in domain
from google.cloud import firestore  # NEVER in domain layer

# CORRECT: Use ports
from src.services.{service}.domain.ports.{provider} import {Provider}
```

### Mocking Instead of In-Memory

```python
# WRONG: Mocking infrastructure
@patch('google.cloud.firestore.Client')
def test_create(mock_client):
    pass  # Mock doesn't validate real behavior

# CORRECT: Use in-memory implementation
def test_create(handler):  # handler uses Memory{Provider}
    result = await handler.create(...)  # Real code, memory backend
```

### Skipping Authorization

```python
# WRONG: No authorization check
async def create(self, name: str) -> Result:
    entity = Entity(name=name)  # Starts business logic immediately
    return Result.ok(await self._provider.create(entity))

# CORRECT: Authorization first
async def create(self, name: str, user_id=None, platform_id=None) -> Result:
    auth_result = await self._check_permission(...)  # FIRST
    if auth_result is not None:
        return auth_result
    # THEN business logic
```

---

## Quick Reference

### Creating a New Entity (Full Stack)

1. `domain/models/{entity}.py` - Domain model with Pydantic
2. `domain/ports/{provider}.py` - Protocol interface
3. `infrastructure/memory_{provider}.py` - In-memory adapter
4. `infrastructure/factory.py` - Add get/set/reset functions
5. `service_layer/{entity}_handler.py` - Handler with Result pattern
6. `entrypoints/http/{entity}_router.py` - FastAPI routes
7. `entrypoints/tools/{entity}_tool.py` - LangChain tool
8. Tests for each component (TDD)

### Adding an Operation to Existing Entity

1. Add method to Port (if new data operation)
2. Implement in Memory Adapter
3. Add handler method with authorization
4. Add route/tool method
5. Write tests (TDD)
