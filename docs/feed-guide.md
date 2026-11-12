# Feed guide — RSS + Podcasting 2.0 index, decentralized by default

The library's update feed is a plain static file, `feed.xml`, in
RSS 2.0 format. It is the decentralized option, and it is the
default: any feed reader can subscribe to it, no account, no
central platform, no algorithm in the middle. If the site moves
hosts, the feed moves with it — readers follow the file, not a
service.

## What the feed carries

One `<item>` per event a reader should know about:

- A new vehicle build page goes live.
- A major update to a build (new phase, major part fitted, a
  published spec corrected).
- Small edits (typos, wording, a photo added) do **not** get an
  item.

## The file

`feed.xml` at the repo root. RSS 2.0 with the Podcasting 2.0
namespace (`xmlns:podcast="https://podcastindex.org/namespace/1.0"`).
The Podcasting 2.0 pieces used here are the decentralized ones:

- `<podcast:guid>` — a stable UUID per item (the same UUID as the
  vehicle's `guid` in `registry.json`). Readers use it to tell
  items apart even if the title or link changes. At channel level
  the tag is the feed's own stable ID, not a vehicle UUID.
- `<podcast:locked owner="ruddyrid">yes</podcast:locked>` — says the
  feed is not to be imported or mirrored without permission.
- Plain `<guid isPermaLink="false">` carries the same UUID for
  readers that do not know the Podcasting 2.0 namespace.

Podcasting 2.0 features that belong to audio shows (value splits,
chapters, transcripts, soundbites) do not apply here and are not
used. This is an RSS feed with Podcasting 2.0 identity tags — not a
podcast.

## Adding an item

Copy the existing item block and change the fields:

```xml
<item>
  <title>[YEAR] [MAKE] [MODEL] — [what happened]</title>
  <link>https://example.com/vehicles/[folder]/</link>
  <description>[One or two sentences.]</description>
  <guid isPermaLink="false">[UUID from registry.json]</guid>
  <podcast:guid>[same UUID]</podcast:guid>
  <pubDate>[Day, DD Mon YYYY HH:MM:SS -0600]</pubDate>
</item>
```

- `pubDate` is RFC-822 format, Central time (`-0600` CST, `-0500`
  CDT). Example: `Sun, 08 Nov 2026 00:00:00 -0600`.
- Newest item goes first, directly after the channel fields.
- Keep at most the 20 newest items; older ones are history, kept in
  the per-vehicle changelogs.
- The item's link must be the live URL of the vehicle page, and
  the UUID must match the vehicle's `guid` in `registry.json`.

## The three-way agreement

The feed, the registry, and the library page always agree: an item
exists only for a real registry entry or a real changelog entry.
QA checks this every phase.

## If the feed breaks

Validate it as RSS 2.0 (well-formed XML, required channel fields,
RFC-822 dates). The usual breakages are an unescaped `&` in a
title or description (write `&amp;`), a malformed date, or an item
whose link does not resolve. Fix the file; do not delete the item.
