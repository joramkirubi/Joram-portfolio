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
