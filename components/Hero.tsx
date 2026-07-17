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
          className="mt-6 max-w-2xl text-balance text-base leading-relaxed text-muted sm:text-lg"
        >
          I design and build intelligent systems â€” from multi-agent AI
          platforms to real-world data and fintech infrastructure.
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
