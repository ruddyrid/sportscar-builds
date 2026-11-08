# Image guide — hosting and optimization

Images are hosted in the repo itself, per vehicle, next to the page
that uses them. No external image host, no hot-linking. If the site
moves, the photos move with it.

## Where photos live

`vehicles/[year]-[make]-[model]/images/` — one folder per car. The
page references them by relative path (`images/photo.webp`), so an
entry copied out on its own keeps working.

## Naming

`YYYY-MM-DD-short-description.webp` — for example
`2026-11-08-turbo-manifold-before.webp`. Date first keeps the folder
in chronological order. Lowercase, hyphens only, no spaces, one
subject per filename.

## Format and size

- **WebP preferred**, JPG as fallback where the tooling does not
  export WebP.
- **1600px on the long edge maximum**, quality ~80. That keeps most
  photos under 300KB without visible loss.
- Keep the original full-size photo out of the repo (local backup
  only). The repo holds the web-sized copy.
- If a photo shows a part number, measurement, or label the text
  relies on, say so in the caption — do not make the reader zoom to
  find it.

## Captions

Every photo on a page gets a `<figcaption>` with a date and one line
of context: what it shows and why it matters. A photo without a
caption is decoration.

## What not to upload

- Number plates, addresses, or photos of people who did not agree
  to be in the build record.
- Screenshots of copyrighted material (manual pages, forum posts).
  Describe or paraphrase instead.

## Adding photos to a page

```html
<figure>
  <img src="images/2026-11-08-turbo-manifold-before.webp"
       alt="Turbo manifold before stoning, showing the uneven face">
  <figcaption>2026-11-08 — Turbo manifold face before stoning.</figcaption>
</figure>
```

Always include `alt` text: one short sentence describing the photo
for readers who cannot see it.
