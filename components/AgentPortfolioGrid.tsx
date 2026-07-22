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
  {
    name: "SynapseAI",
    repo: "SynapseAI",
    tag: "LangGraph + Confirm Flow",
    description:
      "Calendar, email, and task assistant built on a LangGraph StateGraph, with a two-turn confirm-before-destructive-action flow.",
    accent: "primary",
  },
  {
    name: "PatchPilot",
    repo: "PatchPilot",
    tag: "Tool-Calling Loop + Confirm Gate",
    description:
      "Autonomous coding agent - clones a repo, plans and edits code via tool calls, runs tests in a loop, then asks for confirmation before committing, pushing, and opening a PR.",
    accent: "accent",
  },
  {
    name: "Orchestra",
    repo: "Orchestra.lg",
    tag: "Multi-Agent Orchestration",
    description:
      "Takes a high-level goal, decomposes it into subtasks, and runs a Supervisor, Researcher, Analyst, and Writer in parallel via LangGraph's Send API, with a Critic gating every output and checkpointed resume.",
    accent: "primary",
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

        const isLastOdd =
          index === agentRepos.length - 1 && agentRepos.length % 2 !== 0;

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
            className={`card-glow group flex flex-col justify-between rounded-2xl border border-border bg-surface/50 p-5 transition-all hover:-translate-y-1 ${accentBorder} ${
              isLastOdd ? "sm:col-span-2" : ""
            }`}
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
