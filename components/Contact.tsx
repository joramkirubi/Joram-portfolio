"use client";

import { motion } from "framer-motion";
import { ArrowUpRight, CalendarClock, FileDown, Mail } from "lucide-react";
import { GithubIcon, LinkedinIcon } from "@/components/icons";
import { site } from "@/lib/site";

const links = [
  {
    label: "Email",
    href: `mailto:${site.email}`,
    handle: site.email,
    icon: Mail,
  },
  {
    label: "Schedule a Call",
    href: site.calendly,
    handle: "Book 30 min",
    icon: CalendarClock,
  },
  {
    label: "Resume",
    href: site.resumeUrl,
    handle: "Download PDF",
    icon: FileDown,
  },
  {
    label: "GitHub",
    href: site.github,
    handle: "@joramkirubi",
    icon: GithubIcon,
  },
  {
    label: "LinkedIn",
    href: site.linkedin,
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
            Open to backend engineering and agentic AI opportunities. Grab
            time on my calendar, download my resume, or reach out directly.
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6, delay: 0.15 }}
          className="mt-10 grid gap-4 sm:grid-cols-2"
        >
          {links.map((link, index) => {
            const isLastOdd =
              index === links.length - 1 && links.length % 2 !== 0;
            const isExternal = link.href.startsWith("http");
            return (
              <a
                key={link.label}
                href={link.href}
                target={isExternal ? "_blank" : undefined}
                rel={isExternal ? "noopener noreferrer" : undefined}
                download={link.label === "Resume" ? true : undefined}
                className={`card-glow group flex items-center justify-between rounded-2xl border border-border bg-surface/60 p-6 text-left shadow-card backdrop-blur-sm transition-all hover:-translate-y-1 hover:border-primary/40 hover:shadow-glow ${
                  isLastOdd ? "sm:col-span-2" : ""
                }`}
              >
                <div className="flex items-center gap-4">
                  <div className="flex h-11 w-11 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
                    <link.icon size={20} />
                  </div>
                  <div>
                    <p className="font-medium text-white">{link.label}</p>
                    <p className="text-sm text-muted break-all">
                      {link.handle}
                    </p>
                  </div>
                </div>
                <ArrowUpRight
                  size={18}
                  className="ml-3 shrink-0 text-muted transition-all group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-white"
                />
              </a>
            );
          })}
        </motion.div>
      </div>
    </section>
  );
}
