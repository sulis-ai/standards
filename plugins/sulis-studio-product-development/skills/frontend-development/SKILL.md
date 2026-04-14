---
name: frontend-development
description: |
  Guide frontend development following Sulis design system, component patterns,
  accessibility standards, and experience vision. Counterpart to backend-development skill.

  TRIGGER KEYWORDS: frontend, component, page, react, tsx, tailwind, shadcn, ui,
  design tokens, accessibility, a11y, responsive, layout, state management,
  create component, add page, new view, implement UI, style, css, design system.

  USE WHEN:
  - Creating a new frontend component, page, or layout
  - Implementing UI from DESIGN.md frontend-web scope
  - Applying design tokens or HIG component specifications
  - Working with accessibility requirements
  - Building agentic interface patterns
  - Working in apps/web/src/ directories
  - User says: "create component", "add page", "implement UI", "style this"

  PATTERNS: Component-driven, Design Token consumption, Accessibility-first, Testing Library + Playwright.
allowed-tools: Bash, Read, Edit, Write, Glob, Grep
---

# Frontend Development Guide

> **PORTABILITY NOTE:** This skill contains project-specific patterns (directory layout,
> component conventions, design system references). When using this plugin outside the Sulis
> monorepo, adapt the directory paths and patterns to match your project's `scope-profile.yaml`
> and design system. The accessibility standards and testing patterns are universal; the
> implementation patterns are reference examples.

Guide for creating frontend components that comply with design system, accessibility standards, and experience vision.

## When to Use

This skill should be invoked when:
- **Creating a new frontend component, page, or layout**
- **Implementing UI from a feature's DESIGN.md frontend-web scope**
- **Applying design tokens or HIG component specifications**
- **Working with accessibility requirements (WCAG AA)**
- **Building agentic interface patterns (AI-powered interactions)**
- **Working in these directories:**
  - `apps/web/src/components/` - Reusable UI components
  - `apps/web/src/pages/` - Page-level components and routing
  - `apps/web/src/layouts/` - Layout shells and navigation
  - `apps/web/src/state/` - State management modules
  - `apps/web/src/styles/` - Style definitions and token consumption
  - `apps/web/src/utils/` - Frontend utilities

---

## Required Reading

Before implementing, read these documents:

1. **`product/design/HIG.md`** - Component specifications, interaction states, focus management, loading states
   - Section 2: Component Specifications (variants, sizes, states)
   - Section 4: Focus Management (tab order, focus trapping, restoration)
   - Section 5: Loading States (skeleton, spinner, progressive)

2. **`product/design/DESIGN_TOKENS.json`** - Three-tier token system (primitive, semantic, component)
   - Primitive tier: Raw values (never use directly in components)
   - Semantic tier: Context-meaningful tokens (use in components)
   - Component tier: Component-specific overrides (use in component implementations)

3. **`product/design/STYLE_GUIDE.md`** - UI text patterns, tone by severity, content principles
   - Error messages, empty states, confirmation dialogs
   - Tone-by-severity rules (info, warning, error, critical)

4. **`product/design/USAGE_GUIDELINES.md`** - Component usage rules and anti-patterns
   - When to use which component variant
   - Composition rules and prohibited combinations

5. **`methodology/standards/accessibility-wcag-aa.md`** - WCAG AA baseline
   - Contrast, keyboard, focus, ARIA, colour independence requirements

6. **Feature's DESIGN.md "Design Context" section** - Pre-resolved design context for the current feature
   - Design System Mapping (which tokens, HIG components, style guide references apply)
   - Experience Context (relevant journeys, IA sections, surface constraints, persona needs)
   - Accessibility Requirements (WCAG AA requirements specific to this feature's interactions)
   - Agentic Interface Patterns (if feature involves AI interaction)
   - Implementation References (file paths to load per-task)

---

## Architecture Overview

Sulis frontend follows **Component-Driven Architecture** with **Design Token Consumption**:

```
                      PAGES
    (Route Components)    (Layouts)
          |                  |
          +--------+---------+
                   |
                   v
    +--------------------------------------+
    |       COMPOSED COMPONENTS            |
    |  - Feature-specific compositions     |
    |  - Connected to state                |
    |  - Handle data fetching              |
    +------------------+-------------------+
                       |
    +------------------v-------------------+
    |       BASE COMPONENTS                |
    |  - Design system primitives          |
    |  - Token-consuming, accessible       |
    |  - Stateless, reusable               |
    +------------------+-------------------+
                       |
    +------------------v-------------------+
    |       DESIGN TOKENS + STYLES         |
    |  - Primitive -> Semantic -> Component |
    |  - Never hardcode values              |
    |  - Source: DESIGN_TOKENS.json         |
    +--------------------------------------+
```

**Key Principles:**
1. **Component-driven** - Build from smallest composable units up
2. **Token consumption** - Never hardcode colours, spacing, typography; always use semantic tokens
3. **Accessibility-first** - ARIA roles, keyboard navigation, focus management in every component
4. **State colocation** - State lives closest to where it is consumed
5. **Error boundaries** - Every page has an error boundary; components fail gracefully
6. **TDD always** - RED -> GREEN -> REFACTOR for all frontend code

## Component Decision Tree

**What are you building?**

```
START
  |
  +-> "I need a new reusable UI element"
  |     -> Create: Base Component (tokens + ARIA + tests)
  |
  +-> "I need a feature-specific UI composition"
  |     -> Create: Composed Component (base components + state + tests)
  |
  +-> "I need a new route/view"
  |     -> Create: Page Component (layout + composed components + error boundary + tests)
  |
  +-> "I need a new page shell or navigation structure"
  |     -> Create: Layout Component (navigation + slot + responsive + tests)
  |
  +-> "I need to manage shared state"
  |     -> Create: State Module (store + selectors + actions + tests)
  |
  +-> "I need to style an existing component differently"
        -> Use: Design Tokens (semantic tier, component tier overrides)
```

**Order of implementation (Double-Loop TDD):**

```
+-------------------------------------------------------------+
|  OUTER LOOP: Integration Tests (write FIRST, all FAILING)    |
|  Component rendering, user flows, accessibility audits        |
|  Run locally with React Testing Library + jest-axe            |
+-------------------------------------------------------------+
                              |
+-------------------------------------------------------------+
|  INNER LOOP: Unit TDD (RED -> GREEN -> REFACTOR)             |
|  Base Component -> Composed Component -> Page -> Layout       |
|  Continue until outer loop tests pass                         |
+-------------------------------------------------------------+
```

---

## Component Patterns

| Pattern | Description | Reference |
|---------|-------------|-----------|
| Component-Driven | Build from smallest composable units up | HIG Section 2 Component Specifications |
| Token Consumption | Never hardcode colours, spacing, typography -- always use semantic tokens | DESIGN_TOKENS.json semantic tier |
| Accessibility-First | ARIA roles, keyboard navigation, focus management in every component | accessibility-wcag-aa.md, HIG Section 4 Focus Management |
| State Colocation | State lives closest to where it is consumed | React conventions |
| Error Boundaries | Every page has an error boundary; components fail gracefully | HIG Section 5 Loading States |

### Base Component Template

```tsx
/**
 * {ComponentName} - {Brief description}.
 *
 * Follows HIG Section 2 specifications for {component category}.
 * Consumes semantic tokens from DESIGN_TOKENS.json.
 */

import { forwardRef } from "react";
import type { ComponentPropsWithRef } from "react";

// Token-based styling (never hardcode values)
import { cn } from "@/utils/cn";

interface {ComponentName}Props extends ComponentPropsWithRef<"div"> {
  /** Variant per HIG specification */
  variant?: "primary" | "secondary" | "ghost";
  /** Size per HIG specification */
  size?: "sm" | "md" | "lg";
  /** Accessible label (required when no visible text) */
  "aria-label"?: string;
}

export const {ComponentName} = forwardRef<HTMLDivElement, {ComponentName}Props>(
  ({ variant = "primary", size = "md", className, children, ...props }, ref) => {
    return (
      <div
        ref={ref}
        role="{appropriate-role}"
        className={cn(
          // Base styles using semantic tokens
          "rounded-md border transition-colors",
          // Variant styles
          variant === "primary" && "bg-surface-primary border-border-default",
          variant === "secondary" && "bg-surface-secondary border-border-subtle",
          variant === "ghost" && "bg-transparent border-transparent",
          // Size styles
          size === "sm" && "px-2 py-1 text-sm",
          size === "md" && "px-3 py-2 text-base",
          size === "lg" && "px-4 py-3 text-lg",
          // Focus visible (never outline: none)
          "focus-visible:ring-2 focus-visible:ring-ring-focus focus-visible:ring-offset-2",
          className,
        )}
        {...props}
      >
        {children}
      </div>
    );
  },
);

{ComponentName}.displayName = "{ComponentName}";
```

### Composed Component Template

```tsx
/**
 * {FeatureName}{ComponentName} - Feature-specific composition.
 *
 * Composes base components for the {feature} feature.
 * Connected to state via {state management approach}.
 */

import { {BaseComponent} } from "@/components/{base-component}";
import { use{Feature}State } from "@/state/{feature}";

interface {FeatureName}{ComponentName}Props {
  /** Entity ID to display/manage */
  entityId: string;
}

export function {FeatureName}{ComponentName}({ entityId }: {FeatureName}{ComponentName}Props) {
  const { data, isLoading, error } = use{Feature}State(entityId);

  if (isLoading) {
    return <{BaseComponent}Skeleton />;
  }

  if (error) {
    return <ErrorDisplay error={error} />;
  }

  return (
    <{BaseComponent} variant="primary">
      {/* Feature-specific composition using base components */}
    </{BaseComponent}>
  );
}
```

---

## Styling with Design Tokens

The design token system has three tiers. Using the correct tier is mandatory.

### Token Tiers

- **Primitive tokens** (`color.neutral.50`, `spacing.4`): Raw values. **Never use directly in components.** These exist for the design system to reference internally.
- **Semantic tokens** (`color.surface.primary`, `color.text.default`, `spacing.component.gap`): Context-meaningful. **Use in components.** These carry intent and adapt to themes.
- **Component tokens** (`button.background.primary`, `card.border.radius`): Component-specific. **Use in component implementations.** These override semantic tokens for specific component contexts.

### Structural Profile

The structural profile defines the application's spatial and navigational character:

- **Navigation:** sidebar (persistent left navigation)
- **Layout:** contained (1280px max-width content area)
- **Density:** comfortable (generous spacing, breathing room)
- **Elevation strategy:** border-delineated (borders distinguish layers, not shadows)

### Token Usage Rules

```tsx
// WRONG: Hardcoded values
<div style={{ color: "#1a1a1a", padding: "16px", borderRadius: "8px" }}>

// WRONG: Primitive tokens in components
<div className="text-neutral-900 p-4 rounded-lg">

// CORRECT: Semantic tokens
<div className="text-text-default p-component-padding rounded-radius-md">

// CORRECT: Component tokens for specific components
<button className="bg-button-primary text-button-primary-text rounded-button-radius">
```

### Theme Compatibility

Semantic tokens automatically adapt to light/dark themes. By using semantic tokens exclusively, components inherit theme support without additional code.

---

## Accessibility Patterns

All frontend components must meet WCAG AA. These are not optional enhancements -- they are baseline requirements enforced by `methodology/standards/accessibility-wcag-aa.md`.

| Requirement | WCAG SC | Implementation Pattern |
|-------------|---------|----------------------|
| Contrast (1.4.3) | 4.5:1 normal, 3:1 large text | Use semantic tokens -- they are pre-validated for AA contrast ratios |
| Keyboard navigable (2.1.1) | All interactive elements reachable | All interactive elements get `tabIndex`, `onKeyDown` handlers; never rely on mouse-only interactions |
| No keyboard traps (2.1.2) | User can always navigate away | Modal focus trapping must include escape key release; test with Tab + Shift+Tab |
| Focus visible (2.4.7) | Clear focus indicator | Use `focus-visible` ring from design tokens; **never** `outline: none` or `outline: 0` |
| ARIA roles (4.1.2) | Programmatic name and role | Every interactive component specifies `role`, `aria-label`, `aria-describedby` as needed |
| Colour independence (1.4.1) | Information not by colour alone | Never convey information by colour alone -- add icons, text, or patterns alongside colour |
| Error identification (3.3.1) | Errors described in text | Form errors must identify the field and describe the error in text, not just colour |
| Labels (3.3.2) | Inputs have labels | Every form input has a visible `<label>` or `aria-label`; placeholder is not a label |

### Keyboard Navigation Template

```tsx
function InteractiveComponent({ onAction, ...props }) {
  const handleKeyDown = (event: React.KeyboardEvent) => {
    switch (event.key) {
      case "Enter":
      case " ":
        event.preventDefault();
        onAction();
        break;
      case "Escape":
        // Release focus / close overlay
        break;
    }
  };

  return (
    <div
      role="button"
      tabIndex={0}
      onKeyDown={handleKeyDown}
      onClick={onAction}
      aria-label="Descriptive action label"
      className="focus-visible:ring-2 focus-visible:ring-ring-focus"
      {...props}
    />
  );
}
```

### Focus Management Template

```tsx
/**
 * Modal with proper focus trapping per HIG Section 4.
 * - Focus trapped inside modal when open
 * - Escape key closes modal
 * - Focus restored to trigger element on close
 */
function Modal({ isOpen, onClose, triggerRef, children }) {
  const firstFocusableRef = useRef<HTMLElement>(null);

  useEffect(() => {
    if (isOpen && firstFocusableRef.current) {
      firstFocusableRef.current.focus();
    }
  }, [isOpen]);

  const handleKeyDown = (event: React.KeyboardEvent) => {
    if (event.key === "Escape") {
      onClose();
      triggerRef.current?.focus(); // Restore focus
    }
  };

  if (!isOpen) return null;

  return (
    <div
      role="dialog"
      aria-modal="true"
      aria-label="Dialog title"
      onKeyDown={handleKeyDown}
    >
      {children}
    </div>
  );
}
```

---

## Testing Patterns

**TDD applies to frontend identically to backend.** Write the failing test first (RED), make it pass (GREEN), refactor (REFACTOR). The test runner comes from `scope-profile.yaml` -> `tools.test_runner`.

### Test Levels

| Level | Tool | What to Test |
|-------|------|-------------|
| Unit | React Testing Library | Component rendering, user interactions, accessibility (jest-axe) |
| Integration | React Testing Library | Multi-component flows, state management, routing |
| E2E | Playwright | User journeys, cross-browser, real API integration |
| Accessibility | jest-axe + Playwright axe | Automated WCAG AA checks on every component and page |

### Test File Structure

```
apps/web/tests/
├── components/
│   ├── {component-name}.test.tsx     # Unit: rendering, variants, interactions
│   └── {component-name}.a11y.test.tsx # Accessibility: jest-axe audit
├── pages/
│   ├── {page-name}.test.tsx          # Integration: page-level flows
│   └── {page-name}.a11y.test.tsx     # Accessibility: page-level audit
├── state/
│   └── {module-name}.test.ts         # Unit: state logic, selectors, actions
└── e2e/
    └── {journey-name}.spec.ts        # E2E: full user journeys via Playwright
```

### Unit Test Template (React Testing Library)

```tsx
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import { axe, toHaveNoViolations } from "jest-axe";
import { {ComponentName} } from "@/components/{component-name}";

expect.extend(toHaveNoViolations);

describe("{ComponentName}", () => {
  // Rendering
  it("renders with default props", () => {
    render(<{ComponentName}>Content</{ComponentName}>);
    expect(screen.getByText("Content")).toBeInTheDocument();
  });

  it("renders all variants", () => {
    const { rerender } = render(<{ComponentName} variant="primary" />);
    expect(screen.getByRole("{role}")).toHaveClass("bg-surface-primary");

    rerender(<{ComponentName} variant="secondary" />);
    expect(screen.getByRole("{role}")).toHaveClass("bg-surface-secondary");
  });

  // Interactions
  it("handles click interaction", async () => {
    const user = userEvent.setup();
    const onAction = jest.fn();

    render(<{ComponentName} onClick={onAction} />);
    await user.click(screen.getByRole("{role}"));

    expect(onAction).toHaveBeenCalledTimes(1);
  });

  it("handles keyboard interaction", async () => {
    const user = userEvent.setup();
    const onAction = jest.fn();

    render(<{ComponentName} onClick={onAction} />);
    await user.tab(); // Focus the element
    await user.keyboard("{Enter}");

    expect(onAction).toHaveBeenCalledTimes(1);
  });

  // Accessibility
  it("has no accessibility violations", async () => {
    const { container } = render(<{ComponentName}>Content</{ComponentName}>);
    const results = await axe(container);
    expect(results).toHaveNoViolations();
  });

  it("has correct ARIA attributes", () => {
    render(<{ComponentName} aria-label="Descriptive label" />);
    expect(screen.getByRole("{role}")).toHaveAttribute(
      "aria-label",
      "Descriptive label",
    );
  });
});
```

### E2E Test Template (Playwright)

```ts
import { test, expect } from "@playwright/test";
import AxeBuilder from "@axe-core/playwright";

test.describe("{Journey Name}", () => {
  test("completes the full user journey", async ({ page }) => {
    await page.goto("/{route}");

    // Step 1: User sees the page
    await expect(page.getByRole("heading", { name: "{heading}" })).toBeVisible();

    // Step 2: User interacts
    await page.getByRole("button", { name: "{action}" }).click();

    // Step 3: User sees result
    await expect(page.getByText("{expected result}")).toBeVisible();
  });

  test("meets WCAG AA accessibility standards", async ({ page }) => {
    await page.goto("/{route}");

    const accessibilityScanResults = await new AxeBuilder({ page })
      .withTags(["wcag2a", "wcag2aa"])
      .analyze();

    expect(accessibilityScanResults.violations).toEqual([]);
  });

  test("works with keyboard-only navigation", async ({ page }) => {
    await page.goto("/{route}");

    // Tab to interactive element
    await page.keyboard.press("Tab");
    const focused = page.locator(":focus");
    await expect(focused).toBeVisible();

    // Activate with Enter
    await page.keyboard.press("Enter");
    await expect(page.getByText("{expected result}")).toBeVisible();
  });
});
```

### Double-Loop TDD Workflow

```
1. [OUTER] Write integration/E2E test for the user-facing behaviour -> FAILING
2. [INNER] Write unit test for base component -> FAILING (RED)
3. [INNER] Implement base component -> PASSING (GREEN)
4. [INNER] Refactor base component -> PASSING (REFACTOR)
5. [INNER] Write unit test for composed component -> FAILING (RED)
6. [INNER] Implement composed component -> PASSING (GREEN)
7. [INNER] Refactor composed component -> PASSING (REFACTOR)
8. [OUTER] Verify integration/E2E test -> PASSING
9. [A11Y]  Run jest-axe + Playwright axe -> PASSING
```

---

## Relationship to Backend-Development Skill

| Aspect | backend-development | frontend-development |
|--------|-------------------|---------------------|
| Architecture | Handler-centric, Ports & Adapters | Component-driven, Token consumption |
| Source of truth | `architecture/ARCHITECTURE.md` | `product/design/HIG.md`, `DESIGN_TOKENS.json` |
| Testing | pytest, memory adapters | React Testing Library, Playwright, jest-axe |
| Standards | PS-01 to PS-10 (product function) | accessibility-wcag-aa.md, DESIGN_VALIDATION_STANDARD.md |
| Directory | `apps/api/src/` | `apps/web/src/` |
| State management | Handler = single source of truth | State colocation, store modules |
| Error handling | Result pattern (`Result[T]`) | Error boundaries, error display components |
| Authorization | Handler-level `_check_permission()` | API client handles auth; UI shows/hides based on permissions |
| Infrastructure | Ports & Adapters (memory/firestore) | API client abstracts backend; no direct infrastructure |

---

## Important Rules

### Non-Negotiable

1. **TDD Always** - Write failing test first, then implement
2. **Semantic Tokens Only** - Never hardcode colours, spacing, or typography values
3. **Accessibility Baseline** - Every component meets WCAG AA; jest-axe on every component test
4. **Keyboard Navigable** - Every interactive element reachable and operable via keyboard
5. **Focus Visible** - Never `outline: none`; always use `focus-visible` ring from tokens
6. **Error Boundaries** - Every page wrapped in an error boundary
7. **HIG Compliance** - Component variants, sizes, and states match HIG specifications
8. **Design Context First** - Read the feature's DESIGN.md Design Context section before implementing

### Anti-Patterns to Avoid

```tsx
// WRONG: Hardcoded colour values
<div style={{ color: "#1a1a1a" }}>

// WRONG: Primitive tokens in components
<div className="text-neutral-900">

// WRONG: Removing focus outline
<button className="outline-none focus:outline-none">

// WRONG: Mouse-only interaction
<div onClick={handler}> {/* No keyboard support */}

// WRONG: Colour-only information
<span className="text-red-500">Error</span> {/* No icon or prefix text */}

// WRONG: Placeholder as label
<input placeholder="Email" /> {/* No <label> or aria-label */}

// WRONG: Business logic in components
function UserList() {
  const users = await fetch("/api/users"); // Direct API call in render
}
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-03-19 | Initial creation. Component patterns, token consumption, accessibility patterns, testing patterns, relationship to backend-development skill. |
