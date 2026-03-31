# Task List: LinkedIn Viral Post Generator

Generated from: `tasks/linkedin-prd.md`
Framework: Next.js (App Router) + TypeScript + Tailwind CSS + Anthropic SDK

---

## Relevant Files

```
app/
  page.tsx                        - Generator page (main UI — topic mode, generate button, post output)
  dashboard/page.tsx              - Dashboard page (streak, history, win rate, chart)
  api/generate/route.ts           - API route that calls Anthropic SDK and returns post pair
  globals.css                     - Design tokens (CSS variables from design.md), base styles
  layout.tsx                      - Root layout with Navbar

components/
  Navbar.tsx                      - Top nav with logo, Generate and Dashboard links
  ThemeBadge.tsx                  - Pill badge showing today's theme (e.g. "Today's theme: Data")
  TopicModeSelector.tsx           - Two-button toggle: "Let AI Pick Topic" / "I'll Enter My Topic"
  ManualTopicInput.tsx            - Controlled text input for manual topic entry
  PostCard.tsx                    - Single post card: version badge, theme, word count, text, Copy button
  PostCard.test.tsx               - Unit tests for PostCard
  PostGrid.tsx                    - Side-by-side (desktop) / stacked (mobile) layout for A + B cards
  MetricsForm.tsx                 - Four number inputs: Likes, Comments, Shares, Saves + submit
  MetricsForm.test.tsx            - Unit tests for MetricsForm
  StreakCounter.tsx               - Large streak number with flame icon in magenta
  PostHistoryList.tsx             - Scrollable list of past post pairs with metrics and winner badge
  WinRateSummary.tsx              - "Version A wins X% of the time" summary component
  ViralScoreChart.tsx             - Simple bar/line chart of viral scores over time (Recharts)

lib/
  theme.ts                        - getThemeForDay() and getCurrentTheme() utilities
  theme.test.ts                   - Unit tests for theme utilities
  prompts.ts                      - buildVersionAPrompt() and buildVersionBPrompt() template builders
  generate.ts                     - generatePost(), word count validation loop, retry logic
  generate.test.ts                - Unit tests for generate utilities
  wordCount.ts                    - countWords() utility function
  wordCount.test.ts               - Unit tests for countWords()
  storage.ts                      - savePostPair(), getPostHistory(), updatePostMetrics()
  storage.test.ts                 - Unit tests for storage functions
  streak.ts                       - getStreak(), updateStreak() using UTC date keys
  streak.test.ts                  - Unit tests for streak logic
  viralScore.ts                   - calculateViralScore(), calculateWinRate()
  viralScore.test.ts              - Unit tests for viral score and win rate

types/
  index.ts                        - TypeScript types: Post, PostPair, EngagementMetrics, PostHistory
```

### Notes

- Unit tests go alongside source files (e.g. `lib/theme.ts` and `lib/theme.test.ts`).
- Run tests with `npx jest` or `npx jest lib/theme.test.ts` for a single file.
- Use `ANTHROPIC_API_KEY` in `.env.local` — never commit this file.
- All dates use UTC (YYYY-MM-DD string) for consistency across timezones.

---

## Instructions for Completing Tasks

**IMPORTANT:** As you complete each task, change `- [ ]` to `- [x]` in this file immediately. Update after each sub-task, not just after finishing a parent task.

Example: `- [ ] 1.1 Create file` → `- [x] 1.1 Create file`

---

## Tasks

---

### 0.0 Project Setup

- [ ] 0.1 Create and checkout a new branch: `git checkout -b feature/linkedin-post-generator`
- [ ] 0.2 Scaffold a new Next.js project with TypeScript: `npx create-next-app@latest . --typescript --app --tailwind --eslint`
- [ ] 0.3 Install Anthropic SDK: `npm install @anthropic-ai/sdk`
- [ ] 0.4 Install Recharts for the viral score chart: `npm install recharts`
- [ ] 0.5 Install Lucide React for icons: `npm install lucide-react`
- [ ] 0.6 Create `.env.local` with `ANTHROPIC_API_KEY=your_key_here` and add `.env.local` to `.gitignore`
- [ ] 0.7 Create folder structure: `components/`, `lib/`, `types/` under the project root
- [ ] 0.8 In `app/globals.css`, add all CSS custom properties from `design.md` (colors, spacing, radius, shadows) inside `:root {}`
- [ ] 0.9 In `tailwind.config.ts`, extend the theme to map Tailwind color keys to the CSS variables (e.g. `bg-base`, `accent-pink`, `accent-blue`, `border-default`)

---

### 1.0 TypeScript Types

- [ ] 1.1 Create `types/index.ts` and define the `EngagementMetrics` type: `{ likes: number; comments: number; shares: number; saves: number }`
- [ ] 1.2 Define the `Post` type: `{ id: string; version: 'A' | 'B'; text: string; wordCount: number; topic: string; theme: string; createdAt: string; metrics?: EngagementMetrics; viralScore?: number }`
- [ ] 1.3 Define the `PostPair` type: `{ id: string; topic: string; theme: string; mode: 'ai' | 'manual'; createdAt: string; versionA: Post; versionB: Post }`
- [ ] 1.4 Define the `PostHistory` type as `PostPair[]`
- [ ] 1.5 Export all types from `types/index.ts`

---

### 2.0 Weekly Theme Engine

- [ ] 2.1 Create `lib/theme.ts` and write `getThemeForDay(dayIndex: number): string` — maps 0 (Sun) through 6 (Sat) to the correct theme per the PRD table
- [ ] 2.2 Write `getCurrentTheme(): string` in `lib/theme.ts` — calls `new Date()` in UTC and passes `getUTCDay()` to `getThemeForDay()`
- [ ] 2.3 Create `lib/theme.test.ts` and write 7 tests — one per day — asserting the correct theme is returned for each `dayIndex`
- [ ] 2.4 Add one test for `getCurrentTheme()` asserting it returns a non-empty string

---

### 3.0 Word Count Utility

- [ ] 3.1 Create `lib/wordCount.ts` and write `countWords(text: string): number` — splits on whitespace, filters empty tokens, returns count
- [ ] 3.2 Create `lib/wordCount.test.ts` with tests for: empty string, single word, sentence, text with hashtags, text with arrows (→), and multi-line text

---

### 4.0 AI Prompt Builders

- [ ] 4.1 Create `lib/prompts.ts` and write `buildVersionAPrompt(topic: string, theme: string): string` with these rules baked into the prompt:
  - Hook must be a shocking stat or bold fact; must NOT start with "I"
  - Body must have exactly 3–4 numbered points
  - CTA must be exactly: `Agree or disagree? Drop your take below.`
  - Exactly 3 hashtags at the end
  - Total word count must be between 180 and 190 words
  - Audience: CEOs, CFOs, Founders in India, Europe, and the US
  - Theme context: today's theme is `{theme}`
  - Return ONLY the post text, no explanations or labels
- [ ] 4.2 Write `buildVersionBPrompt(topic: string, theme: string): string` with these rules:
  - Hook must start with `Unpopular opinion:` or be a contrarian statement
  - Body must have exactly 3–4 lines each starting with `→`
  - CTA must be exactly: `Save this. Share with your leadership team.`
  - Exactly 4 hashtags at the end
  - Total word count must be between 180 and 190 words
  - Same audience and theme context as Version A
  - Return ONLY the post text, no explanations or labels
- [ ] 4.3 Write `buildTopicPrompt(theme: string): string` — asks the LLM to return a single trending business topic relevant to the theme and C-suite audience, with no explanation, just the topic phrase

---

### 5.0 Post Generation API

- [ ] 5.1 Create `lib/wordCount.ts` is already done (task 3.1). Import `countWords` into the next file.
- [ ] 5.2 Create `lib/generate.ts` and write `callLLM(prompt: string): Promise<string>` — initialises `Anthropic` client, calls `messages.create` with `claude-sonnet-4-6`, max_tokens 500, and returns the first text content block
- [ ] 5.3 Write `validateAndRetry(prompt: string, maxRetries = 2): Promise<string>` — calls `callLLM`, checks if `countWords(result)` is 180–190, retries with an adjusted prompt if not; throws after maxRetries
- [ ] 5.4 Write `generatePostPair(topic: string, theme: string): Promise<{ versionA: string; versionB: string }>` — runs both `validateAndRetry` calls in parallel with `Promise.all`
- [ ] 5.5 Create `app/api/generate/route.ts` as a POST handler that:
  - Reads `{ topic, theme, mode }` from the request body
  - If `mode === 'ai'`, calls LLM with `buildTopicPrompt(theme)` to get the topic first
  - Calls `generatePostPair(topic, theme)`
  - Returns both posts as JSON with word counts and metadata
- [ ] 5.6 Create `lib/generate.test.ts` and write tests for `countWords` boundary cases and the retry logic using a mocked `callLLM`

---

### 6.0 Storage (localStorage)

- [ ] 6.1 Create `lib/storage.ts` and write `savePostPair(pair: PostPair): void` — serialises to JSON and saves to `localStorage` under key `linkedin_post_history`
- [ ] 6.2 Write `getPostHistory(): PostHistory` — reads from localStorage, parses JSON, returns array sorted newest-first by `createdAt`; returns `[]` if nothing stored
- [ ] 6.3 Write `updatePostMetrics(pairId: string, version: 'A' | 'B', metrics: EngagementMetrics): void` — reads history, finds the pair by `id`, updates the correct version's `metrics` and recalculates `viralScore`, saves back
- [ ] 6.4 Write `clearHistory(): void` — removes the localStorage key (useful for testing)
- [ ] 6.5 Create `lib/storage.test.ts` and mock `localStorage` using `jest-localstorage-mock` or a manual mock; test save, retrieve, update, and sort order

---

### 7.0 Streak Logic

- [ ] 7.1 Create `lib/streak.ts` and write `getTodayUTC(): string` — returns today's date as `YYYY-MM-DD` in UTC
- [ ] 7.2 Write `getStreak(history: PostHistory): number` — extracts unique `createdAt` date strings, sorts descending, counts consecutive days from today backwards; returns 0 if today has no post
- [ ] 7.3 Write `updateStreak(history: PostHistory): number` — calls `getStreak` and returns the current value (streak is derived from history, not stored separately)
- [ ] 7.4 Create `lib/streak.test.ts` with tests for: empty history (streak = 0), only today (streak = 1), today + yesterday (streak = 2), gap two days ago (streak = 1 if today exists), no post today (streak = 0)

---

### 8.0 Viral Score

- [ ] 8.1 Create `lib/viralScore.ts` and write `calculateViralScore(metrics: EngagementMetrics): number` using the formula: `(likes × 1) + (comments × 3) + (shares × 4) + (saves × 5)`
- [ ] 8.2 Write `calculateWinRate(history: PostHistory): { winner: 'A' | 'B' | 'tie' | 'insufficient'; aWins: number; bWins: number; total: number }` — iterates all pairs where both versions have a `viralScore`, compares them, returns counts
- [ ] 8.3 Create `lib/viralScore.test.ts` with tests for: zero metrics (score = 0), all-saves scenario, all-comments scenario, win rate with mixed history, win rate with no logged pairs

---

### 9.0 Design Tokens & Global Styles

- [ ] 9.1 In `app/globals.css`, set `body { background-color: var(--color-bg-base); color: var(--color-text-primary); font-family: 'Inter', 'Poppins', sans-serif; }`
- [ ] 9.2 Add the radial gradient glow hero background as a CSS class `.hero-glow` using the values from `design.md`
- [ ] 9.3 Add utility classes for the three button variants (primary, secondary, tertiary) from `design.md` as `@layer components` in globals.css
- [ ] 9.4 Add `.badge-blue` and `.badge-pink` utility classes for the badge styles from `design.md`
- [ ] 9.5 Add `.card` and `.card-accent` utility classes for the standard and accent-border card styles

---

### 10.0 Navbar Component

- [ ] 10.1 Create `components/Navbar.tsx` with a flex row: logo text on the left, "Generate" and "Dashboard" nav links on the right
- [ ] 10.2 Style the nav bar: `background: var(--color-bg-base)`, height 64px, `border-bottom: 1px solid var(--color-border-default)` on scroll
- [ ] 10.3 Style nav links as white text (14px, weight 500) with hover colour `var(--color-accent-primary)`
- [ ] 10.4 Use Next.js `<Link>` for navigation; highlight the active route using `usePathname()`
- [ ] 10.5 Add Navbar to `app/layout.tsx` so it appears on every page

---

### 11.0 ThemeBadge Component

- [ ] 11.1 Create `components/ThemeBadge.tsx` — accepts a `theme: string` prop, renders a pill badge
- [ ] 11.2 Style with `.badge-blue` class: blue background tint, `#5B63EB` text, uppercase, 12px, weight 600, rounded-full
- [ ] 11.3 Display text as `Today's theme: {theme}`

---

### 12.0 TopicModeSelector Component

- [ ] 12.1 Create `components/TopicModeSelector.tsx` — accepts `mode: 'ai' | 'manual'` and `onModeChange: (mode) => void`
- [ ] 12.2 Render two buttons side by side: "Let AI Pick Topic" and "I'll Enter My Topic"
- [ ] 12.3 Style active button with solid `#5B63EB` fill; inactive button with outlined style (transparent background, `#2A3858` border) per design.md
- [ ] 12.4 Add hover transition (0.2s ease) on inactive button to highlight border in `#5B63EB`

---

### 13.0 ManualTopicInput Component

- [ ] 13.1 Create `components/ManualTopicInput.tsx` — accepts `value: string` and `onChange: (value: string) => void`
- [ ] 13.2 Render a text input with placeholder "Enter your topic (e.g. AI in finance)"
- [ ] 13.3 Style with form input styles from `design.md`: dark background, border, focus ring in `#5B63EB`
- [ ] 13.4 Show a character count hint below the input (e.g. "Minimum 3 characters")
- [ ] 13.5 Only render this component when `mode === 'manual'`

---

### 14.0 Generator Page

- [ ] 14.1 Create `app/page.tsx` as the main generator page
- [ ] 14.2 Add state: `mode`, `manualTopic`, `isLoading`, `postPair`, `error`
- [ ] 14.3 Display `ThemeBadge` with today's theme (call `getCurrentTheme()` client-side)
- [ ] 14.4 Render `TopicModeSelector` and conditionally render `ManualTopicInput` when mode is `manual`
- [ ] 14.5 Render the Generate button (primary solid blue, full width on mobile)
- [ ] 14.6 Disable the Generate button when: `isLoading` is true, OR mode is `manual` and topic length < 3
- [ ] 14.7 On Generate click: set `isLoading = true`, call `POST /api/generate` with `{ topic, theme, mode }`, receive the post pair, save to localStorage via `savePostPair()`, set `postPair` state, set `isLoading = false`
- [ ] 14.8 Display an error message if the API call fails
- [ ] 14.9 Apply `.hero-glow` background class to the page wrapper

---

### 15.0 PostCard Component

- [ ] 15.1 Create `components/PostCard.tsx` — accepts a `Post` object as prop
- [ ] 15.2 Render the version label badge: Version A uses `.badge-pink` (`#E91E8C`), Version B uses `.badge-blue` (`#5B63EB`)
- [ ] 15.3 Render the theme tag using `ThemeBadge`
- [ ] 15.4 Render the word count as a small caption (12px, `#6B7A99`)
- [ ] 15.5 Render the post text in a `<pre>` or `<p>` with `whitespace-pre-wrap` so line breaks are preserved
- [ ] 15.6 Render a "Copy" button using the secondary outlined button style from design.md
- [ ] 15.7 Wire the Copy button to `navigator.clipboard.writeText(post.text)`
- [ ] 15.8 After clicking Copy, change button label to "Copied!" for 2 seconds, then reset
- [ ] 15.9 Apply the `.card` CSS class for styling; if this card is the winner (higher viral score), apply `.card-accent` instead
- [ ] 15.10 Create `components/PostCard.test.tsx` and test: version badge colour, copy button clipboard call, "Copied!" state reset

---

### 16.0 PostGrid Component

- [ ] 16.1 Create `components/PostGrid.tsx` — accepts `versionA: Post` and `versionB: Post`
- [ ] 16.2 Use CSS Grid: `grid-cols-1` on mobile, `grid-cols-2` on `md:` (768px+)
- [ ] 16.3 Add a loading skeleton state — two placeholder cards with a pulsing animation — shown when `isLoading` is true
- [ ] 16.4 Render `<PostCard>` for Version A and Version B inside the grid
- [ ] 16.5 Add the PostGrid below the Generate button on the generator page, visible only when `postPair` is set

---

### 17.0 MetricsForm Component

- [ ] 17.1 Create `components/MetricsForm.tsx` — accepts `postId: string`, `version: 'A' | 'B'`, `existingMetrics?: EngagementMetrics`, and `onSave: (metrics: EngagementMetrics) => void`
- [ ] 17.2 Render four number inputs: Likes, Comments, Shares, Saves — pre-filled with `existingMetrics` values if provided
- [ ] 17.3 Add validation: all values must be non-negative integers; show inline error if not
- [ ] 17.4 Render a "Save Metrics" primary button
- [ ] 17.5 On submit: call `updatePostMetrics(postId, version, metrics)` from `lib/storage.ts`, then call `onSave(metrics)` to update parent state
- [ ] 17.6 Create `components/MetricsForm.test.tsx` and test: renders with existing values, submit calls onSave, negative value shows error

---

### 18.0 Dashboard Page

- [ ] 18.1 Create `app/dashboard/page.tsx` as a client component
- [ ] 18.2 On mount, call `getPostHistory()` and store in state; call `getStreak(history)` for the streak count
- [ ] 18.3 Add a `refreshHistory()` function that re-reads storage and updates state — call it after any metric is saved

---

### 19.0 StreakCounter Component

- [ ] 19.1 Create `components/StreakCounter.tsx` — accepts `streak: number`
- [ ] 19.2 Render a large number (48px, weight 800, `#E91E8C`) with a flame icon (Lucide `Flame`, colour `#E91E8C`) beside it
- [ ] 19.3 Show label text below: "day streak" in `#B4B4B4`, 14px
- [ ] 19.4 If streak is 0, show "Start your streak today!" instead of "0 day streak"
- [ ] 19.5 Render StreakCounter at the top of the dashboard page

---

### 20.0 PostHistoryList Component

- [ ] 20.1 Create `components/PostHistoryList.tsx` — accepts `history: PostHistory` and `onMetricsSaved: () => void`
- [ ] 20.2 Render a list of `PostPair` items, newest first
- [ ] 20.3 Each list item shows: date (formatted as "Mon, 22 Mar 2026"), topic, theme badge, and for each version: viral score (if logged) or "Not logged yet"
- [ ] 20.4 Show a winner badge ("🏆 Version A" or "🏆 Version B") on the item when both versions have a viral score logged and one is higher
- [ ] 20.5 Add a "Log Metrics" button on each version within a history item that expands an inline `MetricsForm` below it
- [ ] 20.6 After metrics are saved, collapse the form and call `onMetricsSaved()`
- [ ] 20.7 If history is empty, show an empty state: "No posts yet. Generate your first post!"

---

### 21.0 WinRateSummary Component

- [ ] 21.1 Create `components/WinRateSummary.tsx` — accepts `history: PostHistory`
- [ ] 21.2 Call `calculateWinRate(history)` inside the component
- [ ] 21.3 If `total < 2`, show "Log metrics on 2 or more posts to see your win rate"
- [ ] 21.4 Otherwise, show: "Version A wins {aWins}/{total} times · Version B wins {bWins}/{total} times"
- [ ] 21.5 Highlight the winning version label in `#E91E8C`
- [ ] 21.6 Render WinRateSummary on the dashboard below the streak counter

---

### 22.0 ViralScoreChart Component

- [ ] 22.1 Create `components/ViralScoreChart.tsx` — accepts `history: PostHistory`
- [ ] 22.2 Transform history into chart data: `[{ date: string; versionA: number | null; versionB: number | null }]` sorted oldest-first
- [ ] 22.3 Use Recharts `LineChart` (or `BarChart`) with two series: Version A (`#E91E8C`) and Version B (`#5B63EB`)
- [ ] 22.4 Style chart background transparent, grid lines in `#2A3858`, axis labels in `#6B7A99`
- [ ] 22.5 Add a legend showing "Version A" and "Version B" with their respective colours
- [ ] 22.6 If fewer than 2 data points have scores, show placeholder text: "Chart will appear after logging metrics on multiple posts"
- [ ] 22.7 Render ViralScoreChart at the bottom of the dashboard page

---

### 23.0 Responsive Layout & Polish

- [ ] 23.1 Verify the generator page layout on 375px (iPhone SE) — TopicModeSelector buttons stack vertically if needed, Generate button is full width, PostGrid stacks to one column
- [ ] 23.2 Verify the dashboard layout on 375px — StreakCounter, WinRateSummary, PostHistoryList, and ViralScoreChart each take full width and are readable
- [ ] 23.3 Verify the generator page on 1280px — PostGrid shows two columns side by side
- [ ] 23.4 Add `transition: all 0.2s ease` to all interactive elements that lack it (buttons, inputs on focus)
- [ ] 23.5 Add hover lift (`translateY(-2px)` + shadow) to PostCard on desktop
- [ ] 23.6 Ensure all text meets minimum contrast ratio against the dark background (white on `#0A0E27` = 15.8:1 — compliant)

---

### 24.0 End-to-End Smoke Test

- [ ] 24.1 Run the app locally (`npm run dev`) and complete this full flow: open the app → select "Let AI Pick Topic" → click Generate → verify two posts appear with correct structure (numbered points for A, arrows for B) → click Copy on one post → verify clipboard content
- [ ] 24.2 Repeat with "I'll Enter My Topic" mode — type a topic, generate, verify posts
- [ ] 24.3 Go to Dashboard — verify streak shows 1, post appears in history
- [ ] 24.4 Click "Log Metrics" on a post — enter values — verify viral score appears and updates the history item
- [ ] 24.5 Log metrics on a second post — verify win rate summary appears and chart shows two data points
- [ ] 24.6 Run all unit tests: `npx jest` — verify all pass with no failures
- [ ] 24.7 Run Next.js build: `npm run build` — verify no TypeScript or build errors
