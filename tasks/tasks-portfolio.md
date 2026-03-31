# Tasks: Personal Portfolio Website

## Relevant Files

- `day5/styles.css` — Shared dark theme styles (tokens, nav, cards, buttons)
- `day5/home.html` — Home page: name, tagline, CTA button, nav
- `day5/about.html` — About page: bio, interests, photo placeholder, nav
- `day5/projects.html` — Projects page: 3 project cards, nav

### Notes

- No server required — open HTML files directly in browser.
- All pages link to `styles.css` via `<link rel="stylesheet" href="styles.css">`.
- Each page manually adds class `active` to its own nav link.

---

## Instructions for Completing Tasks

**IMPORTANT:** Check off each task as you complete it by changing `- [ ]` to `- [x]`. Update after each sub-task, not just after finishing a parent task.

---

## Tasks

- [x] 0.0 Set up folder
  - [x] 0.1 Confirm `AiProjects/day5/` exists (already created)

- [x] 1.0 Create shared stylesheet
  - [x] 1.1 Create `day5/styles.css` with CSS variables (dark theme tokens)
  - [x] 1.2 Add base reset, body, and typography styles
  - [x] 1.3 Add nav bar styles (links, active state highlight)
  - [x] 1.4 Add card styles (surface background, border, padding)
  - [x] 1.5 Add button styles (primary accent color)

- [x] 2.0 Build Home page
  - [x] 2.1 Create `day5/home.html` with `<link>` to `styles.css`
  - [x] 2.2 Add nav bar with Home link marked `.active`
  - [x] 2.3 Add hero section: "Rakesh Verma" heading + tagline
  - [x] 2.4 Add CTA button linking to `projects.html`

- [x] 3.0 Build About page
  - [x] 3.1 Create `day5/about.html` with `<link>` to `styles.css`
  - [x] 3.2 Add nav bar with About link marked `.active`
  - [x] 3.3 Add bio paragraph (placeholder text)
  - [x] 3.4 Add interests list (3–4 placeholder items)
  - [x] 3.5 Add square photo placeholder box (grey, labelled "Photo")

- [x] 4.0 Build Projects page
  - [x] 4.1 Create `day5/projects.html` with `<link>` to `styles.css`
  - [x] 4.2 Add nav bar with Projects link marked `.active`
  - [x] 4.3 Add 3 project cards (title, description, "View Project" button)

- [x] 5.0 Verify
  - [x] 5.1 Open `home.html` in browser — confirm name, tagline, CTA render correctly
  - [x] 5.2 Click nav links — confirm all 3 pages load without errors
  - [x] 5.3 Confirm dark theme is consistent across all pages
  - [x] 5.4 Confirm active nav link is highlighted on each page
