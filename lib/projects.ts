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
      "Guardrails",
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
  {
    slug: "synapseai",
    name: "SynapseAI",
    type: "AI Personal Assistant",
    tagline: "A LangGraph-orchestrated assistant that confirms before it acts.",
    description:
      "A calendar, email, and task assistant built on a LangGraph StateGraph, with a two-turn confirm-before-destructive-action flow backed by real conversation-level persistence.",
    problem:
      "Personal assistants that can take real actions - sending emails, deleting calendar events, completing tasks - are dangerous if they act on a single ambiguous instruction. A destructive action that gets proposed and confirmed needs to survive across separate requests, not just within one prompt, which most simple agent setups handle incorrectly or not at all.",
    solution:
      "SynapseAI routes every request through a LangGraph StateGraph: a guardrail node validates input, a planner selects the right domain (calendar, email, or task), and destructive actions are proposed rather than executed immediately - the user has to explicitly confirm in a separate follow-up turn before anything irreversible happens. LangGraph's checkpointer persists that pending confirmation by thread ID, so the two-call confirm flow works correctly even across separate HTTP requests.",
    architecture: [
      "LangGraph StateGraph with guardrail, planner, and domain nodes (calendar, email, task) wired via conditional edges",
      "Two-call confirmation flow: destructive actions (send email, delete event, delete task) are proposed first, then only executed after explicit confirmation on a separate turn",
      "SQLite-backed checkpointer persists per-conversation state by thread ID, so pending confirmations survive across requests",
      "ID resolution by fuzzy title matching rather than trusting the LLM to recall a database ID directly",
      "Deterministic offline mode: the full graph and eval suite run with zero API key via a keyword-based mock LLM responder",
      "Three interfaces sharing one compiled graph: CLI, FastAPI HTTP API, and a dependency-free chat web UI",
    ],
    stack: ["Python", "LangGraph", "FastAPI", "Groq", "SQLite"],
    highlights: [
      "Destructive actions require explicit confirmation on a separate turn, not just a single ambiguous instruction",
      "Runs fully offline with zero API key via a deterministic mock LLM mode",
      "Built-in evaluation suite scoring routing accuracy, confirmation-gating accuracy, and completeness",
      "Guardrails tuned deliberately - PII redaction skips email addresses since reading and writing them is the assistant's core job",
    ],
    impactStats: [
      "Two-turn confirm-before-destructive-action flow",
      "Runs offline with zero API key required",
      "Built-in eval suite for routing + confirmation accuracy",
    ],
    accent: "accent",
    repoUrl: "https://github.com/joramkirubi/SynapseAI",
  },
];

export function getProject(slug: string) {
  return projects.find((p) => p.slug === slug);
}
