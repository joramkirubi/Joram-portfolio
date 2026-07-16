"use client";

import { motion } from "framer-motion";
import { ArrowUpRight, Mail } from "lucide-react";
import { GithubIcon, LinkedinIcon } from "@/components/icons";

const links = [
  {
    label: "Email",
    href: "mailto:joramkirubi100@gmail.com",
    handle: "joramkirubi100@gmail.com",
    icon: Mail,
  },
  {
    label: "GitHub",
    href: "https://github.com/joramkirubi",
    handle: "@joramkirubi",
    icon: GithubIcon,
  },
  {
    label: "LinkedIn",
    href: "https://www.linkedin.com/in/joram-kirubi-499683331/",
    handle: "joram-kirubi",
    icon: LinkedinIcon,
  },
];

export default function Contact() {
  return (
    <section id="contact" className="relative border-t border-border px-6 py-28 md:py-36">
      <div
        className="pointer-events-none absolute bottom-0 left-1/2 h-72 w-72 -translate-x-1/2 rounded-full bg-primary/10 blur-[120px]"
        aria-hidden
      />
      <div className="relative z-10 mx-auto max-w-3xl text-center">
        <motion.div
          initial={{ opacity: 0, y: 16 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
        >
          <span className="font-mono text-xs uppercase tracking-widest text-primary">
            Get In Touch
          </span>
          <h2 className="mt-3 text-3xl font-semibold tracking-tight text-white sm:text-4xl">
            Let&apos;s build something intelligent.
          </h2>
          <p className="mx-auto mt-4 max-w-xl text-muted">
            Open to backend engineering and agentic AI opportunities. The
            fastest way to reach me is email, GitHub, or LinkedIn.
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.15 }}
          className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-3"
        >
          {links.map((link) => (
            <a
              key={link.label}
              href={link.href}
              target={link.href.startsWith("http") ? "_blank" : undefined}
              rel={link.href.startsWith("http") ? "noopener noreferrer" : undefined}
              className="card-glow group flex items-center justify-between rounded-2xl border border-border bg-surface/60 p-6 text-left shadow-card backdrop-blur-sm transition-all hover:-translate-y-1 hover:border-primary/40 hover:shadow-glow"
            >
              <div className="flex items-center gap-4">
                <div className="flex h-11 w-11 items-center justify-center rounded-lg bg-primary/10 text-primary">
                  <link.icon size={20} />
                </div>
                <div>
                  <p className="font-medium text-white">{link.label}</p>
                  <p className="text-sm text-muted break-all">{link.handle}</p>
                </div>
              </div>
              <ArrowUpRight
                size={18}
                className="ml-3 shrink-0 text-muted transition-all group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-white"
              />
            </a>
          ))}
        </motion.div>
      </div>
    </section>
  );
}
