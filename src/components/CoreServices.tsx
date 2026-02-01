const SERVICES = [
  {
    title: "Meal on Desk",
    desc: "Daily employee meals delivered fresh to desks. No cafeteria queues, no hassle.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
    ),
  },
  {
    title: "Online Ordering",
    desc: "Smart dashboard for HR & employees. Set menus, track orders, manage preferences.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
      </svg>
    ),
  },
  {
    title: "Healthy Snacks",
    desc: "Nutrition-focused options. Customizable dietary filters and wellness programs.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
      </svg>
    ),
  },
  {
    title: "Cafeteria Management",
    desc: "End-to-end cafeteria outsourcing. We handle operations, you focus on business.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 21h19.5m-18-18v18m10.5-18v18m6-13.5V21M6.75 6.75h.75m-.75 3h.75m-.75 3h.75m3-6h.75m-.75 3h.75m-.75 3h.75M6.75 21v-3.375c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21M3 3h12m-.75 4.5H21m-3.75 3.75h.008v.008h-.008v-.008zm0 3h.008v.008h-.008v-.008zm0 3h.008v.008h-.008v-.008z" />
      </svg>
    ),
  },
];

export default function CoreServices() {
  return (
    <section id="solutions" className="section-padding bg-white">
      <div className="container-custom">
        <div className="text-center max-w-2xl mx-auto mb-14 lg:mb-16">
          <p className="section-label text-coral mb-4">What we offer</p>
          <h2 className="section-heading mb-4">Core Services</h2>
          <p className="text-charcoal/60 text-[17px] leading-relaxed">
            Everything you need to elevate workplace dining — from desk delivery to full cafeteria management.
          </p>
        </div>
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6 lg:gap-6">
          {SERVICES.map((s) => (
            <div
              key={s.title}
              className="group rounded-card-lg bg-beige-soft/60 p-6 lg:p-7 border border-charcoal/[0.06] hover:border-charcoal/[0.08] hover:shadow-soft transition-all duration-200"
            >
              <div className="w-11 h-11 rounded-lg bg-coral-muted text-coral flex items-center justify-center mb-5 group-hover:bg-coral group-hover:text-white transition-colors duration-200">
                {s.icon}
              </div>
              <h3 className="font-serif text-lg font-bold text-charcoal mb-2">
                {s.title}
              </h3>
              <p className="text-charcoal/60 text-[15px] leading-relaxed">
                {s.desc}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}