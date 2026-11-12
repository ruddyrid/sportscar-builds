# Sports Car Build Library — handoff package

Paste this file to the Builder pane in a terminal inside
`~/sportscar-builds` on the OptiPlex (copy this whole folder there
first). The Builder (OpenCode with the local Ollama model, or
OpenCode on DeepSeek's free tier until the local model is serving)
is the lead builder; it runs the work through herdr using
`herdr-layout.md`. Read that file next — it is part of this package.
Free-first since v1.1.2: Copilot's monthly quota is exhausted, so no
role defaults to Copilot and no role collapses onto it until its
quota returns.

**Security gate — read this before any build step.** After reading
this file and `herdr-layout.md`, run `bash scripts/authorize.sh`
and wait for the owner to finish the menu. It asks nine yes/no
questions (file writes, reading outside this folder, local preview
server, internet, installs, push, publish, TealsUnltd/Big Cartel,
secrets) and records the answers in `authorizations.md`. Do not
start Phase 1 until that file shows decisions. Anything the owner
did not approve stays off. See `docs/security-authorizations.md`.

Package version: 1.1.2 — agents/models reworked to free-first: Copilot's monthly quota is exhausted, so the workhorse is now OpenCode with the local Ollama model (Qwen2.5-Coder-7B / Qwen3.5-9B) once the gaming PC is serving, OpenCode + DeepSeek free until then, and Gemini Flash free tier for the wording roles. (1.1.1 added the pane rename step; 1.1.0 added the authorizations menu.)

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
├── authorizations.md         # owner's yes/no decisions (run the menu first)
├── scripts/authorize.sh      # security authorizations TUI menu
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
    ├── security-authorizations.md
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

0. **Authorizations.** Run `bash scripts/authorize.sh` and wait
   for the owner to finish the menu. Do not start Phase 1 until
   `authorizations.md` shows decisions.
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

- **The authorizations menu gates everything.** No
  security-sensitive action proceeds unless the owner approved it
  in `authorizations.md`. If a step needs an approval the menu did
  not give, stop and ask — do not proceed and do not work around
  the menu.
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
3. Paste this README to the Builder pane (OpenCode) as the first
   prompt, then the role briefs to the other panes.
4. When the Builder runs the authorizations menu
   (`bash scripts/authorize.sh`), answer the nine questions. The
   build starts after that.
5. Work proceeds phase by phase; the Builder reports after each phase
   and waits for the owner's go-ahead before the next one.

## Done

<!-- Agents append phase summaries here. -->

### Phase 0 — Authorizations (2026-11-11)

Owner answered the nine-item security menu; decisions recorded in
`authorizations.md`. Approved: file writes (1), reads outside the
folder (2), local preview server (3), push (6), publish (7), TealsUnltd
access (8). Denied: internet during the build (4), installs (5),
secrets (9). Items 6–8 are permissions only — the phase plan still
stops before push/publish/touch, and nothing was pushed, published, or
touched outside this repo.

### Phase 1 — Scaffold (2026-11-11)

Status: the package arrived with the scaffold already in place, so this
phase was verification plus one fix instead of net-new files.

- Verified present and correct against the README structure:
  `styles.css`, `registry.json`, library `index.html`,
  `templates/library-index.html`, `templates/vehicle/*`, `feed.xml`,
  `docs/*`, `agents/*`, and the seeded founder entry.
- `registry.json` parses; all 4 entries appear on the library page
  (founder + Camaro/Mustang/Civic as `template`).
- `feed.xml` parses as valid RSS 2.0 with the Podcasting 2.0 namespace.
- All pages and linked local files returned HTTP 200 from
  `python3 -m http.server` on localhost.
- No external requests: root and vehicle pages reference no remote
  href/src and load no JavaScript (JSON-LD metadata only).
- Responsive rules present (`.wrap` padding, grid auto-fill, mobile
  h1/card overrides); no fixed widths that force phone horizontal
  scroll.
- Fixed: the founder page pointed at a non-shipped
  `images/placeholder-1.webp` (a 404 image). Replaced the placeholder
  figure with a note until real photos exist, per `docs/image-guide.md`
  ("delete it if there are none yet").
- Model note: run on OpenCode + DeepSeek V4.1 Flash Free (the interim
  free default). Local Ollama was not serving during this phase.

Waiting for the owner's go-ahead before Phase 2 (founder entry).

### Phase 2 — Founder entry (2026-11-11)

Read the owner's `20261107-rx7-13bt-tech` accuracy review and fix
survey (read-only, authorized by item 2) and finished the seeded
RX-7 entry against their FSM citations.

- **Corrected:** spec-sheet power was "185 hp @ 6,500 — verify in
  FSM"; now **182 hp (136 kW) @ 6,500 rpm, US SAE net**. The 185 PS
  figure is labeled as the JDM rating so it is never read as US hp.
- **Added (verified):** compression 8.5:1 (S4 turbo), 7,000 rpm
  redline, port injection with 4 × 550 cc injectors, transmission
  noted as Turbo II manual-only.
- **Boost stays flagged:** published manifold readings (~5.5 psi)
  and the 1988 FSM Technical Data figure (45.2 kPa / 6.56 psi)
  differ by ~1 psi and the measurement point is unconfirmed. The row
  is labeled "as stated, unverified" rather than smoothed.
- **Left out on purpose:** fuel-cut rpm, curb weight, dimensions —
  no FSM-verified figure is established in the review, so they are
  absent and flagged in the build log instead of guessed.
- **Build log:** new 2026-11-11 entry records the pass; the
  turbo-to-manifold video torque is now checked against the FSM's
  32–40 ft-lb / 44–54 Nm range (37 ft-lb is inside it; the video's
  paired 410 in-lb / 34.2 ft-lb still disagrees, so both stay
  recorded as stated).
- **Changelog:** `[Unreleased]` records the correction and additions.
- **Registry:** founder `updated` moved to 2026-11-11.
- **Verified:** founder page links all resolve (no broken refs, no
  bracketed template fields), all pages/files returned HTTP 200 from
  the local preview server, registry parses, feed parses, and the
  library page still mirrors the registry.
- Model note: OpenCode + DeepSeek V4.1 Flash Free again this phase.

Waiting for the owner's go-ahead before Phase 3 (templates).

### Phase 3 — Templates (2026-11-11)

- **Cleaned `templates/vehicle/`:** removed the two RX-7-specific
  leftovers — the example photo name `2026-11-08-turbo-manifold-before.webp`
  in `images/README.md` (now a generic `brake-caliper-before` example)
  and the RX-7 spark-plug torque correction example in `CHANGELOG.md`
  (now generic "copied from a forum; corrected to the FSM value").
- **Verified clean:** a search of `templates/vehicle/` for RX-7/13B/
  FC3S/Mazda/rotary/Durlon/N318 terms returns nothing; the 11
  remaining placeholders are the intended bracketed template fields.
- **Registry:** the Camaro (gen 3/4), Mustang (Fox/SN95), and Civic
  (EF/EG/EK) entries exist with `status: template`, all pointing at
  `templates/vehicle/`; all four registry GUIDs are unique.
- **Library page:** all three template cards still match the registry
  (name, template status, tags). `templates/library-index.html` still
  mirrors the live library page, which is its job — the vehicle
  template is the clean one.
- No files committed or pushed.

Waiting for the owner's go-ahead before Phase 4 (feed).

### Phase 4 — Feed (2026-11-11)

- **Fixed a real feed defect:** the channel-level `<podcast:guid>`
  was the founder vehicle's UUID. Per `docs/feed-guide.md` that tag
  must be the feed's own stable ID, not a vehicle UUID. Replaced it
  with a new channel UUID (`9668e23c-9a94-4882-88ed-8e6881d6e781`);
  the founder item keeps the registry UUID `bf8853fd-…` in both
  `<guid>` and `<podcast:guid>`.
- **Corrected the item wording:** dropped "is live" from the founder
  description (nothing is published) and noted that the spec sheet is
  the verified one.
- **Validated:** well-formed XML, RSS 2.0 version attribute, all
  required channel fields, `podcast:locked` present with owner, the
  channel GUID distinct from every vehicle GUID, exactly one item
  (founder, first), RFC-822 `pubDate` parses as
  `2026-11-08T00:00:00-06:00`, item GUID and podcast:guid both match
  the registry, item link ends in the registry `path`, no unescaped
  ampersands, under the 20-item cap. Feed returned HTTP 200 from the
  local server.
- **Flagged, not changed:** the channel link and item link still use
  `https://example.com/` because it matches `registry.json`'s
  `site.url`. When the owner sets the real URL in `registry.json`,
  the feed links must move with it (one-place rule still holds).
- No commit or push.

### Phase 5 — Review + QA (2026-11-11)

**Reviewer pass.** Confirmed the Phase 2 and Phase 4 fixes, then filed
five NITs and four owner-decision items:

- **N2 — applied:** the founder page no longer cites a repo path that
  does not exist here; it now reads "as transcribed in the owner's 13BT
  accuracy review (2026-11-08)" and stands alone.
- **N3 — applied:** every library card now carries every tag in
  `registry.json` (13B on the RX-7; SN95 and V8 on the Mustang;
  `template` on all three template cards). Checked 4/4 against the
  registry, both directions.
- **N4 — applied:** `templates/library-index.html` was rewritten as a
  placeholder-card template (bracketed card, generic nav, copy-block
  comment) instead of a stale byte-copy of the live page.
- **N6 — applied:** `build-log.md` header now covers the five undated
  video records, which sit under `## Video records (undated)` with no
  dates inferred.
- **N8 — withdrawn:** Reviewer spot-checked the owner's 13BT repo and
  confirmed the 21 ERROR fixes are applied there; the changelog claim
  stands, wording kept accurate.
- **Open for the owner (unchanged):** V1 the 1987 "Turbo II" name (page
  title, registry, feed, changelog all use it); V2 OEM part number
  9954-10-1105 is uncorroborated beyond TealsUnltd; V3 the
  N318-13-111D cross-reference is a product-page claim only; V4 the
  20 mm freeze-plug size is a product spec, not an FSM figure. All stay
  flagged, none smoothed.

**Editor pass** on the four founder files: first-use glosses (Series 4,
FSM, PTFE, RTV, stoning); 13B/13BT usage normalized; "Seeded from"
changed to "Compiled from"; internal Builder note made reader-facing;
the five video records grouped under one undated heading; wording
fixes ("car"/"multiple times", downpipe marked "Product used in this
build", crank-bolt row notes there is no install session, unconfirmed
prices say so); changelog reordered Added/Changed/Fixed. No number,
part number, status, date, link, path, table shape, or unverified label
was changed. Editor-raised template drift also fixed: the template
parts list now uses the same "as checked — confirm before ordering"
price rule, and `templates/vehicle/index.html` gained Compression,
Torque, Redline, and Fuel-system rows so new entries match the founder
structure.

**QA pass — initial verdict NOT PASS, then PASS after two blockers
were fixed:**

- **Blocking 1 (fixed):** no page declared a favicon, causing a
  `GET /favicon.ico` 404 in Chromium. Added an inline SVG data-URI
  favicon to all four HTML pages (head line 6 each).
- **Blocking 2 (fixed):** `templates/vehicle/index.html` shipped a live
  `images/placeholder-1.webp` reference with no image. The figure is
  now a commented-out pattern; the gallery note says to add one live
  figure per real photo and never point at a missing image.
- **Decide 3 (resolved):** `templates/library-index.html` is documented
  in its head as a root-copy template ("open it from the root, not from
  `templates/`"). Its in-place 404 is accepted as INFO, not a failure.
- **Re-run PASS:** all four pages 200 at 1280 and 390; 0 console
  errors, 0 broken images, 0 external requests; no horizontal scroll at
  390 px; registry↔library 4/4; feed valid RSS 2.0 with the channel
  GUID `9668e23c-…` distinct from the vehicle GUIDs; template clean of
  RX-7 specifics; `authorizations.md` 9/9 decided; no `.git`, no
  commit/push/publish.

### Phase 6 — Stop

The build ends here. Nothing is committed, pushed, or published;
no GitHub Pages or domain action was taken. Publishing remains the
owner's separate decision. When `registry.json` → `site.url` is set to
the real URL, update the corresponding `feed.xml` links at the same
time.
