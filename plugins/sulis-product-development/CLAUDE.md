# Product Development Studio

This studio provides the complete product delivery lifecycle: design, plan, implement, complete, journey, feature lifecycle orchestration, validation, and autonomous sub-agents.

## Studio Context

On session start or when product delivery work begins, fetch studio context from the methodology repo using GitHub MCP:

```
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/product-development/FUNCTION.md", ref={ref})
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/product-development/STANDARDS.md", ref={ref})
mcp__github__get_file_contents(owner="sulis-ai", repo="platform", path="methodology/studios/product-development/VOCABULARY.md", ref={ref})
```

Where `{ref}` comes from `ofm-bindings.yaml` methodology.ref (default: `main`).

## Commands

```bash
/sulis-product-development:design "description"   # Working Backwards design
/sulis-product-development:plan {feature}         # Implementation plan
/sulis-product-development:implement {feature}    # Double-loop TDD
/sulis-product-development:complete {feature}     # Quality verification + release
/sulis-product-development:journey "goal"         # User journey definition
```

## Feature Lifecycle

All feature work is tracked in `features/`. Check `features/index.md` for current state.

| Change Type | Criteria | Approach |
|-------------|----------|----------|
| **Trivial** | Typo, formatting, comment-only | Skip workflow entirely |
| **Bug/Small** | Fixes existing behavior, < 3 files | Quick-feature sequence |
| **Feature** | New capability, > 3 files, new API | Product-delivery sequence (4 gates) |

## Development Standards

- **Test-Driven Development** (NON-NEGOTIABLE): Double-loop TDD
- **Accurate, Clear, Minimal** — correct behavior, easy to understand, no unnecessary complexity
- All committed work items must complete regardless of priority
