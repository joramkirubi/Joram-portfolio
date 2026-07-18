# ==============================================================
# Portfolio update script #7 - adds ChromaDB, Pinecone, Transformers
# to the tech stack and AI Agent Suite project. (FastAPI was
# already listed under Backend.)
# Usage:  .\update-portfolio-7.ps1
# ==============================================================

Write-Host "Starting portfolio update #7..." -ForegroundColor Cyan

# ---- components\TechStack.tsx ----
@'
"use client";

import { motion } from "framer-motion";

const stack = [
  {
    category: "Languages",
    items: ["Python", "JavaScript", "SQL"],
  },
  {
    category: "Backend",
    items: ["Django", "Flask", "FastAPI"],
  },
  {
    category: "Databases",
    items: ["PostgreSQL", "MySQL", "SQLite", "SQL Server"],
  },
  {
    category: "AI / ML",
    items: [
      "OpenAI",
      "Transformers",
      "LangChain",
      "LangGraph",
      "LangSmith",
      "RAG",
      "ChromaDB",
      "Pinecone",
      "MCP",
      "DeepEval",
      "Ragas",
      "SDKs",
    ],
  },
  {
    category: "Tools",
    items: ["Docker", "Git", "Linux", "REST APIs", "n8n", "Postman"],
  },
];

export default function TechStack() {
  return (
    <section id="stack" className="relative border-t border-border px-6 py-28 md:py-36">
      <div className="mx-auto max-w-6xl">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="mb-14 max-w-2xl"
        >
          <span className="font-mono text-xs uppercase tracking-widest text-accent">
            Toolbox
          </span>
          <h2 className="mt-3 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
            Technology Stack
          </h2>
          <p className="mt-4 text-muted">
            The languages, frameworks, and infrastructure I use to ship
            reliable, intelligent systems end to end.
          </p>
        </motion.div>

        <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {stack.map((group, index) => (
            <motion.div
              key={group.category}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true, margin: "-60px" }}
              transition={{ duration: 0.5, delay: index * 0.08 }}
              className="card-glow rounded-2xl border border-border bg-surface/60 p-6 shadow-card backdrop-blur-sm transition-colors hover:border-primary/30"
            >
              <h3 className="font-mono text-xs uppercase tracking-widest text-primary">
                {group.category}
              </h3>
              <div className="mt-4 flex flex-wrap gap-2">
                {group.items.map((item) => (
                  <span
                    key={item}
                    className="rounded-md border border-border bg-surface2 px-3 py-1.5 text-sm text-white/90"
                  >
                    {item}
                  </span>
                ))}
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
'@ | Set-Content -LiteralPath "components\TechStack.tsx" -Encoding utf8
Write-Host "  wrote components\TechStack.tsx" -ForegroundColor Green

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
      "Agent output quality evaluated using DeepEval and Ragas metrics",
    ],
    stack: [
      "Python",
      "LangChain",
      "LangGraph",
      "LangSmith",
      "RAG",
      "ChromaDB",
      "Pinecone",
      "Transformers",
      "MCP",
      "DeepEval",
      "Ragas",
      "OpenAI",
    ],
    highlights: [
      "Four standalone agents, each open source in its own public repo",
      "Medical Assistant grounded in RAG with cited sources to reduce hallucination risk",
      "Hands-on comparison of agent design patterns across different problem domains",
      "Agent output quality evaluated using DeepEval and Ragas metrics",
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

Write-Host ""
Write-Host "Running lint..." -ForegroundColor Cyan
npm run lint

Write-Host ""
Write-Host "Running production build..." -ForegroundColor Cyan
npm run build

Write-Host ""
Write-Host "Done. Check the build output above. If clean, git add / commit / push." -ForegroundColor Cyan
