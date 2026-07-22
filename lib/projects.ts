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
  repoUrl?: string;
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
    tagline: "Seven independent agent systems, spanning single-agent tools to true multi-agent orchestration.",
    description:
      "Seven independently built AI systems - a RAG-grounded Medical Assistant, a LangGraph-orchestrated personal assistant (SynapseAI), an autonomous coding agent (PatchPilot) that opens real pull requests, a true multi-agent orchestrator (Orchestra) that decomposes goals and runs specialists in parallel, plus dedicated Research, Publication, and Customer Support agents - each designed, deployed, and open sourced on its own.",
    problem:
      "Different problem domains - medical Q&A, research synthesis, publication drafting, personal task management, autonomous code changes, multi-step goal execution, and customer support - need very different context, tools, and safety guardrails. Handling all of them inside one generic chatbot produces shallow, unreliable results in every domain.",
    solution:
      "Rather than force one system to cover every domain, each is purpose-built and shipped independently, with its own setup and design suited to its own task. The Medical Assistant uses a RAG pipeline grounded in curated documents with ReAct reasoning and cited sources; SynapseAI uses a LangGraph StateGraph with a two-turn confirm-before-destructive-action flow; PatchPilot runs a plan-edit-test loop against a cloned repo with a confirm gate before any commit or PR; Orchestra is the one genuinely multi-agent system in the suite - a Supervisor decomposes a goal into subtasks, dispatches independent ones to Researcher/Analyst/Writer specialists in parallel via LangGraph's Send API, and a Critic gates every output before synthesis; the Research, Publication, and Customer Support agents are each tuned to their own workflow.",
    architecture: [
      "Medical Assistant: RAG pipeline over curated medical documents with ReAct reasoning and source-cited answers",
      "SynapseAI: LangGraph StateGraph personal assistant with a two-turn confirm-before-destructive-action flow for calendar, email, and task actions, backed by checkpointed conversation state",
      "PatchPilot: single-agent tool-calling loop that clones a repo, plans and edits code, runs tests, and only commits/pushes/opens a PR after explicit confirmation",
      "Orchestra: true multi-agent orchestration on LangGraph - a Supervisor decomposes a goal, a custom reducer safely merges state from specialists dispatched in parallel via Send, a Critic gates every subtask output, and SQLite checkpointing lets an interrupted run resume exactly where it left off",
      "Research Agent: standalone agent for multi-step research retrieval and synthesis",
      "Publication Assistant: standalone agent for structured document drafting workflows",
      "Customer Support Agent: standalone agent for support intent routing and query resolution",
      "Each system designed, built, and deployed independently rather than sharing one framework",
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
      "Guardrails",
      "Groq",
      "OpenAI",
    ],
    highlights: [
      "Seven standalone systems, each open source in its own public repo",
      "Medical Assistant grounded in RAG with cited sources to reduce hallucination risk",
      "SynapseAI requires explicit two-turn confirmation before any destructive action executes",
      "PatchPilot has shipped a real pull request end-to-end against a live test repo",
      "Orchestra dispatches specialist agents in parallel and resumes interrupted runs from a checkpoint",
      "Hands-on comparison of agent design patterns, from single-agent tools to true multi-agent orchestration",
      "Agent output quality evaluated using DeepEval and Ragas metrics",
    ],
    impactStats: [
      "7 independently built agent systems",
      "Orchestra: true multi-agent orchestration with parallel dispatch",
      "Each system open source in its own repo",
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
