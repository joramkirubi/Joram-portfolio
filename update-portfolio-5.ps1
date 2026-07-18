# ==============================================================
# Portfolio update script #5 - corrects the Multi-Agent AI Platform
# section to accurately describe 4 independent agent repos instead
# of one orchestrated system, and links each agent to its real
# GitHub repo. Also removes the now-inaccurate orchestrator diagram.
# Usage:  .\update-portfolio-5.ps1
# ==============================================================

Write-Host "Starting portfolio update #5..." -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path "app\projects\[slug]" | Out-Null

# Remove the old orchestrator-diagram component - it is being replaced
if (Test-Path "components\MultiAgentDiagram.tsx") {
    Remove-Item -LiteralPath "components\MultiAgentDiagram.tsx" -Force
    Write-Host "  removed components\MultiAgentDiagram.tsx" -ForegroundColor Yellow
}

# ---- components\AgentPortfolioGrid.tsx ----
@'
"use client";

import { motion } from "framer-motion";
import { ArrowUpRight } from "lucide-react";
import { site } from "@/lib/site";

type AgentRepo = {
  name: string;
  repo: string;
  tag: string;
  description: string;
  accent: "primary" | "accent";
};

const agentRepos: AgentRepo[] = [
  {
    name: "Medical Assistant",
    repo: "medical-rag-assistant",
    tag: "RAG + ReAct",
    description:
      "Domain-specific medical AI assistant - answers health questions from curated documents with source citations and ReAct reasoning.",
    accent: "primary",
  },
  {
    name: "Research Agent",
    repo: "ResearchAgent",
    tag: "Research & Retrieval",
    description:
      "Standalone agent for multi-step research retrieval and synthesis.",
    accent: "accent",
  },
  {
    name: "Publication Assistant",
    repo: "Publication-assistant",
    tag: "Structured Drafting",
    description:
      "Standalone agent for structured publication and document drafting workflows.",
    accent: "primary",
  },
  {
    name: "Customer Support Agent",
    repo: "Customer_Support_Agent",
    tag: "Support & Intent Routing",
    description:
      "Standalone agent for customer support query handling and intent routing.",
    accent: "accent",
  },
];

export default function AgentPortfolioGrid() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 16 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-60px" }}
      transition={{ duration: 0.6 }}
      className="grid gap-4 sm:grid-cols-2"
    >
      {agentRepos.map((agent, index) => {
        const accentText =
          agent.accent === "primary" ? "text-primary" : "text-accent";
        const accentBorder =
          agent.accent === "primary"
            ? "hover:border-primary/40"
            : "hover:border-accent/40";

        return (
          <motion.a
            key={agent.repo}
            href={`${site.github}/${agent.repo}`}
            target="_blank"
            rel="noopener noreferrer"
            initial={{ opacity: 0, y: 16 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, margin: "-40px" }}
            transition={{ duration: 0.5, delay: index * 0.08 }}
            className={`card-glow group flex flex-col justify-between rounded-2xl border border-border bg-surface/50 p-5 transition-all hover:-translate-y-1 ${accentBorder}`}
          >
            <div>
              <div className="flex items-start justify-between gap-3">
                <span
                  className={`font-mono text-[11px] uppercase tracking-widest ${accentText}`}
                >
                  {agent.tag}
                </span>
                <ArrowUpRight
                  size={16}
                  className="shrink-0 text-muted transition-all group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-white"
                />
              </div>
              <h3 className="mt-2 text-base font-semibold text-white">
                {agent.name}
              </h3>
              <p className="mt-2 text-sm leading-relaxed text-muted">
                {agent.description}
              </p>
            </div>
            <p className="mt-4 font-mono text-xs text-muted">
              github.com/joramkirubi/{agent.repo}
            </p>
          </motion.a>
        );
      })}
    </motion.div>
  );
}
'@ | Set-Content -LiteralPath "components\AgentPortfolioGrid.tsx" -Encoding utf8
Write-Host "  wrote components\AgentPortfolioGrid.tsx" -ForegroundColor Green

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
      "M-Pesa moves a huge share of everyday money in Kenya, but the transaction history lives as unstructured, inconsistent SMS text. People have no reliable way to see spending patterns, categorize merchants, or import historical statements without manual, error-prone work - and any system touching this data has to take privacy seriously from day one.",
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
      "Automated Kenyan merchant categorization",
      "Composite per-user transaction indexing",
      "Handles password-protected PDF statements",
    ],
    accent: "primary",
  },
  {
    slug: "multi-agent-ai-platform",
    name: "AI Agent Suite",
    type: "Agentic AI Systems",
    tagline: "Four independent specialist agents, each solving a different real-world problem.",
    description:
      "Four independently built AI agents - a RAG-grounded Medical Assistant, plus dedicated Research, Publication, and Customer Support agents - each designed, deployed, and open sourced on its own.",
    problem:
      "Different problem domains - medical Q&A, research synthesis, publication drafting, and customer support - need very different context, tools, and safety guardrails. Handling all of them inside one generic chatbot produces shallow, unreliable results in every domain.",
    solution:
      "Rather than force one system to cover every domain, each agent is purpose-built and shipped independently, with its own setup and design suited to its own task. The Medical Assistant uses a RAG pipeline grounded in curated documents with ReAct reasoning and cited sources; the Research, Publication, and Customer Support agents are each tuned to their own workflow. Unifying them under shared orchestration and tracing is the natural next step as this portfolio matures.",
    architecture: [
      "Medical Assistant: RAG pipeline over curated medical documents with ReAct reasoning and source-cited answers",
      "Research Agent: standalone agent for multi-step research retrieval and synthesis",
      "Publication Assistant: standalone agent for structured document drafting workflows",
      "Customer Support Agent: standalone agent for support intent routing and query resolution",
      "Each agent designed, built, and deployed independently rather than sharing one framework",
    ],
    stack: ["Python", "LangChain", "RAG", "OpenAI"],
    highlights: [
      "Four standalone agents, each open source in its own public repo",
      "Medical Assistant grounded in RAG with cited sources to reduce hallucination risk",
      "Hands-on comparison of agent design patterns across different problem domains",
      "Next step: unify these under shared orchestration and tracing (LangGraph + LangSmith)",
    ],
    impactStats: [
      "4 independently built specialist agents",
      "RAG-grounded Medical Assistant with cited sources",
      "Each agent open source in its own repo",
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
      "Zero data-loss SQLite-to-PostgreSQL migration",
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

# ---- app\projects\[slug]\page.tsx ----
@'
import { notFound } from "next/navigation";
import Link from "next/link";
import type { Metadata } from "next";
import { ArrowLeft, ArrowUpRight, CheckCircle2 } from "lucide-react";
import { projects, getProject } from "@/lib/projects";
import { site } from "@/lib/site";
import CaseStudyAnimated from "@/components/CaseStudyAnimated";
import AgentPortfolioGrid from "@/components/AgentPortfolioGrid";

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
    title: `${project.name} - Joram Kirubi`,
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

          {project.slug === "multi-agent-ai-platform" && (
            <div className="mt-12">
              <h2 className="text-xl font-semibold text-white">The Agents</h2>
              <p className="mt-3 leading-relaxed text-muted">
                Four standalone agents, each designed and shipped
                independently rather than sharing one framework. Every repo
                below is public - click through to see the actual code.
              </p>
              <div className="mt-6">
                <AgentPortfolioGrid />
              </div>
            </div>
          )}

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

# ---- components\About.tsx ----
@'
"use client";

import { motion } from "framer-motion";
import { Blocks, Brain, Database } from "lucide-react";

const pillars = [
  {
    icon: Blocks,
    title: "Systems Thinking",
    body: "I design for how components fit together - data flow, failure modes, and long-term maintainability - not just individual features.",
  },
  {
    icon: Brain,
    title: "AI + Backend Integration",
    body: "I build agentic systems that are grounded in solid backend engineering: real APIs, real databases, real constraints - not just prompts.",
  },
  {
    icon: Database,
    title: "Real-World Problem Solving",
    body: "From parsing messy M-Pesa SMS data to migrating production databases, I focus on shipping systems that hold up outside a demo.",
  },
];

export default function About() {
  return (
    <section id="about" className="relative border-t border-border px-6 py-28 md:py-36">
      <div className="mx-auto max-w-6xl">
        <div className="grid gap-14 lg:grid-cols-[0.9fr_1.1fr] lg:gap-20">
          <motion.div
            initial={{ opacity: 0, y: 16 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.6 }}
          >
            <span className="font-mono text-xs uppercase tracking-widest text-primary">
              About
            </span>
            <h2 className="mt-3 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
              An engineer who builds intelligent, real-world systems
            </h2>
            <p className="mt-6 leading-relaxed text-muted">
              I&apos;m a backend engineer and agentic AI builder based in
              Kenya, currently deepening my data engineering foundations. My
              work sits at the intersection of three disciplines: dependable
              backend infrastructure, specialist AI agent systems, and the
              data pipelines that connect them.
            </p>
            <p className="mt-4 leading-relaxed text-muted">
              Whether it&apos;s turning raw M-Pesa SMS into structured
              financial insight, building specialist AI agents for domains
              like healthcare and research, or migrating a production
              database without losing data integrity - I care about the same
              thing: building systems that actually work under real
              conditions.
            </p>
          </motion.div>

          <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-1">
            {pillars.map((pillar, index) => (
              <motion.div
                key={pillar.title}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true, margin: "-60px" }}
                transition={{ duration: 0.5, delay: index * 0.1 }}
                className="card-glow flex items-start gap-4 rounded-2xl border border-border bg-surface/60 p-6 shadow-card backdrop-blur-sm transition-colors hover:border-primary/30"
              >
                <div className="mt-0.5 flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
                  <pillar.icon size={19} />
                </div>
                <div>
                  <h3 className="font-medium text-white">{pillar.title}</h3>
                  <p className="mt-1.5 text-sm leading-relaxed text-muted">
                    {pillar.body}
                  </p>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
'@ | Set-Content -LiteralPath "components\About.tsx" -Encoding utf8
Write-Host "  wrote components\About.tsx" -ForegroundColor Green

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
          className="mt-3 font-mono text-xs uppercase tracking-widest text-muted sm:text-sm"
        >
          Based in Kenya - Backend Engineering + Agentic AI + Data Engineering
        </motion.p>

        <motion.p
          variants={item}
          className="mt-6 max-w-2xl text-balance text-base leading-relaxed text-muted sm:text-lg"
        >
          I design and build intelligent systems - from specialist AI agents
          to real-world data and fintech infrastructure.
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

# ---- components\Projects.tsx ----
@'
"use client";

import { motion } from "framer-motion";
import { projects } from "@/lib/projects";
import ProjectCard from "./ProjectCard";

export default function Projects() {
  return (
    <section id="projects" className="relative px-6 py-28 md:py-36">
      <div className="mx-auto max-w-6xl">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="mb-14 max-w-2xl"
        >
          <span className="font-mono text-xs uppercase tracking-widest text-primary">
            Selected Work
          </span>
          <h2 className="mt-3 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
            Flagship Projects
          </h2>
          <p className="mt-4 text-muted">
            Real systems solving real problems - spanning fintech
            intelligence, specialist AI agents, and backend infrastructure.
          </p>
        </motion.div>

        <div className="grid gap-6 md:grid-cols-3">
          {projects.map((project, index) => (
            <ProjectCard key={project.slug} project={project} index={index} />
          ))}
        </div>
      </div>
    </section>
  );
}
'@ | Set-Content -LiteralPath "components\Projects.tsx" -Encoding utf8
Write-Host "  wrote components\Projects.tsx" -ForegroundColor Green

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
  title: `${site.name} - ${site.title}`,
  description:
    "Joram Kirubi designs and builds intelligent systems - from specialist AI agents to real-world data and fintech infrastructure.",
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
    title: `${site.name} - ${site.title}`,
    description:
      "I design and build intelligent systems - from specialist AI agents to real-world data and fintech infrastructure.",
    type: "website",
    url: site.url,
    siteName: site.name,
  },
  twitter: {
    card: "summary_large_image",
    title: `${site.name} - ${site.title}`,
    description:
      "I design and build intelligent systems - from specialist AI agents to real-world data and fintech infrastructure.",
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
          Building intelligent systems - from specialist AI agents to
          real-world data and fintech infrastructure.
        </div>
      </div>
    ),
    { ...size }
  );
}
'@ | Set-Content -LiteralPath "app\opengraph-image.tsx" -Encoding utf8
Write-Host "  wrote app\opengraph-image.tsx" -ForegroundColor Green

Write-Host ""
Write-Host "Running lint..." -ForegroundColor Cyan
npm run lint

Write-Host ""
Write-Host "Running production build..." -ForegroundColor Cyan
npm run build

Write-Host ""
Write-Host "Done. Check the build output above. If clean, git add / commit / push." -ForegroundColor Cyan
