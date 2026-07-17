export default function Footer() {
  return (
    <footer className="relative z-10 border-t border-border">
      <div className="mx-auto flex max-w-6xl flex-col items-center justify-between gap-4 px-6 py-8 text-sm text-muted md:flex-row">
        <p className="font-mono">
          &copy; {new Date().getFullYear()} Joram Kirubi. Built with Next.js &amp;
          Tailwind CSS.
        </p>
        <p>Designed and engineered end to end.</p>
      </div>
    </footer>
  );
}
