import { notFound } from "next/navigation";
import Link from "next/link";
import type { Metadata } from "next";
import { ArrowLeft, ArrowUpRight, CheckCircle2 } from "lucide-react";
import { projects, getProject } from "@/lib/projects";
import { site } from "@/lib/site";
import CaseStudyAnimated from "@/components/CaseStudyAnimated";
import AgentPortfolioGrid from "@/components/AgentPortfolioGrid";

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
              <h2 className="text-xl font-semibold text-white">The Agents</h2>
              <p className="mt-3 leading-relaxed text-muted">
                Four standalone agents, each designed and shipped
                independently rather than sharing one framework. Every repo
                below is public - click through to see the actual code.
              </p>
              <div className="mt-6">
                <AgentPortfolioGrid />
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
