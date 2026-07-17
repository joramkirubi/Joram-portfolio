# ==============================================================
# Portfolio update script - run this from your joram-portfolio folder
# Usage:  .\update-portfolio.ps1
# ==============================================================

Write-Host "Starting portfolio update..." -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path "app\projects\[slug]" | Out-Null

# ---- lib\site.ts ----
@'
/**
 * Single source of truth for site-wide contact info and links.
 * Edit this file to update your email, socials, scheduling link,
 * resume path, or live domain everywhere at once.
 */
export const site = {
  name: "Joram Kirubi",
  title: "Agentic AI & Backend Engineer",
  email: "joramkirubi100@gmail.com",
  github: "https://github.com/joramkirubi",
  linkedin: "https://www.linkedin.com/in/joram-kirubi-499683331/",
  // TODO: replace with your real Calendly / Cal.com / scheduling link
  calendly: "https://cal.com/joramkirubi",
  resumeUrl: "/resume.pdf",
  // TODO: replace with your real Vercel/custom domain once deployed
  url: "https://joramkirubi.dev",
};
'@ | Set-Content -LiteralPath "lib\site.ts" -Encoding utf8
Write-Host "  wrote lib\site.ts" -ForegroundColor Green

# ---- app\icon.svg ----
@'
<svg width="64" height="64" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="g" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#5eead4" />
      <stop offset="100%" stop-color="#818cf8" />
    </linearGradient>
  </defs>
  <rect width="64" height="64" rx="16" fill="#05060a" />
  <rect width="64" height="64" rx="16" fill="url(#g)" fill-opacity="0.12" />
  <text
    x="50%"
    y="53%"
    dominant-baseline="middle"
    text-anchor="middle"
    font-family="ui-monospace, monospace"
    font-size="26"
    font-weight="700"
    fill="url(#g)"
  >JK</text>
</svg>
'@ | Set-Content -LiteralPath "app\icon.svg" -Encoding utf8
Write-Host "  wrote app\icon.svg" -ForegroundColor Green

# ---- app\apple-icon.tsx ----
@'
import { ImageResponse } from "next/og";

export const size = { width: 180, height: 180 };
export const contentType = "image/png";

export default function AppleIcon() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          background: "#05060a",
          borderRadius: 40,
        }}
      >
        <div
          style={{
            display: "flex",
            fontSize: 72,
            fontWeight: 700,
            fontFamily: "monospace",
            backgroundImage: "linear-gradient(135deg, #5eead4, #818cf8)",
            backgroundClip: "text",
            color: "transparent",
          }}
        >
          JK
        </div>
      </div>
    ),
    { ...size }
  );
}
'@ | Set-Content -LiteralPath "app\apple-icon.tsx" -Encoding utf8
Write-Host "  wrote app\apple-icon.tsx" -ForegroundColor Green

# ---- app\opengraph-image.tsx ----
@'
import { ImageResponse } from "next/og";
import { site } from "@/lib/site";

export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function OpengraphImage() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          padding: "80px",
          background: "#05060a",
          backgroundImage:
            "radial-gradient(circle at 15% 15%, rgba(94,234,212,0.18), transparent 55%), radial-gradient(circle at 85% 85%, rgba(129,140,248,0.16), transparent 55%)",
        }}
      >
        <div
          style={{
            display: "flex",
            alignItems: "center",
            gap: 12,
            fontSize: 26,
            fontFamily: "monospace",
            color: "#5eead4",
          }}
        >
          {"// "}joram.kirubi
        </div>

        <div
          style={{
            display: "flex",
            marginTop: 28,
            fontSize: 72,
            fontWeight: 700,
            color: "#ffffff",
          }}
        >
          {site.name}
        </div>

        <div
          style={{
            display: "flex",
            marginTop: 14,
            fontSize: 40,
            fontWeight: 600,
            backgroundImage: "linear-gradient(90deg, #5eead4, #818cf8)",
            backgroundClip: "text",
            color: "transparent",
          }}
        >
          {site.title}
        </div>

        <div
          style={{
            display: "flex",
            marginTop: 30,
            fontSize: 26,
            color: "#8a93a6",
            maxWidth: 900,
            lineHeight: 1.5,
          }}
        >
          Building intelligent systems — from multi-agent AI platforms to
          real-world data and fintech infrastructure.
        </div>
      </div>
    ),
    { ...size }
  );
}
'@ | Set-Content -LiteralPath "app\opengraph-image.tsx" -Encoding utf8
Write-Host "  wrote app\opengraph-image.tsx" -ForegroundColor Green

# ---- app\sitemap.ts ----
@'
import type { MetadataRoute } from "next";
import { projects } from "@/lib/projects";
import { site } from "@/lib/site";

export default function sitemap(): MetadataRoute.Sitemap {
  const projectEntries: MetadataRoute.Sitemap = projects.map((project) => ({
    url: `${site.url}/projects/${project.slug}`,
    lastModified: new Date(),
    changeFrequency: "monthly",
    priority: 0.8,
  }));

  return [
    {
      url: site.url,
      lastModified: new Date(),
      changeFrequency: "monthly",
      priority: 1,
    },
    ...projectEntries,
  ];
}
'@ | Set-Content -LiteralPath "app\sitemap.ts" -Encoding utf8
Write-Host "  wrote app\sitemap.ts" -ForegroundColor Green

# ---- app\robots.ts ----
@'
import type { MetadataRoute } from "next";
import { site } from "@/lib/site";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: "*",
      allow: "/",
    },
    sitemap: `${site.url}/sitemap.xml`,
  };
}
'@ | Set-Content -LiteralPath "app\robots.ts" -Encoding utf8
Write-Host "  wrote app\robots.ts" -ForegroundColor Green

# ---- lib\projects.ts ----
@'
export type Project = {
  slug: string;
  name: string;
  type: string;
  tagline: string;
  description: string;
  problem: string;
  solution: string;
  architecture: string[];
  stack: string[];
  highlights: string[];
  impactStats: string[];
  accent: "primary" | "accent";
};

export const projects: Project[] = [
  {
    slug: "pesaiq",
    name: "PesaIQ",
    type: "Fintech Intelligence System",
    tagline: "Turning raw M-Pesa SMS into structured financial intelligence.",
    description:
      "Transforms raw M-Pesa SMS data into structured financial insights, analytics, and user-friendly dashboards.",
    problem:
      "M-Pesa moves a huge share of everyday money in Kenya, but the transaction history lives as unstructured, inconsistent SMS text. People have no reliable way to see spending patterns, categorize merchants, or import historical statements without manual, error-prone work — and any system touching this data has to take privacy seriously from day one.",
    solution:
      "PesaIQ parses SMS and PDF statements into a normalized transaction model, automatically classifies transactions using Kenyan merchant keyword heuristics, and surfaces the result through a mobile-first analytics dashboard. Data protection is treated as a core feature: consent flows, export/deletion endpoints, and PII stripping before any data reaches logging or third-party services.",
    architecture: [
      "FastAPI backend on Render handling ingestion, parsing, and REST endpoints",
      "PostgreSQL (Neon) with a composite per-user index on transaction identifiers to prevent cross-user collisions at scale",
      "SMS + PDF pipeline using pdfplumber/pikepdf, including support for password-protected Safaricom statements",
      "Merchant categorization engine using Kenyan keyword heuristics with month-based auto-detection for dashboards",
      "Next.js frontend on Vercel, mobile-first, with Google OAuth 2.0 authentication",
      "Privacy layer: consent modal, data export/deletion endpoints, PII stripped before Sentry, anonymized payloads to Groq for AI-assisted insights",
    ],
    stack: [
      "FastAPI",
      "PostgreSQL",
      "Next.js",
      "TypeScript",
      "pdfplumber",
      "pikepdf",
      "Render",
      "Neon",
      "Vercel",
      "Groq",
    ],
    highlights: [
      "Composite per-user indexing to eliminate duplicate-transaction errors across users",
      "Password-protected PDF statement parsing",
      "Kenya Data Protection Act 2019 compliant by design",
      "Roadmap: budget planner, debt tracker, savings goals, React Native app",
    ],
    impactStats: [
      "Kenya DPA 2019 compliant by design",
      "Composite per-user transaction indexing",
      "Handles password-protected PDF statements",
    ],
    accent: "primary",
  },
  {
    slug: "multi-agent-ai-platform",
    name: "Multi-Agent AI Platform",
    type: "Agentic AI System",
    tagline: "Coordinated specialist agents that retrieve, reason, and act.",
    description:
      "A system of coordinated AI agents — Medical Assistant, Research Assistant, Publication Assistant, and Customer Support Assistant — each combining retrieval, reasoning, and tool usage.",
    problem:
      "A single general-purpose model struggles to be precise, safe, and useful across very different domains at once — medical Q&A, literature research, publication workflows, and customer support each need different context, tools, and guardrails. Bolting all of it into one prompt produces shallow, unreliable results.",
    solution:
      "The platform decomposes the problem into specialized agents, each with its own retrieval pipeline, tool access, and reasoning scope, coordinated by an orchestration layer that routes tasks, manages shared memory/state, and enforces tool-use boundaries per agent.",
    architecture: [
      "Orchestration layer built on LangGraph for stateful, graph-based agent coordination",
      "Medical Assistant: RAG pipeline grounded in curated medical sources with citation-aware responses",
      "Research Assistant: multi-step retrieval and synthesis over papers and documents",
      "Publication Assistant: structured drafting and formatting workflows with tool calls",
      "Customer Support Assistant: intent routing, knowledge-base retrieval, and escalation logic",
      "Shared memory and tracing via LangSmith for debugging and evaluation",
      "MCP-based tool integration for structured, auditable tool access per agent",
    ],
    stack: [
      "Python",
      "LangChain",
      "LangGraph",
      "LangSmith",
      "RAG",
      "MCP",
      "OpenAI",
      "Vector Databases",
    ],
    highlights: [
      "Four specialized agents behind one coordinated system",
      "Retrieval-grounded responses with tool-use per agent, not one giant prompt",
      "Focus areas for hardening: prompt injection defense, tool sandboxing, output validation",
      "Built as a foundation for agent identity and scoped credential management (OAuth 2.1)",
    ],
    impactStats: [
      "4 coordinated specialist agents",
      "LangGraph-orchestrated, stateful workflows",
      "Full tool-use tracing via LangSmith",
    ],
    accent: "accent",
  },
  {
    slug: "inventory-management-system",
    name: "Inventory Management System",
    type: "Backend System",
    tagline: "A backend-first system for stock, suppliers, and workflow automation.",
    description:
      "A backend-driven inventory system with stock tracking, database management, and business workflow automation.",
    problem:
      "Small and mid-sized operations often run inventory on spreadsheets, which breaks down quickly: no real permissions model, no reliable audit trail, and no clean path to production-grade hosting as the data grows.",
    solution:
      "A Django REST Framework backend models products, stock movements, customers, and suppliers with proper relational integrity, backed by a custom permissions layer and a React frontend for day-to-day operation. The system was migrated from local SQLite to a production PostgreSQL deployment without losing data integrity.",
    architecture: [
      "Django REST Framework backend with modeled relationships for products, stock, customers, and suppliers",
      "Custom DjangoModelPermissionsWithView class for fine-grained, view-level permission control",
      "SQLite-to-PostgreSQL migration on Render using a dedicated data migration strategy",
      "React frontend with an enhanced dashboard and reusable chart components",
      "REST API layer powering all frontend data access",
    ],
    stack: [
      "Django",
      "Django REST Framework",
      "PostgreSQL",
      "SQLite",
      "React",
      "REST APIs",
      "Render",
    ],
    highlights: [
      "Custom permissions layer solving gaps in default DRF permission classes",
      "Zero-downtime-style migration path from SQLite to PostgreSQL in production",
      "Dashboard with reusable, data-driven chart components",
      "Roadmap: tabbed Customers/Suppliers view, Reports system, AI chat assistant",
    ],
    impactStats: [
      "Zero data-loss SQLite → PostgreSQL migration",
      "Custom fine-grained permissions layer",
      "Production-hosted on Render",
    ],
    accent: "primary",
  },
];

export function getProject(slug: string) {
  return projects.find((p) => p.slug === slug);
}
'@ | Set-Content -LiteralPath "lib\projects.ts" -Encoding utf8
Write-Host "  wrote lib\projects.ts" -ForegroundColor Green

# ---- components\ProjectCard.tsx ----
@'
"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowUpRight } from "lucide-react";
import type { Project } from "@/lib/projects";

export default function ProjectCard({
  project,
  index,
}: {
  project: Project;
  index: number;
}) {
  const accentText =
    project.accent === "primary" ? "text-primary" : "text-accent";
  const accentBorder =
    project.accent === "primary" ? "hover:border-primary/40" : "hover:border-accent/40";
  const accentShadow =
    project.accent === "primary" ? "hover:shadow-glow" : "hover:shadow-glow-accent";

  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-80px" }}
      transition={{ duration: 0.6, delay: index * 0.1, ease: [0.22, 1, 0.36, 1] }}
    >
      <Link
        href={`/projects/${project.slug}`}
        className={`card-glow group relative flex h-full flex-col justify-between rounded-2xl border border-border bg-surface/60 p-7 shadow-card backdrop-blur-sm transition-all duration-300 ${accentBorder} ${accentShadow} hover:-translate-y-1`}
      >
        <div>
          <div className="flex items-start justify-between gap-4">
            <span
              className={`font-mono text-[11px] uppercase tracking-widest ${accentText}`}
            >
              {project.type}
            </span>
            <ArrowUpRight
              size={18}
              className="shrink-0 text-muted transition-all duration-300 group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-white"
            />
          </div>

          <h3 className="mt-4 text-xl font-semibold text-white">
            {project.name}
          </h3>
          <p className="mt-3 text-sm leading-relaxed text-muted">
            {project.tagline}
          </p>

          <p
            className={`mt-4 inline-flex items-center gap-1.5 text-xs font-medium ${accentText}`}
          >
            <span className="h-1 w-1 rounded-full bg-current" />
            {project.impactStats[0]}
          </p>
        </div>

        <div className="mt-6 flex flex-wrap gap-2">
          {project.stack.slice(0, 4).map((tech) => (
            <span
              key={tech}
              className="rounded-md border border-border bg-surface2 px-2.5 py-1 font-mono text-[11px] text-muted"
            >
              {tech}
            </span>
          ))}
          {project.stack.length > 4 && (
            <span className="rounded-md border border-border bg-surface2 px-2.5 py-1 font-mono text-[11px] text-muted">
              +{project.stack.length - 4}
            </span>
          )}
        </div>
      </Link>
    </motion.div>
  );
}
'@ | Set-Content -LiteralPath "components\ProjectCard.tsx" -Encoding utf8
Write-Host "  wrote components\ProjectCard.tsx" -ForegroundColor Green

# ---- components\Contact.tsx ----
@'
"use client";

import { motion } from "framer-motion";
import { ArrowUpRight, CalendarClock, FileDown, Mail } from "lucide-react";
import { GithubIcon, LinkedinIcon } from "@/components/icons";
import { site } from "@/lib/site";

const links = [
  {
    label: "Email",
    href: `mailto:${site.email}`,
    handle: site.email,
    icon: Mail,
  },
  {
    label: "Schedule a Call",
    href: site.calendly,
    handle: "Book 30 min",
    icon: CalendarClock,
  },
  {
    label: "Resume",
    href: site.resumeUrl,
    handle: "Download PDF",
    icon: FileDown,
  },
  {
    label: "GitHub",
    href: site.github,
    handle: "@joramkirubi",
    icon: GithubIcon,
  },
  {
    label: "LinkedIn",
    href: site.linkedin,
    handle: "joram-kirubi",
    icon: LinkedinIcon,
  },
];

export default function Contact() {
  return (
    <section id="contact" className="relative border-t border-border px-6 py-28 md:py-36">
      <div
        className="pointer-events-none absolute bottom-0 left-1/2 h-72 w-72 -translate-x-1/2 rounded-full bg-primary/10 blur-[120px]"
        aria-hidden
      />
      <div className="relative z-10 mx-auto max-w-3xl text-center">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <span className="font-mono text-xs uppercase tracking-widest text-primary">
            Get In Touch
          </span>
          <h2 className="mt-3 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
            Let&apos;s build something intelligent.
          </h2>
          <p className="mx-auto mt-4 max-w-xl text-muted">
            Open to backend engineering and agentic AI opportunities. Grab
            time on my calendar, download my resume, or reach out directly.
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.15 }}
          className="mt-10 grid gap-4 sm:grid-cols-2"
        >
          {links.map((link, index) => {
            const isLastOdd =
              index === links.length - 1 && links.length % 2 !== 0;
            const isExternal = link.href.startsWith("http");
            return (
              <a
                key={link.label}
                href={link.href}
                target={isExternal ? "_blank" : undefined}
                rel={isExternal ? "noopener noreferrer" : undefined}
                download={link.label === "Resume" ? true : undefined}
                className={`card-glow group flex items-center justify-between rounded-2xl border border-border bg-surface/60 p-6 text-left shadow-card backdrop-blur-sm transition-all hover:-translate-y-1 hover:border-primary/40 hover:shadow-glow ${
                  isLastOdd ? "sm:col-span-2" : ""
                }`}
              >
                <div className="flex items-center gap-4">
                  <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
                    <link.icon size={20} />
                  </div>
                  <div>
                    <p className="font-medium text-white">{link.label}</p>
                    <p className="text-sm text-muted break-all">
                      {link.handle}
                    </p>
                  </div>
                </div>
                <ArrowUpRight
                  size={18}
                  className="ml-3 shrink-0 text-muted transition-all group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-white"
                />
              </a>
            );
          })}
        </motion.div>
      </div>
    </section>
  );
}
'@ | Set-Content -LiteralPath "components\Contact.tsx" -Encoding utf8
Write-Host "  wrote components\Contact.tsx" -ForegroundColor Green

# ---- components\Nav.tsx ----
@'
"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { CalendarClock, FileDown, Mail, Menu, X } from "lucide-react";
import { GithubIcon, LinkedinIcon } from "@/components/icons";
import { site } from "@/lib/site";

const links = [
  { href: "/#projects", label: "Projects" },
  { href: "/#stack", label: "Stack" },
  { href: "/#about", label: "About" },
  { href: "/#contact", label: "Contact" },
];

export default function Nav() {
  const [scrolled, setScrolled] = useState(false);
  const [menuOpen, setMenuOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 8);
    onScroll();
    window.addEventListener("scroll", onScroll);
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  // Lock background scroll while the mobile menu is open, and close it
  // automatically if the viewport is resized back up to desktop width.
  useEffect(() => {
    document.body.style.overflow = menuOpen ? "hidden" : "";

    const onResize = () => {
      if (window.innerWidth >= 768) setMenuOpen(false);
    };
    window.addEventListener("resize", onResize);
    return () => {
      document.body.style.overflow = "";
      window.removeEventListener("resize", onResize);
    };
  }, [menuOpen]);

  return (
    <header
      className={`sticky top-0 z-50 transition-all duration-300 ${
        scrolled || menuOpen
          ? "bg-background/80 backdrop-blur-md border-b border-border"
          : "bg-transparent border-b border-transparent"
      }`}
    >
      <nav className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
        <Link
          href="/"
          onClick={() => setMenuOpen(false)}
          className="font-mono text-sm tracking-tight text-white hover:text-primary transition-colors"
        >
          <span className="text-primary">&#47;&#47;</span> joram.kirubi
        </Link>

        <div className="hidden items-center gap-8 md:flex">
          {links.map((link) => (
            <a
              key={link.href}
              href={link.href}
              className="text-sm text-muted hover:text-white transition-colors"
            >
              {link.label}
            </a>
          ))}
        </div>

        <div className="hidden items-center gap-4 md:flex">
          <a
            href={`mailto:${site.email}`}
            aria-label="Email"
            className="text-muted hover:text-primary transition-colors"
          >
            <Mail size={18} />
          </a>
          <a
            href={site.github}
            target="_blank"
            rel="noopener noreferrer"
            aria-label="GitHub"
            className="text-muted hover:text-primary transition-colors"
          >
            <GithubIcon size={18} />
          </a>
          <a
            href={site.linkedin}
            target="_blank"
            rel="noopener noreferrer"
            aria-label="LinkedIn"
            className="text-muted hover:text-primary transition-colors"
          >
            <LinkedinIcon size={18} />
          </a>
          <Link
            href="/#contact"
            className="rounded-lg bg-primary px-4 py-2 text-sm font-semibold text-background transition-all hover:shadow-glow"
          >
            Let&apos;s talk
          </Link>
        </div>

        <button
          type="button"
          onClick={() => setMenuOpen((open) => !open)}
          aria-label={menuOpen ? "Close menu" : "Open menu"}
          aria-expanded={menuOpen}
          className="flex h-9 w-9 items-center justify-center rounded-lg border border-border bg-surface/60 text-white transition-colors hover:border-primary/40 hover:text-primary md:hidden"
        >
          {menuOpen ? <X size={18} /> : <Menu size={18} />}
        </button>
      </nav>

      <AnimatePresence>
        {menuOpen && (
          <motion.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.3, ease: [0.22, 1, 0.36, 1] }}
            className="overflow-hidden border-t border-border bg-background/95 backdrop-blur-md md:hidden"
          >
            <div className="flex flex-col gap-1 px-6 py-4">
              {links.map((link) => (
                <a
                  key={link.href}
                  href={link.href}
                  onClick={() => setMenuOpen(false)}
                  className="rounded-lg px-3 py-2.5 text-sm text-muted transition-colors hover:bg-surface hover:text-white"
                >
                  {link.label}
                </a>
              ))}
              <a
                href={site.calendly}
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => setMenuOpen(false)}
                className="mt-1 flex items-center gap-2 rounded-lg bg-primary px-3 py-2.5 text-sm font-semibold text-background"
              >
                <CalendarClock size={16} />
                Schedule a Call
              </a>
            </div>

            <div className="flex items-center gap-5 border-t border-border px-6 py-4">
              <a
                href={`mailto:${site.email}`}
                aria-label="Email"
                onClick={() => setMenuOpen(false)}
                className="text-muted hover:text-primary transition-colors"
              >
                <Mail size={20} />
              </a>
              <a
                href={site.github}
                target="_blank"
                rel="noopener noreferrer"
                aria-label="GitHub"
                className="text-muted hover:text-primary transition-colors"
              >
                <GithubIcon size={20} />
              </a>
              <a
                href={site.linkedin}
                target="_blank"
                rel="noopener noreferrer"
                aria-label="LinkedIn"
                className="text-muted hover:text-primary transition-colors"
              >
                <LinkedinIcon size={20} />
              </a>
              <a
                href={site.resumeUrl}
                download
                aria-label="Download resume"
                onClick={() => setMenuOpen(false)}
                className="text-muted hover:text-primary transition-colors"
              >
                <FileDown size={20} />
              </a>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </header>
  );
}
'@ | Set-Content -LiteralPath "components\Nav.tsx" -Encoding utf8
Write-Host "  wrote components\Nav.tsx" -ForegroundColor Green

# ---- components\Hero.tsx ----
@'
"use client";

import { motion, type Variants } from "framer-motion";
import { ArrowRight } from "lucide-react";
import { GithubIcon } from "@/components/icons";
import { site } from "@/lib/site";

const container: Variants = {
  hidden: {},
  show: {
    transition: { staggerChildren: 0.12, delayChildren: 0.1 },
  },
};

const item: Variants = {
  hidden: { opacity: 0, y: 18 },
  show: {
    opacity: 1,
    y: 0,
    transition: { duration: 0.7, ease: [0.22, 1, 0.36, 1] },
  },
};

export default function Hero() {
  return (
    <section className="relative overflow-hidden px-6 pt-24 pb-32 md:pt-36 md:pb-44">
      <div
        className="pointer-events-none absolute -top-32 left-1/2 h-[420px] w-[420px] -translate-x-1/2 rounded-full bg-primary/20 blur-[120px] animate-pulse-slow"
        aria-hidden
      />
      <div
        className="pointer-events-none absolute top-40 right-10 h-64 w-64 rounded-full bg-accent/20 blur-[100px] animate-float"
        aria-hidden
      />

      <motion.div
        variants={container}
        initial="hidden"
        animate="show"
        className="relative z-10 mx-auto flex max-w-4xl flex-col items-center text-center"
      >
        <motion.div
          variants={item}
          className="mb-6 inline-flex items-center gap-2 rounded-full border border-border bg-surface/60 px-4 py-1.5 font-mono text-xs text-primary backdrop-blur-sm"
        >
          <span className="h-1.5 w-1.5 rounded-full bg-primary shadow-glow" />
          Available for backend &amp; agentic AI engineering work
        </motion.div>

        <motion.h1
          variants={item}
          className="text-4xl font-semibold tracking-tight text-white sm:text-5xl md:text-6xl"
        >
          Joram Kirubi
        </motion.h1>

        <motion.p
          variants={item}
          className="mt-4 text-lg font-medium text-gradient sm:text-xl md:text-2xl"
        >
          Agentic AI &amp; Backend Engineer
        </motion.p>

        <motion.p
          variants={item}
          className="mt-6 max-w-2xl text-balance text-base leading-relaxed text-muted sm:text-lg"
        >
          I design and build intelligent systems — from multi-agent AI
          platforms to real-world data and fintech infrastructure.
        </motion.p>

        <motion.div
          variants={item}
          className="mt-10 flex flex-col items-center gap-4 sm:flex-row"
        >
          <a
            href="#projects"
            className="group inline-flex items-center gap-2 rounded-lg bg-primary px-6 py-3 text-sm font-semibold text-background shadow-glow transition-all hover:shadow-glow-lg hover:brightness-110"
          >
            View Projects
            <ArrowRight
              size={16}
              className="transition-transform group-hover:translate-x-1"
            />
          </a>
          <a
            href={site.github}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex items-center gap-2 rounded-lg border border-border bg-surface/60 px-6 py-3 text-sm font-semibold text-white backdrop-blur-sm transition-all hover:border-primary/50 hover:text-primary"
          >
            <GithubIcon size={16} />
            GitHub
          </a>
        </motion.div>

        <motion.div
          variants={item}
          className="mt-16 grid w-full grid-cols-3 gap-4 border-t border-border pt-10 sm:gap-8"
        >
          {[
            { label: "Focus", value: "Agentic AI Systems" },
            { label: "Core", value: "Backend Engineering" },
            { label: "Growing", value: "Data Engineering" },
          ].map((stat) => (
            <div key={stat.label} className="text-center">
              <p className="font-mono text-[11px] uppercase tracking-widest text-muted">
                {stat.label}
              </p>
              <p className="mt-1 text-sm font-medium text-white sm:text-base">
                {stat.value}
              </p>
            </div>
          ))}
        </motion.div>
      </motion.div>
    </section>
  );
}
'@ | Set-Content -LiteralPath "components\Hero.tsx" -Encoding utf8
Write-Host "  wrote components\Hero.tsx" -ForegroundColor Green

# ---- app\layout.tsx ----
@'
import type { Metadata } from "next";
import { Analytics } from "@vercel/analytics/next";
import { SpeedInsights } from "@vercel/speed-insights/next";
import "./globals.css";
import Nav from "@/components/Nav";
import Footer from "@/components/Footer";
import { site } from "@/lib/site";

export const metadata: Metadata = {
  title: `${site.name} — ${site.title}`,
  description:
    "Joram Kirubi designs and builds intelligent systems — from multi-agent AI platforms to real-world data and fintech infrastructure.",
  metadataBase: new URL(site.url),
  keywords: [
    "Joram Kirubi",
    "Backend Engineer",
    "Agentic AI Engineer",
    "Data Engineer",
    "FastAPI",
    "Django",
    "LangChain",
    "LangGraph",
    "Kenya software engineer",
  ],
  openGraph: {
    title: `${site.name} — ${site.title}`,
    description:
      "I design and build intelligent systems — from multi-agent AI platforms to real-world data and fintech infrastructure.",
    type: "website",
    url: site.url,
    siteName: site.name,
  },
  twitter: {
    card: "summary_large_image",
    title: `${site.name} — ${site.title}`,
    description:
      "I design and build intelligent systems — from multi-agent AI platforms to real-world data and fintech infrastructure.",
  },
};

const personJsonLd = {
  "@context": "https://schema.org",
  "@type": "Person",
  name: site.name,
  jobTitle: site.title,
  url: site.url,
  email: site.email,
  sameAs: [site.github, site.linkedin],
  knowsAbout: [
    "Backend Engineering",
    "Agentic AI Systems",
    "Data Engineering",
    "Python",
    "FastAPI",
    "Django",
    "LangChain",
    "LangGraph",
    "Retrieval-Augmented Generation",
  ],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="font-sans antialiased bg-background text-white min-h-screen flex flex-col">
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(personJsonLd) }}
        />
        <a
          href="#main-content"
          className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-[100] focus:rounded-lg focus:bg-primary focus:px-4 focus:py-2 focus:text-sm focus:font-semibold focus:text-background"
        >
          Skip to content
        </a>
        <div
          className="pointer-events-none fixed inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:44px_44px] [mask-image:radial-gradient(ellipse_60%_50%_at_50%_0%,black,transparent)]"
          aria-hidden
        />
        <div
          className="pointer-events-none fixed inset-0 bg-[radial-gradient(circle_at_50%_0%,rgba(94,234,212,0.12),transparent_60%)]"
          aria-hidden
        />
        <div className="noise pointer-events-none fixed inset-0" aria-hidden />
        <Nav />
        <main id="main-content" className="relative z-10 flex-1">
          {children}
        </main>
        <Footer />
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
'@ | Set-Content -LiteralPath "app\layout.tsx" -Encoding utf8
Write-Host "  wrote app\layout.tsx" -ForegroundColor Green

# ---- app\projects\[slug]\page.tsx ----
@'
import { notFound } from "next/navigation";
import Link from "next/link";
import type { Metadata } from "next";
import { ArrowLeft, ArrowUpRight, CheckCircle2 } from "lucide-react";
import { projects, getProject } from "@/lib/projects";
import { site } from "@/lib/site";
import CaseStudyAnimated from "@/components/CaseStudyAnimated";

export function generateStaticParams() {
  return projects.map((project) => ({ slug: project.slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const project = getProject(slug);
  if (!project) return {};
  return {
    title: `${project.name} — Joram Kirubi`,
    description: project.description,
  };
}

export default async function ProjectPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const project = getProject(slug);
  if (!project) notFound();

  const accentText = project.accent === "primary" ? "text-primary" : "text-accent";

  return (
    <CaseStudyAnimated>
      <section className="relative px-6 pt-16 pb-24 md:pt-20 md:pb-32">
        <div className="mx-auto max-w-3xl">
          <Link
            href="/#projects"
            className="inline-flex items-center gap-2 text-sm text-muted transition-colors hover:text-primary"
          >
            <ArrowLeft size={16} />
            Back to projects
          </Link>

          <div className="mt-8">
            <span className={`font-mono text-xs uppercase tracking-widest ${accentText}`}>
              {project.type}
            </span>
            <h1 className="mt-3 text-3xl font-semibold tracking-tight text-white sm:text-4xl md:text-5xl">
              {project.name}
            </h1>
            <p className="mt-4 text-lg leading-relaxed text-muted">
              {project.tagline}
            </p>
          </div>

          <div className="mt-8 flex flex-wrap gap-2">
            {project.stack.map((tech) => (
              <span
                key={tech}
                className="rounded-md border border-border bg-surface2 px-3 py-1.5 font-mono text-xs text-white/80"
              >
                {tech}
              </span>
            ))}
          </div>

          <div className="mt-8 grid gap-3 sm:grid-cols-3">
            {project.impactStats.map((stat) => (
              <div
                key={stat}
                className="rounded-xl border border-border bg-surface/50 p-4 text-sm font-medium text-white"
              >
                <span
                  className={`mb-1.5 block h-1 w-6 rounded-full ${
                    project.accent === "primary" ? "bg-primary" : "bg-accent"
                  }`}
                />
                {stat}
              </div>
            ))}
          </div>

          <div className="mt-16 space-y-14">
            <div>
              <h2 className="text-xl font-semibold text-white">Problem</h2>
              <p className="mt-3 leading-relaxed text-muted">
                {project.problem}
              </p>
            </div>

            <div>
              <h2 className="text-xl font-semibold text-white">Solution</h2>
              <p className="mt-3 leading-relaxed text-muted">
                {project.solution}
              </p>
            </div>

            <div>
              <h2 className="text-xl font-semibold text-white">Architecture</h2>
              <ul className="mt-4 space-y-3">
                {project.architecture.map((line) => (
                  <li
                    key={line}
                    className="flex items-start gap-3 rounded-xl border border-border bg-surface/50 p-4 text-sm leading-relaxed text-white/90"
                  >
                    <span
                      className={`mt-0.5 h-1.5 w-1.5 shrink-0 rounded-full ${
                        project.accent === "primary" ? "bg-primary" : "bg-accent"
                      }`}
                    />
                    {line}
                  </li>
                ))}
              </ul>
            </div>

            <div>
              <h2 className="text-xl font-semibold text-white">Highlights</h2>
              <ul className="mt-4 space-y-3">
                {project.highlights.map((line) => (
                  <li key={line} className="flex items-start gap-3 text-sm leading-relaxed text-muted">
                    <CheckCircle2
                      size={18}
                      className={`mt-0.5 shrink-0 ${accentText}`}
                    />
                    {line}
                  </li>
                ))}
              </ul>
            </div>
          </div>

          <div className="mt-16 flex flex-col gap-4 border-t border-border pt-10 sm:flex-row sm:items-center sm:justify-between">
            <p className="text-sm text-muted">
              Want the code, architecture diagrams, or a walkthrough?
            </p>
            <a
              href={site.github}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex w-fit items-center gap-2 rounded-lg border border-border bg-surface/60 px-5 py-2.5 text-sm font-medium text-white transition-all hover:border-primary/40 hover:text-primary"
            >
              View on GitHub
              <ArrowUpRight size={15} />
            </a>
          </div>
        </div>
      </section>
    </CaseStudyAnimated>
  );
}
'@ | Set-Content -LiteralPath "app\projects\[slug]\page.tsx" -Encoding utf8
Write-Host "  wrote app\projects\[slug]\page.tsx" -ForegroundColor Green

Write-Host ""
Write-Host "All files written. Installing dependencies..." -ForegroundColor Cyan
npm install

Write-Host ""
Write-Host "Running lint..." -ForegroundColor Cyan
npm run lint

Write-Host ""
Write-Host "Running production build..." -ForegroundColor Cyan
npm run build

Write-Host ""
Write-Host "Done. If lint and build both succeeded above, you are ready to git add / commit / push." -ForegroundColor Cyan
