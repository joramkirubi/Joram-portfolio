# ==============================================================
# Portfolio update script #3 - adds animated architecture diagram
# to the Multi-Agent AI Platform case study page.
# Usage:  .\update-portfolio-3.ps1
# ==============================================================

Write-Host "Starting portfolio update #3..." -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path "app\projects\[slug]" | Out-Null

# ---- components\MultiAgentDiagram.tsx ----
@'
"use client";

import { motion, type Variants } from "framer-motion";

type Agent = {
  name: string;
  role: string;
  tool: string;
};

const agents: Agent[] = [
  { name: "Medical", role: "RAG-grounded Q&A", tool: "Medical KB (RAG)" },
  { name: "Research", role: "Multi-step retrieval", tool: "Papers + Search" },
  { name: "Publication", role: "Structured drafting", tool: "Doc Templates" },
  { name: "Support", role: "Intent + escalation", tool: "Knowledge Base" },
];

// Layout constants (viewBox units)
const boxWidth = 150;
const gap = 16;
const totalWidth = agents.length * boxWidth + (agents.length - 1) * gap;
const startX = (720 - totalWidth) / 2;
const centers = agents.map((_, i) => startX + i * (boxWidth + gap) + boxWidth / 2);

const orchestratorCenter = { x: 360, y: 108 };
const agentTop = 176;
const agentHeight = 66;
const agentBottom = agentTop + agentHeight;
const toolTop = 278;
const toolHeight = 40;

const lineVariants: Variants = {
  hidden: { pathLength: 0, opacity: 0 },
  show: (i: number) => ({
    pathLength: 1,
    opacity: 1,
    transition: { duration: 0.7, delay: 0.15 + i * 0.1, ease: [0.22, 1, 0.36, 1] },
  }),
};

export default function MultiAgentDiagram() {
  return (
    <motion.div
      initial={{ opacity: 0, y: 16 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-60px" }}
      transition={{ duration: 0.6 }}
      className="rounded-2xl border border-border bg-surface/50 p-4 sm:p-6"
    >
      <svg
        viewBox="0 0 720 400"
        className="w-full h-auto"
        role="img"
        aria-label="Architecture diagram: incoming requests are routed by a LangGraph orchestrator to four specialist agents (Medical Assistant, Research Assistant, Publication Assistant, Customer Support Assistant), each backed by its own retrieval and tool source, with LangSmith tracing every agent's execution."
      >
        <defs>
          <marker
            id="arrow"
            viewBox="0 0 10 10"
            refX="8"
            refY="5"
            markerWidth="7"
            markerHeight="7"
            orient="auto-start-reverse"
          >
            <path d="M 0 0 L 10 5 L 0 10 z" fill="#2b3242" />
          </marker>
        </defs>

        {/* Surrounding tracing boundary */}
        <rect
          x="16"
          y="64"
          width="688"
          height="270"
          rx="16"
          fill="none"
          stroke="#2b3242"
          strokeWidth="1.5"
          strokeDasharray="6 6"
        />

        {/* Incoming request pill */}
        <rect x="260" y="8" width="200" height="36" rx="18" fill="#10141d" stroke="#5eead4" strokeWidth="1.5" />
        <text x="360" y="31" textAnchor="middle" className="font-mono" fontSize="12" fill="#5eead4">
          Incoming Request
        </text>

        {/* Line: request -> orchestrator */}
        <motion.path
          d="M 360 44 L 360 74"
          stroke="#2b3242"
          strokeWidth="1.5"
          markerEnd="url(#arrow)"
          custom={0}
          variants={lineVariants}
          initial="hidden"
          whileInView="show"
          viewport={{ once: true }}
        />

        {/* Orchestrator */}
        <rect x="210" y="76" width="300" height="64" rx="12" fill="#10141d" stroke="#818cf8" strokeWidth="1.5" />
        <text x={orchestratorCenter.x} y="102" textAnchor="middle" fontSize="14" fontWeight="600" fill="#ffffff">
          LangGraph Orchestrator
        </text>
        <text x={orchestratorCenter.x} y="124" textAnchor="middle" className="font-mono" fontSize="10.5" fill="#8a93a6">
          stateful routing + shared memory
        </text>

        {/* Lines: orchestrator -> each agent */}
        {centers.map((cx, i) => (
          <motion.path
            key={`orch-line-${i}`}
            d={`M 360 140 L ${cx} ${agentTop - 2}`}
            stroke="#2b3242"
            strokeWidth="1.5"
            markerEnd="url(#arrow)"
            fill="none"
            custom={i + 1}
            variants={lineVariants}
            initial="hidden"
            whileInView="show"
            viewport={{ once: true }}
          />
        ))}

        {/* Agent boxes */}
        {agents.map((agent, i) => {
          const x = startX + i * (boxWidth + gap);
          const accentColor = i % 2 === 0 ? "#5eead4" : "#818cf8";
          return (
            <g key={agent.name}>
              <rect
                x={x}
                y={agentTop}
                width={boxWidth}
                height={agentHeight}
                rx="10"
                fill="#0b0e14"
                stroke={accentColor}
                strokeOpacity="0.55"
                strokeWidth="1.5"
              />
              <text
                x={x + boxWidth / 2}
                y={agentTop + 26}
                textAnchor="middle"
                fontSize="12"
                fontWeight="600"
                fill="#ffffff"
              >
                {agent.name}
              </text>
              <text
                x={x + boxWidth / 2}
                y={agentTop + 46}
                textAnchor="middle"
                className="font-mono"
                fontSize="9.5"
                fill="#8a93a6"
              >
                {agent.role}
              </text>
            </g>
          );
        })}

        {/* Lines: agent -> tool */}
        {centers.map((cx, i) => (
          <motion.path
            key={`tool-line-${i}`}
            d={`M ${cx} ${agentBottom} L ${cx} ${toolTop - 2}`}
            stroke="#2b3242"
            strokeWidth="1.5"
            markerEnd="url(#arrow)"
            fill="none"
            custom={i + 5}
            variants={lineVariants}
            initial="hidden"
            whileInView="show"
            viewport={{ once: true }}
          />
        ))}

        {/* Tool / retrieval tags */}
        {agents.map((agent, i) => {
          const x = startX + i * (boxWidth + gap);
          return (
            <g key={`tool-${agent.name}`}>
              <rect
                x={x}
                y={toolTop}
                width={boxWidth}
                height={toolHeight}
                rx="8"
                fill="#10141d"
                stroke="#1e2430"
                strokeWidth="1.5"
              />
              <text
                x={x + boxWidth / 2}
                y={toolTop + 25}
                textAnchor="middle"
                className="font-mono"
                fontSize="10"
                fill="#8a93a6"
              >
                {agent.tool}
              </text>
            </g>
          );
        })}

        {/* LangSmith label */}
        <text x="360" y="360" textAnchor="middle" className="font-mono" fontSize="11" fill="#5eead4">
          LangSmith: full tracing + evaluation across every agent
        </text>
      </svg>
    </motion.div>
  );
}
'@ | Set-Content -LiteralPath "components\MultiAgentDiagram.tsx" -Encoding utf8
Write-Host "  wrote components\MultiAgentDiagram.tsx" -ForegroundColor Green

# ---- app\projects\[slug]\page.tsx ----
@'
import { notFound } from "next/navigation";
import Link from "next/link";
import type { Metadata } from "next";
import { ArrowLeft, ArrowUpRight, CheckCircle2 } from "lucide-react";
import { projects, getProject } from "@/lib/projects";
import { site } from "@/lib/site";
import CaseStudyAnimated from "@/components/CaseStudyAnimated";
import MultiAgentDiagram from "@/components/MultiAgentDiagram";

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
              <h2 className="text-xl font-semibold text-white">System Architecture</h2>
              <p className="mt-3 leading-relaxed text-muted">
                A single orchestrator routes each incoming request to the
                right specialist agent, which retrieves from its own source
                and calls its own tools. Every agent&apos;s execution is
                traced end to end.
              </p>
              <div className="mt-6">
                <MultiAgentDiagram />
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

Write-Host ""
Write-Host "Running lint..." -ForegroundColor Cyan
npm run lint

Write-Host ""
Write-Host "Running production build..." -ForegroundColor Cyan
npm run build

Write-Host ""
Write-Host "Done. Check the build output above. If clean, git add / commit / push." -ForegroundColor Cyan
