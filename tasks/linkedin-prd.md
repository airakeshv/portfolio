# PRD: LinkedIn Post Generator

**Version:** 1.0
**Date:** 2026-03-22
**Status:** Ready for task generation

---

## 1. Introduction / Overview

LinkedIn is a high-signal platform for B2B thought leadership, but most executives and founders struggle to post consistently or write content that actually gets engagement. Writing from scratch is slow; AI tools that write generic posts get ignored.

This app solves that by generating **two battle-tested post formats (A and B)** every time the user asks for a post — either on a topic they choose or one the AI researches automatically. Every post follows proven structural rules (hook, body, CTA, hashtags) and hits a precise 180–190 word count.

The app also tracks performance so users learn over time which format, which topic type, and which day of the week wins for their audience.

**Target users:** CEOs, CFOs, and Founders operating in India, Europe, and the US.

---

## 2. Goals

1. Let users generate two ready-to-post LinkedIn drafts in under 60 seconds.
2. Enforce strict post structure rules so every output is high-quality and on-brand.
3. Auto-suggest topics based on the day of the week so users never face a blank page.
4. Track A/B performance with a viral score so users build data on what works.
5. Show a streak counter and win-rate history to build a daily posting habit.

---

## 3. User Stories

**US-1 — Topic Mode Selection**
As a founder, I want to choose whether the AI picks my topic or I enter my own, so I can use the app whether I have an idea or not.

**US-2 — AI Topic Research**
As a CEO with no time to research, I want the app to automatically suggest a relevant trending topic for today's theme, so I always have something credible to post about.

**US-3 — Manual Topic Entry**
As a CFO who knows what I want to say, I want to type my own topic and get two structured drafts instantly, so I don't waste time on a blank editor.

**US-4 — Dual Post Generation**
As a user, I want to see Version A and Version B side by side, so I can pick the one that feels right or post both on different days.

**US-5 — Word Count Guarantee**
As a user, I want to know each post is exactly 180–190 words, so I don't have to count or edit for length.

**US-6 — A/B Performance Logging**
As a user, I want to log the likes, comments, shares, and saves for each post I publish, so the app can calculate which version performs better over time.

**US-7 — Dashboard & Streak**
As a user, I want a dashboard showing my posting streak, full post history, and which version (A or B) wins more often, so I can see my progress and refine my strategy.

---

## 4. Functional Requirements

### 4.1 Topic Input

**FR-1.1** The app must present two mode options at the start of every session:
- **"Let AI Pick Topic"** — AI auto-selects a trending topic relevant to the current day's weekly theme.
- **"I'll Enter My Topic"** — A text input field appears for the user to type their topic.

**FR-1.2** In "Let AI Pick Topic" mode, the app must fetch or generate a relevant trending topic using an AI/LLM call. The topic must align with today's weekly theme (see FR-5).

**FR-1.3** In "I'll Enter My Topic" mode, the topic field must be required. The generate button must be disabled until the field has at least 3 characters.

---

### 4.2 Weekly Theme Engine

**FR-2.1** The app must automatically apply a theme based on the current day of the week:

| Day       | Theme     |
|-----------|-----------|
| Monday    | Mindset   |
| Tuesday   | Trend     |
| Wednesday | Data      |
| Thursday  | Story     |
| Friday    | Future    |
| Saturday  | Myth-Bust |
| Sunday    | Human     |

**FR-2.2** The current theme must be visible to the user on the generation screen (e.g., "Today's theme: Data").

**FR-2.3** The theme must influence the AI prompt so the generated post content aligns with it, regardless of which topic mode is selected.

---

### 4.3 Post Generation — Version A

**FR-3.1** Every generation must produce a Version A post with this exact structure:

- **Hook:** A shocking statistic or bold fact. Must NOT begin with the word "I".
- **Body:** Exactly 3–4 numbered points (1. 2. 3. or 1. 2. 3. 4.).
- **CTA:** Must end with the exact phrase — `Agree or disagree? Drop your take below.`
- **Hashtags:** Exactly 3 hashtags, relevant to the topic and audience.

**FR-3.2** Version A must be 180–190 words total (counting all text including hashtags).

**FR-3.3** The system must validate and retry generation internally if the word count falls outside 180–190. The user must never see a post outside this range.

---

### 4.4 Post Generation — Version B

**FR-4.1** Every generation must produce a Version B post with this exact structure:

- **Hook:** Must begin with `"Unpopular opinion:"` or open with a contrarian/counterintuitive statement.
- **Body:** Exactly 3–4 arrow-point lines, each starting with `→`.
- **CTA:** Must end with the exact phrase — `Save this. Share with your leadership team.`
- **Hashtags:** Exactly 4 hashtags, relevant to the topic and audience.

**FR-4.2** Version B must be 180–190 words total (counting all text including hashtags).

**FR-4.3** The same word count validation and retry rule from FR-3.3 applies to Version B.

---

### 4.5 Audience Targeting

**FR-5.1** The AI prompt used for generation must be written with this target audience in mind:
- **Roles:** CEOs, CFOs, Founders
- **Regions:** India, Europe, United States

**FR-5.2** Generated content must be professional, jargon-appropriate for C-suite readers, and avoid slang or overly casual language.

**FR-5.3** The AI must not reference region-specific slang or political content — keep it universally relevant to business leaders.

---

### 4.6 Post Output & Copy

**FR-6.1** Version A and Version B must be displayed side by side (desktop) or stacked (mobile) after generation.

**FR-6.2** Each post card must have a "Copy" button that copies the full post text to clipboard.

**FR-6.3** Each post card must display:
- Version label (A or B)
- Word count
- Today's theme tag
- The post text in a readable, formatted preview

---

### 4.7 A/B Performance Logging

**FR-7.1** Each generated post pair must be saved to the user's post history automatically.

**FR-7.2** On any saved post, the user must be able to log four engagement metrics:
- Likes
- Comments
- Shares
- Saves

**FR-7.3** The app must calculate a **Viral Score** for each post using this formula:

```
Viral Score = (Likes × 1) + (Comments × 3) + (Shares × 4) + (Saves × 5)
```

**FR-7.4** The Viral Score must be displayed on each post in the history view after metrics are logged.

**FR-7.5** The user must be able to update logged metrics at any time (e.g., after checking LinkedIn analytics later).

---

### 4.8 Dashboard

**FR-8.1** The dashboard must display a **streak counter** showing how many consecutive days the user has generated (or logged) a post.

**FR-8.2** The dashboard must display a **post history list** showing all past generated posts, ordered by most recent first. Each item shows:
- Date
- Topic
- Theme
- Whether metrics have been logged
- Viral Score (if logged)
- Which version won (A or B, based on higher Viral Score)

**FR-8.3** The dashboard must display a **Version Win Rate** summary — e.g., "Version A wins 60% of the time" — calculated from all posts where both A and B have metrics logged.

**FR-8.4** The dashboard must show a simple chart or visual of Viral Scores over time.

---

## 5. Non-Goals (Out of Scope)

- **Direct LinkedIn publishing.** The app will NOT post to LinkedIn via API. Users copy-paste manually.
- **Team or multi-user accounts.** This is a single-user tool in v1.
- **Scheduling.** No calendar or scheduled posting feature.
- **Image or carousel generation.** Text posts only.
- **More than two post versions.** Always exactly A and B — no C, no custom templates.
- **User authentication / login.** v1 may use local storage or a simple account; no OAuth with LinkedIn.
- **Mobile app.** Web only in v1; responsive design is required but no native iOS/Android app.

---

## 6. Design Considerations

Reference `design.md` for the full design system. Key applications for this app:

- **Page background:** `#0A0E27` (deep navy)
- **Cards for Version A / Version B:** Standard card style (`#111830`, border `#2A3858`) with the winning version highlighted using the Accent-Border card style (`#5B63EB` border + glow).
- **Mode selector ("Let AI Pick" vs "I'll Enter My Topic"):** Use two large toggle/tab buttons. Active mode uses `#5B63EB` fill; inactive uses outlined style.
- **Theme badge:** Use the blue badge style (`rgba(91,99,235,0.15)`, `#5B63EB` text) to display today's theme on the generation screen.
- **Version A label:** Use pink/magenta badge (`#E91E8C`) to distinguish it visually.
- **Version B label:** Use blue badge (`#5B63EB`).
- **Generate button:** Primary solid blue button (`#5B63EB`), full width on mobile.
- **Viral Score number:** Large, bold, `#E91E8C` accent color to make it stand out.
- **Streak counter:** Prominent display on the dashboard — large number with a flame icon, text in `#E91E8C`.
- **Copy button:** Secondary outlined button on each post card.
- **Typography:** Inter or Poppins, headings at 700–800 weight, body at 400–500.

---

## 7. Technical Considerations

- **LLM Integration:** Use an LLM API (e.g., Claude API via `@anthropic-ai/sdk`) to generate posts. Prompt must enforce word count, structure, CTA, and hashtag rules explicitly.
- **Word Count Validation:** After generation, count words server-side or client-side. If outside 180–190, re-call the LLM with a correction prompt (max 2 retries).
- **Trending Topic Fetch:** For "Let AI Pick Topic" mode, either use a web search API (e.g., Perplexity, Tavily, or Bing) or prompt the LLM to generate a plausible trending topic for the day's theme and target audience.
- **Data Storage:** v1 can use browser localStorage or a lightweight backend (SQLite / Supabase). Post history, metrics, and streak data must persist across sessions.
- **Streak Logic:** A streak increments if the user generates or logs a post on today's date. If a day is missed, streak resets to 0. Use UTC date for consistency.
- **Viral Score Calculation:** Pure arithmetic — compute on the fly from stored metric values; no ML required.
- **Responsive Layout:** Side-by-side cards on `≥768px`; stacked on mobile. Use CSS grid or flexbox.
- **Framework:** React or Next.js recommended. Tailwind CSS maps cleanly to the design tokens in `design.md`.

---

## 8. Success Metrics

| Metric | Target |
|--------|--------|
| Post generation time | Under 10 seconds from button click to results |
| Word count accuracy | 100% of posts land in 180–190 words range |
| User retention (day 7) | ≥ 40% of users return to generate a second post within 7 days |
| Streak engagement | ≥ 30% of active users maintain a 5+ day streak within first month |
| A/B logging rate | ≥ 50% of generated post pairs have metrics logged within 48 hours |
| Version win insight | Users can identify their winning version after 10 logged posts |

---

## 9. Open Questions

1. **Auth / Accounts:** Should v1 have user accounts (email/password or Google OAuth) to sync data across devices, or is browser localStorage sufficient for the MVP?
2. **Trending Topic Source:** For "Let AI Pick Topic" mode — should the app use a real-time web search API to find genuinely trending topics, or is it acceptable for the LLM to generate a plausible trending topic based on the theme and date?
3. **Post History Limit:** Is there a maximum number of posts to store, or should history be unlimited?
4. **Hashtag Language:** Should hashtags always be in English, or should the app offer region-specific hashtag sets (e.g., Hindi hashtags for India audience)?
5. **Regeneration:** If the user dislikes both versions, should there be a "Regenerate" button that produces two new versions on the same topic, or must they start a new session?
