/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        charcoal: "#0f172a",
        "charcoal-deep": "#020617",
        "charcoal-muted": "#475569",
        coral: "#dc4a2d",
        "coral-burnt": "#b83d24",
        "coral-muted": "#fdf2ef",
        beige: "#f8f6f3",
        "beige-soft": "#fdfcfa",
        "beige-border": "#eae6e1",
        gold: "#b8860b",
        "gold-light": "#e8d48a",
        teal: "#0f766e",
        "teal-muted": "#14b8a6",
        emerald: "#059669",
        "emerald-muted": "#10b981",
        slate: {
          50: "#f8fafc",
          100: "#f1f5f9",
          200: "#e2e8f0",
          300: "#cbd5e1",
          400: "#94a3b8",
          500: "#64748b",
          600: "#475569",
          700: "#334155",
          800: "#1e293b",
          900: "#0f172a",
        },
      },
      fontFamily: {
        serif: ["var(--font-playfair)", "Georgia", "serif"],
        sans: ["var(--font-dm-sans)", "system-ui", "sans-serif"],
      },
      fontSize: {
        "label": ["0.75rem", { lineHeight: "1.25", letterSpacing: "0.08em" }],
        "display": ["clamp(2.5rem,5vw,3.75rem)", { lineHeight: "1.1", letterSpacing: "-0.02em" }],
      },
      borderRadius: {
        card: "12px",
        "card-lg": "16px",
        "card-xl": "20px",
      },
      boxShadow: {
        soft: "0 1px 3px rgba(0,0,0,0.04), 0 6px 16px -4px rgba(0,0,0,0.06)",
        "soft-lg": "0 4px 6px -2px rgba(0,0,0,0.04), 0 12px 24px -8px rgba(0,0,0,0.08)",
        glass: "0 8px 32px rgba(0,0,0,0.06)",
        premium: "0 24px 48px -12px rgba(0,0,0,0.12), 0 0 0 1px rgba(0,0,0,0.04)",
        "card-hover": "0 32px 64px -16px rgba(0,0,0,0.12), 0 0 0 1px rgba(0,0,0,0.04)",
        "glow-gold": "0 0 40px -8px rgba(184,134,11,0.2)",
        "glow-coral": "0 0 40px -8px rgba(220,74,45,0.25)",
      },
      animation: {
        "fade-in": "fadeIn 0.5s ease-out",
        "slide-up": "slideUp 0.6s cubic-bezier(0.16,1,0.3,1)",
        "scale-in": "scaleIn 0.4s ease-out",
      },
      keyframes: {
        fadeIn: {
          "0%": { opacity: "0" },
          "100%": { opacity: "1" },
        },
        slideUp: {
          "0%": { opacity: "0", transform: "translateY(24px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        scaleIn: {
          "0%": { opacity: "0", transform: "scale(0.98)" },
          "100%": { opacity: "1", transform: "scale(1)" },
        },
      },
      backgroundImage: {
        "gradient-radial": "radial-gradient(var(--tw-gradient-stops))",
        "menu-overlay": "linear-gradient(to top, rgba(2,6,23,0.85) 0%, transparent 50%)",
      },
    },
  },
  plugins: [],
};
