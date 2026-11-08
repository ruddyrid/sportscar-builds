# Sports Car Build Library — Copilot handoff package

Paste this file to Copilot in a terminal inside `~/sportscar-builds`
on the OptiPlex (copy this whole folder there first). Copilot is the
lead builder; it runs the work through herdr using
`herdr-layout.md`. Read that file next — it is part of this package.

## What to build

A static repo website for **1980s and 1990s sports car builds** —
one self-contained page per car, plus a library page that merges them
all into one browsable index. Working title: **Sports Car Build
Library**. (The title, URL, and repo name are changeable in exactly
one place: `registry.json` under `site`.)

Scope: 1980–1999 sports cars and sporty coupes. The founder entry
is the owner's 1987 Mazda RX-7 Turbo II (FC3S, 13BT). Templates are
included for the next makes: Chevrolet Camaro (3rd/4th gen),
Ford Mustang (Fox Body / SN95), Honda Civic (EF / EG / EK). Any
other 80s/90s car fits the same template — that is the point.

## Structure

```
sportscar-builds/
├── README.md                 # this file — the master handoff
├── herdr-layout.md           # herdr session: 4–6 agents, roles, pane layout
├── registry.json             # the library index (single source of truth)
├── feed.xml                  # RSS 2.0 update feed (decentralized default)
├── styles.css                # TealsUnltd-matched aesthetic
├── vehicles/
│   └── 1987-mazda-rx7-turbo-ii/   # founder entry (seeded, verify specs)
│       ├── index.html
│       ├── build-log.md
│       ├── parts-list.md
│       ├── CHANGELOG.md
│       └── images/
├── templates/
│   ├── vehicle/              # copy this folder to add a car
│   │   ├── index.html
│   │   ├── build-log.md
│   │   ├── parts-list.md
│   │   ├── CHANGELOG.md
│   │   └── images/README.md
│   └── library-index.html    # merger page template
├── agents/                   # role briefs — one per herdr pane
│   ├── builder.md  editor.md  reviewer.md
│   ├── docs.md  assets.md  qa.md
└── docs/
    ├── build-instructions.md
    ├── user-guide.md
    ├── changelog-conventions.md
    ├── image-guide.md
    └── feed-guide.md         # RSS + Podcasting 2.0 index, decentralized
```

## File types (chosen, not negotiable without asking the owner)

| Type | Used for | Why |
|---|---|---|
| HTML, static, no framework | Vehicle pages, library page | Works everywhere, no build step, same as the TealsUnltd tech library. No dependencies, no CDN, system fonts only. |
| Markdown | Build logs, parts lists, guides, changelogs | Simple, git-diffable, editable in any editor. The page links to the `.md` source where useful. |
| JSON | `registry.json` | Single source of truth for the library page and the feed. The Builder agent updates the library page from it when a vehicle is added. |
| RSS 2.0 XML | `feed.xml` | Update feed: new builds and major updates as items. Static file, subscribable in any feed reader. Decentralized default — no central platform, no account. Podcasting 2.0 namespace (`podcast:guid`, `podcast:locked`) for stable IDs; see `docs/feed-guide.md`. |
| WebP / JPG | Images, per-vehicle `images/` folders | Self-contained hosting: images live in the repo, served by the same static host. WebP preferred, JPG fallback. See `docs/image-guide.md`. |

## Aesthetic — match the TealsUnltd tech library

`styles.css` is adapted from the TealsUnltd tech library
(`tech/styles.css`): system-ui fonts, teal `#0f766e` / dark
`#0b4f4a`, ink `#1a2222`, muted `#5b6a6a`, paper white, soft
`#eef4f3`, line `#d9e2e1`, amber `#b45309` for callouts, 860px
content width, cards with 12px radius, pill tags, header with a 4px
teal bottom border. Keep it: same variables, same components, plus
the library additions in the file (vehicle grid, gallery, spec table,
status pills, feed button). Do not restyle, do not add fonts, do not
add a framework. Dark/light toggle is a later decision, not this
build.

## Build order (phases — do them in order, report after each)

1. **Scaffold.** Folders, `styles.css`, `registry.json`, library
   page, `feed.xml` skeleton. Verify: pages load with
   `python3 -m http.server`, no console errors, phone width has no
   horizontal scroll.
2. **Founder entry.** Finish `vehicles/1987-mazda-rx7-turbo-ii/`
   from the seed. Specs must be verified, not invented — see Rules.
3. **Templates.** Make sure `templates/vehicle/` is a clean copy
   (no RX-7 specifics left in it) and the Camaro / Mustang / Civic
   entries exist as `template` status in the registry.
4. **Feed.** `feed.xml` with the founder entry as the first item,
   valid RSS 2.0, Podcasting 2.0 namespace present.
5. **Review + QA.** Reviewer and QA agents run their passes (see
   `agents/`). Fix what they flag; leave anything unverifiable
   flagged in the page, not smoothed over.
6. **Stop.** Do not publish, do not push to GitHub, do not buy a
   domain. Publishing is the owner's separate decision.

## Rules

- **Specs are FSM-first.** Never invent a torque, clearance, power,
  or dimension. If a figure comes from a video, forum, or memory,
  label it as stated / unverified. If it cannot be verified, leave
  it out and flag it. (This is the same rule as the RX-7 13BT
  accuracy review: 21 errors found by assuming.)
- **One car, one folder.** Everything about a vehicle lives in its
  own folder and links relatively — no cross-car dependencies, so an
  entry can be copied out on its own.
- **The registry is the truth.** Every vehicle on the library page
  is in `registry.json`, and every entry in `registry.json` is on
  the library page. Same for the feed: an item exists only for a
  real registry entry or a real changelog entry.
- **Static only.** No JavaScript frameworks, no server code, no
  external requests. A tiny script for the library page is allowed
  only if the static list cannot do the job — prefer the static list.
- **Do not commit or push.** Leave all edits uncommitted for the
  owner to review. Do not touch the TealsUnltd repo, the Big Cartel
  store, or tealsunltd.com.
- **Never print, log, or store passwords or tokens.**
- When a phase is done, append a short summary to this file under
  `## Done` saying what changed and how it was verified.

## How to hand this off (for the owner)

1. Copy this folder to the OptiPlex: `~/sportscar-builds`.
2. Open herdr, read `herdr-layout.md`, and set up the panes.
3. Paste this README to the Builder pane (Copilot) as the first
   prompt, then the role briefs to the other panes.
4. Work proceeds phase by phase; Copilot reports after each phase
   and waits for the owner's go-ahead before the next one.

## Done

<!-- Agents append phase summaries here. -->
