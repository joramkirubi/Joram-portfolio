import type { Metadata } from "next";
import "./globals.css";
import Nav from "@/components/Nav";
import Footer from "@/components/Footer";

export const metadata: Metadata = {
  title: "Joram Kirubi — Agentic AI & Backend Engineer",
  description:
    "Joram Kirubi designs and builds intelligent systems — from multi-agent AI platforms to real-world data and fintech infrastructure.",
  metadataBase: new URL("https://joramkirubi.dev"),
  openGraph: {
    title: "Joram Kirubi — Agentic AI & Backend Engineer",
    description:
      "I design and build intelligent systems — from multi-agent AI platforms to real-world data and fintech infrastructure.",
    type: "website",
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="font-sans antialiased bg-background text-white min-h-screen flex flex-col">
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
        <main className="relative z-10 flex-1">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
