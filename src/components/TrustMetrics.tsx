const METRICS = [
  { value: "12+", label: "Years Experience" },
  { value: "30K+", label: "Meals Delivered Daily" },
  { value: "500+", label: "Corporate Clients" },
  { value: "200+", label: "Kitchen Partners" },
];

export default function TrustMetrics() {
  return (
    <section className="bg-charcoal text-beige-soft py-16 lg:py-20 relative overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_80%_50%_at_50%_50%,rgba(220,74,45,0.06),transparent)] pointer-events-none" />
      <div className="container-custom relative px-5 sm:px-6 lg:px-8">
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-8 lg:gap-12">
          {METRICS.map((m, i) => (
            <div
              key={m.label}
              className={`text-center ${i < 3 ? "lg:border-r lg:border-white/10" : ""}`}
            >
              <p className="font-serif text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-1.5">
                {m.value}
              </p>
              <p className="text-beige-soft/60 text-[13px] sm:text-sm font-medium">
                {m.label}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
