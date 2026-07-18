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
      "Guardrails",
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
