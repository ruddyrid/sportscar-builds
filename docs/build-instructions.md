# Build instructions — adding a car to the library

How to add a vehicle entry, start to finish. Written for the Builder
agent and for the owner doing it by hand.

## 1. Copy the template

```
cp -r templates/vehicle vehicles/[year]-[make]-[model]/
```

Folder name is lowercase, hyphens only: `1987-mazda-rx7-turbo-ii`,
`1993-ford-mustang-cobra`, `1995-honda-civic-eg`. Year first, so
folders sort chronologically.

## 2. Fill in the page

Open `vehicles/[new-car]/index.html` and replace every bracketed
field: year, make, model, era, chassis, engine, compression,
transmission, factory power, factory torque, redline, fuel system,
tags. (`summary` is not on the page — it goes in `registry.json` in
step 5.) The template's spec rows are a starting point: delete rows
that do not apply, add rows for other verified figures, and label
any unverified one. Delete any section that does not apply — do not
leave bracketed placeholders in a published page.

Spec rules (same as the README):

- Factory figures first, verified where possible.
- A factory figure that is not yet confirmed is marked "verify in
  FSM" on the page, so a reader does not mistake it for verified.
- Anything from a video, forum, or memory is labeled "as stated"
  and unverified until checked against the factory service manual.
- If a figure cannot be verified, leave it out and flag it in the
  build log.

## 3. Write the build log and parts list

- `build-log.md`: one dated entry per work session, newest first
  (see the template for the format). A video record with no
  confirmed date goes in a separate undated section — never invent
  a date or order.
- `parts-list.md`: one row per part, with part number, source,
  price, and status (fitted / ordered / wanted / removed).
- `CHANGELOG.md`: start it with an `[Unreleased]` section; move
  entries to a dated release when the page is published.

## 4. Add photos

Photos go in the car's `images/` folder. Follow
`docs/image-guide.md` (naming, WebP, 1600px max, captioned). The
template's gallery is a commented-out `<figure>` pattern: add one
live `<figure>` per real photo, then delete the comment markers.
Never publish a page that points at an image that does not exist.

## 5. Register the car (three places, always together)

1. Add the entry to `registry.json` (copy an existing entry; new
   UUID for `guid` — generate one with `python3 -c "import
   uuid; print(uuid.uuid4())"`).
2. Add a card to the library page (`templates/library-index.html`
   is the template; the live page is the repo root `index.html`
   once built) with the same year, make, model, status, and tags.
3. Add an `<item>` to `feed.xml` for the new build (see
   `docs/feed-guide.md`).

The three must agree: same car, same status, same dates. QA checks
this.

## 6. Review, then stop

- Editor reads the page for voice and consistency.
- Reviewer checks every spec against its source.
- QA loads the page, clicks every link, checks phone width, and
  validates the feed.
- Fix what they flag. Leave edits uncommitted for the owner's
  review. Do not publish.

## Updating a car later

1. Add a dated entry to `build-log.md` and a row to
   `parts-list.md` if a part changed.
2. Add a changelog entry under `[Unreleased]`; move it to a dated
   release when published.
3. Update `updated` in `registry.json`.
4. Add a feed `<item>` only for a major update (new phase, major
   part, correction of a published spec) — not for every small edit.
