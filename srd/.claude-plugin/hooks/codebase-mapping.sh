#!/bin/bash
# Hook script: Background codebase mapping via headless Claude
#
# Intended to run as an async hook on SubagentStart (matcher: "srd:requirements-analyst")
# so that codebase mapping happens in the background while the facilitation conversation
# starts. The main agent picks up CODEBASE_INDEX.json when it becomes available.
#
# This is an EXPERIMENTAL alternative to the synchronous approach defined in the agent
# instructions. If this hook is active, the agent's synchronous mapping step will detect
# the existing index and skip rescanning.
#
# Usage (in .claude/settings.json or .claude/settings.local.json):
# {
#   "hooks": {
#     "SubagentStart": [
#       {
#         "matcher": "srd:requirements-analyst",
#         "hooks": [
#           {
#             "type": "command",
#             "command": "./srd/.claude-plugin/hooks/codebase-mapping.sh",
#             "async": true,
#             "timeout": 120
#           }
#         ]
#       }
#     ]
#   }
# }

set -euo pipefail

# Read hook input from stdin
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

if [ -z "$CWD" ]; then
  exit 0
fi

cd "$CWD" || exit 0

# Greenfield detection: check for package manifests or source files
# Search subdirectories too — monorepos keep manifests in apps/packages subdirs
HAS_CODEBASE=false
MANIFEST_MATCH=$(find . -maxdepth 3 \
  \( -name 'package.json' -o -name 'requirements.txt' -o -name 'pyproject.toml' \
     -o -name 'go.mod' -o -name 'Cargo.toml' -o -name 'pom.xml' \
     -o -name 'Gemfile' -o -name 'composer.json' -o -name '*.csproj' \) \
  ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' \
  ! -path '*/build/*' ! -path '*/__pycache__/*' ! -path '*/.venv/*' \
  2>/dev/null | head -1)
if [ -n "$MANIFEST_MATCH" ]; then
  HAS_CODEBASE=true
fi

if [ "$HAS_CODEBASE" = false ]; then
  # Check for source files (count actual matches, not just the first line)
  SOURCE_COUNT=$(find . -maxdepth 3 \
    \( -name '*.ts' -o -name '*.py' -o -name '*.go' -o -name '*.rs' \
       -o -name '*.java' -o -name '*.rb' -o -name '*.php' -o -name '*.cs' \) \
    ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' \
    ! -path '*/build/*' ! -path '*/__pycache__/*' ! -path '*/.venv/*' \
    2>/dev/null | wc -l)
  if [ "$SOURCE_COUNT" -eq 0 ]; then
    # Greenfield — no codebase to map
    exit 0
  fi
fi

# Find the specification folder (most recently modified)
SPEC_DIR=$(find .specifications -maxdepth 1 -mindepth 1 -type d 2>/dev/null | head -1)

# Staleness check: if index exists and codebase hasn't changed, skip
if [ -n "$SPEC_DIR" ] && [ -f "$SPEC_DIR/CODEBASE_INDEX.json" ]; then
  NEWER_FILES=$(find . -maxdepth 4 \
    \( -name '*.ts' -o -name '*.py' -o -name '*.go' -o -name '*.rs' \
       -o -name '*.java' -o -name '*.rb' -o -name '*.php' -o -name '*.cs' \) \
    -newer "$SPEC_DIR/CODEBASE_INDEX.json" \
    ! -path '*/node_modules/*' ! -path '*/.git/*' ! -path '*/dist/*' \
    ! -path '*/build/*' ! -path '*/__pycache__/*' ! -path '*/.venv/*' \
    2>/dev/null | head -1)
  if [ -z "$NEWER_FILES" ]; then
    # Index is fresh — skip
    exit 0
  fi
fi

# Run codebase mapping via headless Claude
# Skills can't be invoked directly in headless mode, so we describe the task
claude -p "Map this codebase to produce a CODEBASE_INDEX.json for requirements facilitation. Follow the codebase-mapping process: walk the project structure, read package manifests, identify the technology stack, search for architectural patterns (routes, models, services, API endpoints, database, external integrations), map data models, and identify service boundaries. Write the output to ${SPEC_DIR:-'.specifications/project'}/CODEBASE_INDEX.json using the standard format with mapped_at timestamp, technology_stack, applications, services, shared_modules, integrations, data_models, routes, and patterns." \
  --model sonnet \
  --allowedTools "Bash,Read,Glob,Grep,Write" \
  --max-turns 15 \
  --max-budget-usd 0.50 \
  --output-format text \
  > /dev/null 2>&1

exit 0
