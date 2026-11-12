# Herdr layout — Sports Car Build Library

How to run this build in herdr (the terminal multiplexer on the
OptiPlex). Read this before opening panes. The owner pastes the
master `README.md` to the Builder pane first, then one role brief
from `agents/` to each other pane as its first prompt.

## The roster: 4 minimum, 6 maximum

Roles are hats, not hard bindings to one agent program. If an agent
is unavailable, its role collapses onto another free agent — the
build never blocks on a missing agent, and it never waits on a
paid-out quota.

**Free-first rule (Nov 11, 2026): Copilot's monthly quota is
exhausted, so Copilot is not assigned work and is not a fallback
until its quota returns.** The free routes are: OpenCode with the
local Ollama model on the gaming PC (unlimited, no quota — the
workhorse once it is serving), OpenCode on DeepSeek's free tier
(daily message limit), and Gemini on its free tier (Flash models,
250 requests/day per model, shared with OpenClaw). See "Actually
available right now" below.

| # | Role | Brief | First-choice agent | Fallback |
|---|---|---|---|---|
| 1 | **Builder** (lead) | `agents/builder.md` | OpenCode + local Ollama model (Qwen2.5-Coder-7B); until the gaming PC is serving, OpenCode + DeepSeek free | Gemini (Flash) |
| 2 | **Editor** | `agents/editor.md` | Gemini (Flash) | OpenCode + local model |
| 3 | **Reviewer** | `agents/reviewer.md` | OpenCode + local model | Gemini (Flash), then OpenCode + DeepSeek free |
| 4 | **QA** | `agents/qa.md` | OpenCode + local model (second pane) | Builder pane, after building |
| 5 | **Docs** | `agents/docs.md` | Gemini (Flash) | Editor pane |
| 6 | **Assets** | `agents/assets.md` | OpenCode + local model | Builder pane |

- **Minimum 4 panes:** Builder, Editor, Reviewer, QA.
- **Maximum 6 panes:** add Docs and Assets.
- **Actually available right now (Nov 11, 2026):**
  - **OpenCode + local Ollama model — the workhorse, once serving.**
    The gaming PC (GTX 1070) runs Ollama with Qwen2.5-Coder-7B for
    code-heavy roles and Qwen3.5-9B as the all-rounder; unlimited,
    no quota, nothing leaves the house. Setup: follow the Local LLM
    setup guide (space **Local LLM — Gaming PC**, file
    `~/workspace/local-llm/setup-guide.md`), then point OpenCode at
    it per that guide's Phase 6 (`opencode.json`, baseURL
    `http://<gaming-PC-IP>:11434/v1`). Until the gaming PC is
    serving, OpenCode panes use DeepSeek free instead. Note: a 7B
    local model is far weaker than Copilot/Gemini at reasoning —
    keep its turns small and verify every spec (the package already
    demands FSM-first verification).
  - **OpenCode + DeepSeek V4.1 Flash Free — the interim default.**
    Free tier, daily message limit (resets in the evening). This is
    what ran the Fred Lobster build end to end on Nov 11.
  - **Gemini (Flash) — free tier.** 250 requests/day **per model**,
    Flash models only, shared with OpenClaw. Keep prompts short.
    When one model hits its limit, switch with `/model` — switching
    to the other Flash model gives a fresh per-model quota
    (`gemini-3-flash-preview` and `gemini-3.8-flash` are the two to
    use; avoid the Pro models, they are not free-tier).
  - **Copilot — OUT OF QUOTA, do not assign work.** Monthly quota
    exhausted Nov 10 ("You have exceeded your monthly quota"). It
    returns on the owner's monthly billing date (unknown). Until
    then it is not a first choice and not a fallback.
  - **Muse Code is billing-blocked** (402, no free tier; owner
    declined to pay) — do not assign it work. **Claude Code account
    status is unknown** — do not assign it work until the owner
    confirms an account.

## Pane setup (in the herdr TUI)

1. Open herdr on the OptiPlex (`Super + Ctrl + Return`, or
   `herdr` in a terminal).
2. Add one pane per role in the table order above, then rename each
   pane after its role — herdr does NOT do this itself. Without
   renaming, every pane shows the same label (the repo folder name
   plus the agent kind, e.g. `sportscar-builds-repo` / `opencode`)
   and they cannot be told apart in the sidebar. To rename: focus
   a pane and press `ctrl+b` then `shift+p`, and type the role name
   in lowercase: `builder`, `editor`, `reviewer`, `qa`, `docs`,
   `assets`. (Alternative, from a terminal in the session:
   `herdr pane rename <pane-id> builder` — get IDs from
   `herdr pane list`, not from sidebar order; swap `builder` for
   the role name of each pane. Names must be lowercase, unique,
   max 32 characters. A pane rename outlives the agent in the
   pane; an agent rename clears when the agent exits.)
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
- **Keep model usage free.** Gemini stays on Flash models and
  switches models when one hits its daily limit. OpenCode stays on
  free models — the local Ollama model first (unlimited), DeepSeek
  free second. Prefer the local model for long or repetitive work
  since it has no quota. If a free route hits its daily limit
  mid-phase, its role collapses onto another free route and the
  phase continues — note the collapse in the `## Done` section of
  `README.md`. Copilot is not a fallback while its quota is out; if
  every free route is exhausted for the day, stop the phase and
  report it instead of waiting on Copilot.
- **Report after every phase.** Builder writes the phase summary
  under `## Done` in `README.md` and stops. The owner gives the
  go-ahead for the next phase. No phase starts unprompted.
- **Security gate first.** The Builder runs
  `bash scripts/authorize.sh` after reading the README and waits
  for the owner to finish the menu. No pane starts build work until
  `authorizations.md` shows decisions, and no pane takes an action
  the menu did not approve.
- **Do not commit or push.** All edits stay uncommitted for the
  owner's review, same as every other project on this box.
- **Agents do not publish.** No GitHub push, no Pages enable, no
  domain purchase. Publishing is the owner's separate decision.

## If a pane fails

- Agent hits its quota/limit: collapse the role onto another free
  agent (see above), note it, keep going. Copilot quota does not
  count as a collapse target while it is exhausted.
- Agent produces wrong specs: Reviewer flags it; Builder fixes it
  or removes it. Never smooth an unverified figure into a clean
  spec.
- Herdr itself has trouble: one pane at a time still works — the
  Builder pane alone can do the whole build, slower. The layout is
  a performance choice, not a dependency.
