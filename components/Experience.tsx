"use client";

import { motion } from "framer-motion";
import { Briefcase } from "lucide-react";

type Job = {
  title: string;
  org: string;
  locationType: string;
  start: string;
  end: string;
  highlights: string[];
  skills: string[];
};

const jobs: Job[] = [
  {
    title: "IT & AI Support Specialist",
    org: "Intex Management Services",
    locationType: "Hybrid",
    start: "Feb 2025",
    end: "Present",
    highlights: [
      "Research",
      "Database Management Systems",
      "Back-end Systems",
      "Customisation",
      "SSO Configuration",
    ],
    skills: [
      "AWS",
      "SaaS",
      "VMware",
      "Excel",
      "Windows Server",
      "Knowledge Engineering",
      "SQL Server",
      "Python",
      "AI Engineering",
      "SSO",
      "Quality Management",
      "ISO Standards",
    ],
  },
];

export default function Experience() {
  return (
    <section
      id="experience"
      className="relative border-t border-border px-6 py-28 md:py-36"
    >
      <div className="mx-auto max-w-6xl">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="mb-14 max-w-2xl"
        >
          <span className="font-mono text-xs uppercase tracking-widest text-primary">
            Experience
          </span>
          <h2 className="mt-3 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
            Professional Experience
          </h2>
          <p className="mt-4 text-muted">
            Real production systems, real clients - not just side projects.
          </p>
        </motion.div>

        <div className="space-y-5">
          {jobs.map((job, index) => (
            <motion.div
              key={job.org}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true, margin: "-60px" }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              className="card-glow rounded-2xl border border-border bg-surface/60 p-6 shadow-card backdrop-blur-sm transition-colors hover:border-primary/30 sm:p-8"
            >
              <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
                <div className="flex items-start gap-4">
                  <div className="mt-0.5 flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
                    <Briefcase size={20} />
                  </div>
                  <div>
                    <h3 className="text-lg font-semibold text-white">
                      {job.title}
                    </h3>
                    <p className="mt-0.5 text-sm text-muted">{job.org}</p>
                  </div>
                </div>
                <div className="font-mono text-xs text-muted sm:text-right">
                  <p>
                    {job.start} - {job.end}
                  </p>
                  <p className="mt-1">{job.locationType}</p>
                </div>
              </div>

              <div className="mt-6 flex flex-wrap gap-2">
                {job.highlights.map((highlight) => (
                  <span
                    key={highlight}
                    className="rounded-md border border-border bg-surface2 px-3 py-1.5 text-sm text-white/90"
                  >
                    {highlight}
                  </span>
                ))}
              </div>

              <div className="mt-4 flex flex-wrap gap-2">
                {job.skills.map((skill) => (
                  <span
                    key={skill}
                    className="rounded-md border border-border/60 bg-transparent px-2.5 py-1 font-mono text-[11px] text-muted"
                  >
                    {skill}
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
