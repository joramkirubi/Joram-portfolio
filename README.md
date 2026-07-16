# Joram Kirubi — Developer Portfolio

A dark, futuristic developer portfolio built with Next.js 16 (App Router),
TypeScript, Tailwind CSS v4, and Framer Motion.

Positioning: **an engineer who builds intelligent, real-world systems** —
spanning backend engineering, agentic AI, and data engineering.

## Tech Stack

- **Next.js 16.2.10** — App Router, Turbopack build, static generation for
  every route (`output`: fully static — no server runtime required)
- **React 19.2.7**
- **TypeScript 5.9** (strict mode)
- **Tailwind CSS 4.3.3** — CSS-first config via `@theme` in `app/globals.css`
- **Framer Motion 12** — scroll-in reveals, staggered hero entrance, page
  transitions
- **lucide-react** for utility icons (GitHub/LinkedIn are hand-rolled SVGs,
  see note below)

## Getting Started

```bash
npm install
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

Other scripts:

```bash
npm run build   # production build (static export of all routes)
npm run start   # serve the production build
npm run lint    # ESLint (flat config, ESLint 9)
```

This project was built and verified end-to-end in a clean environment
(`npm install` → `npm run build` → `npm run lint` → `npm run dev`, with live
HTTP checks on `/`, `/projects/pesaiq`, and a 404 check on an invalid
project slug) — no dependency conflicts, no type errors, no lint errors.

## Project Structure

```
app/
  layout.tsx              Root layout: background grid/glow, Nav, Footer
  template.tsx             Framer Motion page-transition wrapper
  page.tsx                Homepage: assembles all sections
  globals.css             Tailwind v4 theme tokens (colors, shadows, animations)
  projects/[slug]/page.tsx  Dedicated case-study page per project (SSG)

components/
  Nav.tsx                 Sticky nav, scroll-aware background
  Hero.tsx                Hero section with staggered entrance animation
  Projects.tsx            "Flagship Projects" section wrapper
  ProjectCard.tsx          Individual project card (hover glow, tilt-up)
  TechStack.tsx            Grouped skills grid
  About.tsx                Positioning + 3 pillars (systems thinking, etc.)
  Contact.tsx              GitHub / LinkedIn contact cards
  Footer.tsx
  CaseStudyAnimated.tsx    Client wrapper for case-study entrance animation
  icons.tsx                Hand-rolled GitHub/LinkedIn icon components

lib/
  projects.ts              Single source of truth for all project content
                           (used by both homepage cards and case study pages)
```

Adding a fourth project only requires adding one entry to `lib/projects.ts`
— the card grid and the `/projects/[slug]` case-study route both pick it up
automatically via `generateStaticParams`.

## Design Notes

- **Theme**: Tailwind v4 is CSS-first, so all design tokens (colors,
  shadows, glow effects, animations) live in `app/globals.css` under
  `@theme`, rather than in `tailwind.config.ts`. The config file is kept
  as a minimal reference for editor tooling but isn't required by the build.
- **Fonts**: Inter + JetBrains Mono are loaded via a Google Fonts `@import`
  in `globals.css` rather than `next/font/google`, so the production build
  has no build-time network dependency and works identically in fully
  offline/sandboxed CI environments.
- **Brand icons**: recent `lucide-react` versions removed trademarked
  brand glyphs (GitHub, LinkedIn, etc.) from the core icon set. `icons.tsx`
  provides drop-in inline-SVG replacements with the same `size`/`className`
  API as lucide icons.
- **Page transitions**: `app/template.tsx` re-mounts on every navigation,
  giving a subtle fade/slide transition between routes without extra
  routing libraries.

## Known Non-Issue in `npm audit`

`npm audit` reports a moderate advisory for a `postcss` version bundled
*inside* Next.js's own internal build tooling (`node_modules/next/node_modules/postcss`),
unrelated to the top-level `postcss` in this project (already patched).
`npm audit fix --force` would downgrade Next.js to version 9 to "fix" it,
which is not a real fix — it's a false-positive nested advisory with no
exploit path in a static site. Safe to ignore.

## Content

- GitHub: https://github.com/joramkirubi
- LinkedIn: https://www.linkedin.com/in/joram-kirubi-499683331/
