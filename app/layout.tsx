import type { Metadata } from "next";
import { Analytics } from "@vercel/analytics/next";
import { SpeedInsights } from "@vercel/speed-insights/next";
import "./globals.css";
import Nav from "@/components/Nav";
import Footer from "@/components/Footer";
import { site } from "@/lib/site";

export const metadata: Metadata = {
  title: `${site.name} - ${site.title}`,
  description:
    "Joram Kirubi designs and builds intelligent systems - from specialist AI agents to real-world data and fintech infrastructure.",
  metadataBase: new URL(site.url),
  keywords: [
    "Joram Kirubi",
    "Backend Engineer",
    "Agentic AI Engineer",
    "Data Engineer",
    "FastAPI",
    "Django",
    "LangChain",
    "LangGraph",
    "Kenya software engineer",
  ],
  openGraph: {
    title: `${site.name} - ${site.title}`,
    description:
      "I design and build intelligent systems - from specialist AI agents to real-world data and fintech infrastructure.",
    type: "website",
    url: site.url,
    siteName: site.name,
  },
  twitter: {
    card: "summary_large_image",
    title: `${site.name} - ${site.title}`,
    description:
      "I design and build intelligent systems - from specialist AI agents to real-world data and fintech infrastructure.",
  },
};

const personJsonLd = {
  "@context": "https://schema.org",
  "@type": "Person",
  name: site.name,
  jobTitle: site.title,
  url: site.url,
  email: site.email,
  sameAs: [site.github, site.linkedin],
  knowsAbout: [
    "Backend Engineering",
    "Agentic AI Systems",
    "Data Engineering",
    "Python",
    "FastAPI",
    "Django",
    "LangChain",
    "LangGraph",
    "Retrieval-Augmented Generation",
  ],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="font-sans antialiased bg-background text-white min-h-screen flex flex-col">
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(personJsonLd) }}
        />
        <a
          href="#main-content"
          className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-[100] focus:rounded-lg focus:bg-primary focus:px-4 focus:py-2 focus:text-sm focus:font-semibold focus:text-background"
        >
          Skip to content
        </a>
        <div
          className="pointer-events-none fixed inset-0 bg-[linear-gradient(to_right,rgba(255,255,255,0.035)_1px,transparent_1px),linear-gradient(to_bottom,rgba(255,255,255,0.035)_1px,transparent_1px)] bg-[size:44px_44px] [mask-image:radial-gradient(ellipse_60%_50%_at_50%_0%,black,transparent)]"
          aria-hidden
        />
        <div
          className="pointer-events-none fixed inset-0 bg-[radial-gradient(circle_at_50%_0%,rgba(94,234,212,0.12),transparent_60%)]"
          aria-hidden
        />
        <div className="noise pointer-events-none fixed inset-0" aria-hidden />
        <Nav />
        <main id="main-content" className="relative z-10 flex-1">
          {children}
        </main>
        <Footer />
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
