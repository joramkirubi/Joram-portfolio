"use client";

import { motion } from "framer-motion";
import { Blocks, Brain, Database } from "lucide-react";

const pillars = [
  {
    icon: Blocks,
    title: "Systems Thinking",
    body: "I design for how components fit together — data flow, failure modes, and long-term maintainability — not just individual features.",
  },
  {
    icon: Brain,
    title: "AI + Backend Integration",
    body: "I build agentic systems that are grounded in solid backend engineering: real APIs, real databases, real constraints — not just prompts.",
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
              backend infrastructure, coordinated AI agent systems, and the
              data pipelines that connect them.
            </p>
            <p className="mt-4 leading-relaxed text-muted">
              Whether it&apos;s turning raw M-Pesa SMS into structured
              financial insight, orchestrating specialist AI agents with
              LangGraph, or migrating a production database without losing
              data integrity — I care about the same thing: building systems
              that actually work under real conditions.
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
