# PRD: Personal Portfolio Website

## Introduction / Overview

Build a simple, professional, 3-page personal portfolio website for Rakesh Verma. The site uses vanilla HTML, CSS, and no JavaScript frameworks. It opens directly in a browser (no server required). The design uses a dark theme with a clean, modern look.

---

## Goals

- Give Rakesh a professional online presence he can share with employers or collaborators.
- Make the site easy to update (placeholder content clearly marked).
- Work without a server — open any HTML file directly in a browser.

---

## User Stories

1. As a visitor, I want to see Rakesh's name and a welcome message on the home page so I know whose portfolio this is.
2. As a visitor, I want to navigate between Home, About, and Projects from any page so I can explore freely.
3. As a visitor, I want to read a bio and see Rakesh's interests on the About page.
4. As a visitor, I want to view 3 project cards on the Projects page, each with a title, description, and button.
5. As Rakesh, I want placeholder content clearly marked so I can easily fill in real details later.

---

## Functional Requirements

1. There must be 3 separate HTML files: `home.html`, `about.html`, `projects.html`.
2. All pages must share the same navigation bar with links to all 3 pages.
3. The active page must be visually highlighted in the nav bar.
4. `home.html` must display: the name "Rakesh Verma", a tagline, and a CTA button linking to `projects.html`.
5. `about.html` must display: a bio paragraph (placeholder), a list of 3–4 interests (placeholder), and a square photo placeholder box.
6. `projects.html` must display 3 project cards, each with: a title, a short description, and a "View Project" button.
7. All styles must live in a shared `styles.css` file — no inline styles.
8. The site must use a dark theme (background `#0D1117`, surface `#161B22`).
9. The site must open correctly from the file system (`file://`) — no server required.

---

## Non-Goals (Out of Scope)

- No JavaScript (no interactivity, no animations).
- No contact form.
- No real project links (buttons are placeholders).
- No real photo (grey box placeholder only).
- No mobile responsiveness (desktop layout only for now).
- No deployment or hosting.

---

## Design Considerations

| Token | Value |
|-------|-------|
| Background | `#0D1117` |
| Surface (cards/nav) | `#161B22` |
| Border | `#30363D` |
| Primary accent | `#58A6FF` (blue) |
| Text primary | `#E6EDF3` |
| Text muted | `#8B949E` |
| Font | `-apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif` |

---

## Technical Considerations

- **Tech stack:** Vanilla HTML + CSS only. No JS, no frameworks, no build step.
- **File location:** `AiProjects/day5/`
- **Shared styles:** Single `styles.css` imported by all 3 HTML files via `<link>`.
- **Active nav state:** Use a CSS class (e.g. `.active`) added manually to each page's nav link.

---

## Success Metrics

- All 3 pages open in a browser without errors.
- Navigation works correctly between all pages.
- Dark theme renders consistently across all pages.
- All placeholder sections are clearly identified with `[Placeholder]` labels.

---

## Open Questions

- None. All decisions made via clarifying questions.
