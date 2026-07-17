import { ImageResponse } from "next/og";
import { site } from "@/lib/site";

export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function OpengraphImage() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          padding: "80px",
          background: "#05060a",
          backgroundImage:
            "radial-gradient(circle at 15% 15%, rgba(94,234,212,0.18), transparent 55%), radial-gradient(circle at 85% 85%, rgba(129,140,248,0.16), transparent 55%)",
        }}
      >
        <div
          style={{
            display: "flex",
            alignItems: "center",
            gap: 12,
            fontSize: 26,
            fontFamily: "monospace",
            color: "#5eead4",
          }}
        >
          {"// "}joram.kirubi
        </div>

        <div
          style={{
            display: "flex",
            marginTop: 28,
            fontSize: 72,
            fontWeight: 700,
            color: "#ffffff",
          }}
        >
          {site.name}
        </div>

        <div
          style={{
            display: "flex",
            marginTop: 14,
            fontSize: 40,
            fontWeight: 600,
            backgroundImage: "linear-gradient(90deg, #5eead4, #818cf8)",
            backgroundClip: "text",
            color: "transparent",
          }}
        >
          {site.title}
        </div>

        <div
          style={{
            display: "flex",
            marginTop: 30,
            fontSize: 26,
            color: "#8a93a6",
            maxWidth: 900,
            lineHeight: 1.5,
          }}
        >
          Building intelligent systems - from multi-agent AI platforms to
          real-world data and fintech infrastructure.
        </div>
      </div>
    ),
    { ...size }
  );
}
