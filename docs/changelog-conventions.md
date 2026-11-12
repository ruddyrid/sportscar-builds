# Changelog conventions

Changelogs follow [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
(version 1.1.0): human-readable, newest first, one file per vehicle
plus one for the site itself if needed.

## Format

```markdown
# Changelog — [YEAR] [MAKE] [MODEL]

## [Unreleased]

### Added
- ...

## [2026-11-08] — [Short title]

### Added
- ...

### Changed
- ...

### Fixed
- ...
```

- Dates are `YYYY-MM-DD`. The title after the date is a short
  summary ("First published", "Turbo install", "Torque corrections").
- Sections used: **Added**, **Changed**, **Fixed**. (Deprecated,
  Removed, and Security exist in the standard but are rarely needed
  here; use them if they fit.) Use the sections in that order.
- `[Unreleased]` holds changes already made but not yet published.
  When a page goes live or a major update is published, move its
  entries under a dated heading.
- Planned work is not a changelog entry. A TODO ("photos to add",
  "check this torque") goes in the build log; `[Unreleased]` records
  changes that actually happened. Omit a section that has no
  entries.

## Corrections

A correction entry names the old value and the new one:

- Good: `Fixed: spark-plug torque was 14–19 ft-lb, corrected to FSM
  9.4–13 ft-lb.`
- Bad: `Fixed: torque figures.` (says nothing)
- Never silently rewrite a wrong figure. The changelog is the
  record that it was wrong and what it is now.

## What goes in the changelog vs. the build log

- **Build log:** what was done to the car, session by session.
- **Changelog:** what changed on the page and the car that a reader
  should know about — new content, corrections, major parts.
- A major part or a corrected spec goes in both, one line each.
  A small wording fix goes in neither.
