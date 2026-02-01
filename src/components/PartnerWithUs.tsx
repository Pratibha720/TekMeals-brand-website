import Link from "next/link";

const CARDS = [
  {
    title: "Become a Partner",
    sub: "For kitchens & restaurants",
    points: ["Steady corporate orders", "Tech platform & logistics support", "Growth without marketing overhead"],
    cta: "Become a Partner",
    href: "#partners",
    accent: "coral",
  },
  {
    title: "Onboard Your Cafeteria",
    sub: "For corporates",
    points: ["Full cafeteria outsourcing", "Custom menus & branding", "Dedicated account management"],
    cta: "Get in Touch",
    href: "#contact",
    accent: "teal",
  },
];

export default function PartnerWithUs() {
  return (
    <section id="partners" className="section-padding bg-white">
      <div className="container-custom">
        <div className="text-center max-w-2xl mx-auto mb-14 lg:mb-16">
          <p className="section-label text-coral mb-4">Partnerships</p>
          <h2 className="section-heading mb-4">Partner With Us</h2>
          <p className="text-charcoal/60 text-[17px] leading-relaxed">
            Whether you run a kitchen or a corporate cafeteria — we have a solution for you.
          </p>
        </div>
        <div className="grid md:grid-cols-2 gap-6 lg:gap-8 max-w-4xl mx-auto">
          {CARDS.map((c) => (
            <div
              key={c.title}
              className="rounded-card-lg bg-beige-soft/60 p-7 lg:p-8 border border-charcoal/[0.06] hover:border-charcoal/[0.08] hover:shadow-soft transition-all duration-200"
            >
              <h3 className="font-serif text-xl font-bold text-charcoal mb-1">
                {c.title}
              </h3>
              <p className="text-charcoal/55 text-[14px] mb-6">{c.sub}</p>
              <ul className="space-y-3 mb-8">
                {c.points.map((p) => (
                  <li key={p} className="flex gap-2.5 items-center text-charcoal/75 text-[15px]">
                    <span
                      className={`w-1.5 h-1.5 rounded-full flex-shrink-0 ${
                        c.accent === "coral" ? "bg-coral" : "bg-teal-muted"
                      }`}
                    />
                    {p}
                  </li>
                ))}
              </ul>
              <Link
                href={c.href}
                className={`inline-flex items-center justify-center px-5 py-2.5 rounded-lg font-medium text-[15px] transition-all duration-200 ${
                  c.accent === "coral"
                    ? "bg-coral text-white hover:bg-coral-burnt"
                    : "bg-teal-muted text-white hover:bg-teal"
                }`}
              >
                {c.cta}
              </Link>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
