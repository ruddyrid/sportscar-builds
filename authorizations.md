# Security authorizations — Sports Car Build Library

Decided by the owner on 2026-11-11 17:36 CST.
Recorded by scripts/authorize.sh. Re-run that script to change
a decision. Anything not listed here is denied by default.

| # | Action | Decision |
|---|---|---|
| 1 | Write and edit files inside this repo folder (the build itself — needed, say Yes) | yes |
| 2 | Read files outside this folder (for example the TealsUnltd tech library and the RX-7 13BT repo, to seed the founder entry) | yes |
| 3 | Run a local preview server on this machine only (python3 -m http.server, localhost) | yes |
| 4 | Fetch anything from the internet during the build | no |
| 5 | Install new packages or tools (pacman / npm) | no |
| 6 | Push anything to GitHub | yes |
| 7 | Publish the site (enable GitHub Pages, buy or point a domain) | yes |
| 8 | Touch the TealsUnltd repo, the Big Cartel store, or tealsunltd.com | yes |
| 9 | Use or access secrets (API keys, tokens, passwords) | no |

Rules the agents always follow, whatever is decided above:
- Never print, log, or store a password, token, or API key.
- Never commit or push unless item 6 says yes.
- Never publish unless item 7 says yes.

Build-plan note: items 6–8 are permissions, not tasks. The README's
phase plan ends at Phase 6 ("Stop — do not publish, do not push"),
so the Builder does not push, publish, or touch TealsUnltd/Big
Cartel/tealsunltd.com during this build unless the owner asks
separately after the build.
