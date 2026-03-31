# CLAUDE.md — AI Dev Tasks Workflow

This project uses a structured, step-by-step AI development workflow defined in `process.md`. Follow the instructions below for all feature development work.

---

## Workflow Overview

Build features in three phases: **PRD → Task List → Implementation**. Never skip phases or jump ahead without user confirmation.

---

## Phase 1: Create a PRD

When asked to build a feature, follow `create-prd.md`:

1. Ask **3–5 clarifying questions** before writing anything. Format questions as numbered lists with lettered options (A, B, C…) so the user can reply with short selections like "1A, 2C".
2. After receiving answers, generate a PRD with these sections:
   - Introduction/Overview
   - Goals
   - User Stories
   - Functional Requirements (numbered)
   - Non-Goals (Out of Scope)
   - Design Considerations (optional)
   - Technical Considerations (optional)
   - Success Metrics
   - Open Questions
3. Save the PRD to `/tasks/prd-[feature-name].md`.
4. **Do NOT start implementing after writing the PRD.** Wait for the user to proceed to Phase 2.

Target reader: a junior developer. Be explicit and avoid jargon.

---

## Phase 2: Generate a Task List

When asked to generate tasks from a PRD, follow `generate-tasks.md`:

1. **Phase 2a — Parent tasks only:** Generate high-level tasks (roughly 5). Always include task `0.0 Create feature branch` as the first task unless explicitly told not to. Present these to the user, then say: *"I have generated the high-level tasks based on your requirements. Ready to generate the sub-tasks? Respond with 'Go' to proceed."*
2. **Wait for "Go"** before continuing.
3. **Phase 2b — Sub-tasks:** Break each parent task into small, actionable sub-tasks. Identify relevant files (including test files) under a `## Relevant Files` section.
4. Save the task list to `/tasks/tasks-[feature-name].md`.

### Task list format

```markdown
## Relevant Files

- `path/to/file.ts` - Description of relevance.
- `path/to/file.test.ts` - Unit tests for file.ts.

### Notes

- Place test files alongside the source files they test.
- Run tests with `npx jest [optional/path/to/test/file]`.

## Instructions for Completing Tasks

**IMPORTANT:** Check off each task as you complete it by changing `- [ ]` to `- [x]`. Update after each sub-task, not just after finishing a parent task.

## Tasks

- [ ] 0.0 Create feature branch
  - [ ] 0.1 Create and checkout a new branch (e.g., `git checkout -b feature/[feature-name]`)
- [ ] 1.0 Parent Task Title
  - [ ] 1.1 Sub-task description
  - [ ] 1.2 Sub-task description
```

---

## Phase 3: Implement Tasks

When asked to work on tasks:

- Tackle **one sub-task at a time**.
- After completing each sub-task, mark it `[x]` in the task file immediately.
- After each sub-task, pause and prompt the user to review before continuing.
- Do not batch multiple sub-tasks into a single step without explicit user approval.

---

## Key Rules

- **Never skip clarifying questions** when creating a PRD.
- **Never start implementation** after writing a PRD — wait for the task generation step.
- **Always pause after parent tasks** and wait for "Go" before generating sub-tasks.
- **Always check off tasks** in the markdown file as you complete them.
- Tasks files live in `/tasks/`. Create the directory if it doesn't exist.

---

## Reference Files

| File | Purpose |
|------|---------|
| `process.md` | Explains the overall workflow |
| `create-prd.md` | Rules for generating PRDs |
| `generate-tasks.md` | Rules for generating task lists |

---

## Project: LinkedIn Viral Post Generator

**Location:** `linkedin-app/`

### What It Is
A single-page app (SPA) that generates two A/B versions of LinkedIn posts using AI, tracks engagement metrics, and shows which post format wins over time.

### How to Run
- **Double-click** `linkedin-app/START.command` — starts server + opens browser automatically
- Or manually: `python3 -m http.server 3000` inside `linkedin-app/`, then open `http://localhost:3000`
- Standalone history viewer: open `linkedin-app/linkedin-post-history.html` directly in browser (no server needed)

### Key Files

| File | Purpose |
|------|---------|
| `linkedin-app/index.html` | Entire app — all HTML, CSS (inline `<style>`), and JS (`<script>`) in one file |
| `linkedin-app/styles.css` | External stylesheet (design tokens, component styles) |
| `linkedin-app/linkedin-post-history.html` | Standalone post history viewer — works without server |
| `linkedin-app/START.command` | Double-click launcher (macOS) — starts server + opens browser |
| `linkedin-app/post_log.json` | Placeholder only — real data lives in browser localStorage (`post_log`) |
| `linkedin-app/ab_log.json` | Placeholder only — real data lives in browser localStorage (`ab_log`) |

### Tech Stack
- Vanilla HTML + CSS + JavaScript — no frameworks, no build step
- All app logic is inline in `index.html`
- Data stored in **browser localStorage** (not files on disk)
- Python HTTP server required for CORS (Anthropic API calls blocked by file:// protocol)

### AI Provider Integrations
| Provider | Model | Notes |
|----------|-------|-------|
| Anthropic | `claude-sonnet-4-6` | Requires server (CORS) |
| OpenAI | `gpt-4o` | Works directly |
| Gemini | `gemini-1.5-flash` | 2s delay added; free tier rate limits |

All three providers receive the same two-call flow:
1. **Research call** — finds the most viral trending topic (AI mode only)
2. **Writing call** — generates both post versions using the researched topic

### Generation Flow (`startGen()`)
1. Research call → get trending topic (skipped in manual mode)
2. Writing call → get JSON with `versionA` + `versionB`
3. Word count validation loop (up to 3 retries) — retries if either post < 175 words
4. Strip hashtag lines from post body (`stripHashtagLines()`)
5. Save to localStorage with headline + hashtags
6. Render result screen

### Data Schema (localStorage `post_log`)
```json
{
  "id": "pairId_A",
  "pairId": "1234567890",
  "version": "A",
  "date": "2026-03-22",
  "topic": "topic name",
  "theme": "Data",
  "headline": "Viral headline here",
  "hashtags": ["#AI", "#Leadership"],
  "text": "Full post body (hashtags stripped)",
  "metrics": { "likes": 0, "comments": 0, "shares": 0, "saves": 0 },
  "viralScore": 42
}
```

### Viral Score Formula
`(likes × 1) + (comments × 3) + (shares × 4) + (saves × 5)`

### Screens
| Screen ID | Name | Nav Key |
|-----------|------|---------|
| `screen-dashboard` | Dashboard | `#dashboard` |
| `screen-generator` | Generator | `#generator` |
| `screen-loading` | Loading | — |
| `screen-result` | Result (A/B cards) | `#result` |
| `screen-ab` | A/B Results table | `#ab` |
| `screen-history` | Post History | `#history` |

### Navigation
- Nav tabs are `<a href="#name">` links — CMD+click opens in new browser tab natively
- `go(name)` function handles screen switching + hash routing + render calls
- URL hash updates on every navigation (bookmarkable)

### Important Prompt Rules
- Year is **2026** — never use 2025
- Each numbered insight = **2 sentences** (stat + implication)
- Word count target = **185 words** per post (enforce 175+ minimum)
- Max **4** numbered/arrow points per version
- Banned words: game-changer, synergy, leverage, delighted, thrilled, excited to share, fast-paced world, utilizing, transformative, groundbreaking, revolutionizing, landscape, ecosystem

### Design Tokens (CSS variables)
- `--bg: #0A0E27` (dark navy background)
- `--surface: #111830` (card background)
- `--pink: #E91E8C` (Version A accent)
- `--blue: #5B63EB` (Version B accent / primary)
- `--border: #2A3858`
- Headline A: `#3B9EFF` (bright blue)
- Headline B: `#4ADE80` (bright green)
