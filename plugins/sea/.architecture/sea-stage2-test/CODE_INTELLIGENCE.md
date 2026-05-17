# Code Intelligence — sea-stage2-test

> **Project:** sea-stage2-test
> **Generated:** 2026-05-14T20:07:31+00:00
> **Workspaces:** 1
> **Toolchain:** ast-grep=ast-grep 0.42.2, lizard=1.22.1, scc=scc version 3.7.0, git=git version 2.54.0, pytest=pytest 9.0.1, npx=11.12.1

## Summary

_LLM synthesis not yet written. Run `python probe.py --draft-synthesis` to write a template, then have the LLM fill it._

## Workspace: `.`

> **Path:** `/Users/iain/Documents/repos/standards/plugins/sea`
> **Style:** single-repo

### Infrastructure & Stack
`[deterministic: scc]`

- **Primary language:** Markdown
- **Total files:** 34
- **Total LOC:** 7081
- **Total complexity:** 236

| Language | Files | Code | Complexity |
|---|---|---|---|
| Markdown | 19 | 4431 | 0 |
| Python | 13 | 2390 | 205 |
| Shell | 1 | 240 | 31 |
| JSON | 1 | 20 | 0 |

### Capability Inventory
`[deterministic: ast-grep]`

**By kind:** class=57, function=68
**By language:** python=125

Total: **125** symbols.

Sample (first 20):

| Kind | Name | File | Line | Language |
|---|---|---|---|---|
| function | `_python_version_check` | `skills/probe/scripts/probe.py` | 30 | python |
| function | `_build_parser` | `skills/probe/scripts/probe.py` | 40 | python |
| function | `_resolve_paths` | `skills/probe/scripts/probe.py` | 70 | python |
| function | `_skip_phases` | `skills/probe/scripts/probe.py` | 86 | python |
| function | `main` | `skills/probe/scripts/probe.py` | 104 | python |
| class | `ToolStatus` | `skills/probe/scripts/probe/detection.py` | 24 | python |
| class | `DetectionReport` | `skills/probe/scripts/probe/detection.py` | 35 | python |
| function | `_parse_version` | `skills/probe/scripts/probe/detection.py` | 47 | python |
| function | `_meets_min` | `skills/probe/scripts/probe/detection.py` | 55 | python |
| function | `_get_version` | `skills/probe/scripts/probe/detection.py` | 61 | python |
| function | `_lizard_sanity_check` | `skills/probe/scripts/probe/detection.py` | 84 | python |
| function | `detect_tools` | `skills/probe/scripts/probe/detection.py` | 112 | python |
| function | `format_report` | `skills/probe/scripts/probe/detection.py` | 176 | python |
| class | `WalkConfig` | `skills/probe/scripts/probe/filesystem.py` | 29 | python |
| function | `is_in_git_repo` | `skills/probe/scripts/probe/filesystem.py` | 39 | python |
| function | `git_ignored` | `skills/probe/scripts/probe/filesystem.py` | 54 | python |
| function | `_matches_any_glob` | `skills/probe/scripts/probe/filesystem.py` | 87 | python |
| function | `_component_in_excludes` | `skills/probe/scripts/probe/filesystem.py` | 97 | python |
| function | `walk_files` | `skills/probe/scripts/probe/filesystem.py` | 106 | python |
| function | `find_first_manifest` | `skills/probe/scripts/probe/filesystem.py` | 183 | python |

_Phases captured for this workspace: 1.1, 1.2_
