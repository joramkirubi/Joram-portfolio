"use client";

import Link from "next/link";
import { motion } from "framer-motion";
import { ArrowUpRight } from "lucide-react";
import type { Project } from "@/lib/projects";

export default function ProjectCard({
  project,
  index,
}: {
  project: Project;
  index: number;
}) {
  const accentText =
    project.accent === "primary" ? "text-primary" : "text-accent";
  const accentBorder =
    project.accent === "primary" ? "hover:border-primary/40" : "hover:border-accent/40";
  const accentShadow =
    project.accent === "primary" ? "hover:shadow-glow" : "hover:shadow-glow-accent";

  return (
    <motion.div
      initial={{ opacity: 0, y: 24 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-80px" }}
      transition={{ duration: 0.6, delay: index * 0.1, ease: [0.22, 1, 0.36, 1] }}
    >
      <Link
        href={`/projects/${project.slug}`}
        className={`card-glow group relative flex h-full flex-col justify-between rounded-2xl border border-border bg-surface/60 p-7 shadow-card backdrop-blur-sm transition-all duration-300 ${accentBorder} ${accentShadow} hover:-translate-y-1`}
      >
        <div>
          <div className="flex items-start justify-between gap-4">
            <span
              className={`font-mono text-[11px] uppercase tracking-widest ${accentText}`}
            >
              {project.type}
            </span>
            <ArrowUpRight
              size={18}
              className="shrink-0 text-muted transition-all duration-300 group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-white"
            />
          </div>

          <h3 className="mt-4 text-xl font-semibold text-white">
            {project.name}
          </h3>
          <p className="mt-3 text-sm leading-relaxed text-muted">
            {project.tagline}
          </p>
        </div>

        <div className="mt-6 flex flex-wrap gap-2">
          {project.stack.slice(0, 4).map((tech) => (
            <span
              key={tech}
              className="rounded-md border border-border bg-surface2 px-2.5 py-1 font-mono text-[11px] text-muted"
            >
              {tech}
            </span>
          ))}
          {project.stack.length > 4 && (
            <span className="rounded-md border border-border bg-surface2 px-2.5 py-1 font-mono text-[11px] text-muted">
              +{project.stack.length - 4}
            </span>
          )}
        </div>
      </Link>
    </motion.div>
  );
}
