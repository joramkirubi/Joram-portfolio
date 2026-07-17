import { ImageResponse } from "next/og";

export const size = { width: 180, height: 180 };
export const contentType = "image/png";

export default function AppleIcon() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          background: "#05060a",
          borderRadius: 40,
        }}
      >
        <div
          style={{
            display: "flex",
            fontSize: 72,
            fontWeight: 700,
            fontFamily: "monospace",
            backgroundImage: "linear-gradient(135deg, #5eead4, #818cf8)",
            backgroundClip: "text",
            color: "transparent",
          }}
        >
          JK
        </div>
      </div>
    ),
    { ...size }
  );
}
