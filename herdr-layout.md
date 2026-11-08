# Herdr layout — Sports Car Build Library

How to run this build in herdr (the terminal multiplexer on the
OptiPlex). Read this before opening panes. The owner pastes the
master `README.md` to the Builder pane first, then one role brief
from `agents/` to each other pane as its first prompt.

## The roster: 4 minimum, 6 maximum

Roles are hats, not hard bindings to one agent program. If an agent
is unavailable, its role collapses onto Copilot — the build never
blocks on a missing agent.

| # | Role | Brief | First-choice agent | Fallback |
|---|---|---|---|---|
| 1 | **Builder** (lead) | `agents/builder.md` | Copilot | — (always Copilot; it owns the repo) |
| 2 | **Editor** | `agents/editor.md` | Gemini (Flash) | Copilot |
| 3 | **Reviewer** | `agents/reviewer.md` | OpenCode | Gemini, then Copilot |
| 4 | **QA** | `agents/qa.md` | Copilot (second pane) | Builder pane, after building |
| 5 | **Docs** | `agents/docs.md` | Gemini (Flash) | Editor pane |
| 6 | **Assets** | `agents/assets.md` | OpenCode | Builder pane |

- **Minimum 4 panes:** Builder, Editor, Reviewer, QA.
- **Maximum 6 panes:** add Docs and Assets.
- **Actually available right now:** Copilot works. Gemini works via
  API key but shares a free-tier quota (250 requests/day, Flash
  models only) with OpenCode — keep its prompts short. OpenCode
  works on its free tier (daily message limit, resets 6:28 p.m.).
  **Muse Code is billing-blocked** (402, no free tier; owner
  declined to pay) — do not assign it work. **Claude Code account
  status is unknown** — do not assign it work until the owner
  confirms an account.

## Pane setup (in the herdr TUI)

1. Open herdr on the OptiPlex (`Super + Ctrl + Return`, or
   `herdr` in a terminal).
2. Add one pane per role in the table order above. Name each pane
   after its role (Builder, Editor, Reviewer, QA, Docs, Assets) so
   the layout reads at a glance.
3. Paste the role brief into each pane as its first prompt, and
   tell it to read `README.md` before starting.
4. Builder goes first (Phase 1 scaffold). The other panes start
   when there is something to edit, review, or check — do not start
   all six at once on an empty repo.
5. If herdr offers to save this as a named layout, save it as
   `sportscar-builds`. Otherwise this file is the layout — follow
   it by hand each session.

## Performance + management rules

- **One file, one agent at a time.** Two panes never edit the same
  file in the same phase. Builder owns structure; Editor owns
  wording; Reviewer only comments (it does not rewrite); QA only
  reports (it does not fix — it files findings for Builder).
- **Small turns.** Each pane does one phase-step, reports back,
  and waits. No pane runs a long unsupervised chain.
- **Keep model usage cheap.** Gemini stays on Flash models. OpenCode
  stays on its free tier. If either hits its daily limit mid-phase,
  its role collapses onto Copilot and the phase continues — note the
  collapse in the `## Done` section of `README.md`.
- **Report after every phase.** Builder writes the phase summary
  under `## Done` in `README.md` and stops. The owner gives the
  go-ahead for the next phase. No phase starts unprompted.
- **Do not commit or push.** All edits stay uncommitted for the
  owner's review, same as every other project on this box.
- **Agents do not publish.** No GitHub push, no Pages enable, no
  domain purchase. Publishing is the owner's separate decision.

## If a pane fails

- Agent hits its quota/limit: collapse the role (see above), note
  it, keep going.
- Agent produces wrong specs: Reviewer flags it; Builder fixes it
  or removes it. Never smooth an unverified figure into a clean
  spec.
- Herdr itself has trouble: one pane at a time still works — the
  Builder pane alone can do the whole build, slower. The layout is
  a performance choice, not a dependency.
