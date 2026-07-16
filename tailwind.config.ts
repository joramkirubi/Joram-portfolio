import type { Config } from "tailwindcss";

/**
 * Tailwind CSS v4 is CSS-first: all design tokens (colors, shadows,
 * fonts, animations) are defined directly in app/globals.css via the
 * `@theme` directive, and content sources are auto-detected.
 *
 * This file is kept for editor tooling / IDE IntelliSense support and
 * documents the project's content sources; it is not required for the
 * build to work.
 */
const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
    "./lib/**/*.{ts,tsx}",
  ],
};

export default config;
