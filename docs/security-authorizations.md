# Security authorizations — how the menu works

Before any build work starts, the owner answers nine yes/no
questions in a small terminal menu. The answers are the build's
permission slip: the agents may do only what the owner approved,
and everything else stays off.

## Running the menu

After the agents have read `README.md` (and `herdr-layout.md`), the
Builder runs:

```
bash scripts/authorize.sh
```

The menu asks, one item at a time:

1. Write and edit files inside this repo folder (the build itself)
2. Read files outside this folder (e.g. the TealsUnltd tech library
   and the RX-7 13BT repo, to seed the founder entry)
3. Run a local preview server on this machine only
   (`python3 -m http.server`, localhost)
4. Fetch anything from the internet during the build
5. Install new packages or tools (pacman / npm)
6. Push anything to GitHub
7. Publish the site (enable GitHub Pages, buy or point a domain)
8. Touch the TealsUnltd repo, the Big Cartel store, or
   tealsunltd.com
9. Use or access secrets (API keys, tokens, passwords)

The menu uses `gum` (ships with Omarchy) when it is available, and
falls back to plain `y/N` prompts otherwise. It needs no network
access and writes nothing outside this repo.

## Where the decisions live

`authorizations.md` at the repo root — a dated table, one row per
item, `yes` or `no`. Anything not listed there is denied by
default. The Builder must not start Phase 1 until that file shows
decisions; QA checks it every phase.

## Changing or revoking a decision

Re-run `bash scripts/authorize.sh` at any time — it overwrites the
file with fresh answers. Or edit `authorizations.md` by hand and
tell the Builder the decision changed. Either way the new answer
applies from that point on; it does not retroactively approve
something already done.

## Rules that always apply, whatever the menu says

- Never print, log, or store a password, token, or API key.
- Never commit or push unless the menu says yes to item 6.
- Never publish unless the menu says yes to item 7.
- If a step needs an approval the menu did not give, the agent
  stops and asks the owner — it does not proceed and does not work
  around the menu.
