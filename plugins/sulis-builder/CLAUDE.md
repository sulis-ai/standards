# Studio Builder

Self-service studio creation. Create new domain expertise packages using the studio-creation sequence.

## Commands

```bash
/sulis-builder:studio-definition "name"   # Create a new studio (7-file bundle)
```

## How It Works

The studio-definition skill:
1. Fetches `STUDIO_SCHEMA.md` from the methodology repo
2. Fetches the `studio-creation` sequence definition
3. Guides you through creating all 7 required files:
   - STUDIO.yaml, PRACTICE_PRIMITIVES.yaml, DISCLOSURE.yaml, AGENT.yaml
   - FUNCTION.md, STANDARDS.md, VOCABULARY.md
4. Runs triad-validated design with GATE 1 approval

## Two Modes

- **Creation:** Encoding new domain from external expertise → `provisional` status
- **Extraction:** Migrating existing delivery function → `validated` status
