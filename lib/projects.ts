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
    accent: "primary",
  },
];

export function getProject(slug: string) {
  return projects.find((p) => p.slug === slug);
}
