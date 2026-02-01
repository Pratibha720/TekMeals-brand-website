const STEPS = [
  {
    title: "Set Weekly Menu",
    desc: "HR or admin sets the weekly menu. Employees see options in advance.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
      </svg>
    ),
  },
  {
    title: "Employees Place Orders",
    desc: "Easy online ordering. Dietary filters, preferences, and deadlines built in.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z" />
      </svg>
    ),
  },
  {
    title: "Fresh Kitchen Preparation",
    desc: "Partner kitchens prepare meals fresh. Quality checks at every step.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
      </svg>
    ),
  },
  {
    title: "Corporate Delivery",
    desc: "Meals delivered to desks on time. No queues, no cafeteria hassle.",
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24" strokeWidth={1.5}>
        <path strokeLinecap="round" strokeLinejoin="round" d="M8.25 18.75a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h6m-9v-3H3.375a1.125 1.125 0 01-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 00-3.213-9.193 2.056 2.056 0 00-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 00-10.026 0 1.106 1.106 0 00-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12" />
      </svg>
    ),
  },
];

export default function HowItWorks() {
  return (
    <section className="section-padding bg-charcoal-deep text-beige-soft">
      <div className="container-custom">
        <div className="text-center max-w-2xl mx-auto mb-14 lg:mb-16">
          <p className="section-label text-coral mb-4">Process</p>
          <h2 className="section-heading text-white mb-4">How It Works</h2>
          <p className="text-beige-soft/60 text-[17px] leading-relaxed">
            From menu planning to desk delivery — a seamless, reliable process built for scale.
          </p>
        </div>
        <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-6 lg:gap-6">
          {STEPS.map((step, i) => (
            <div key={step.title} className="relative">
              <div className="relative rounded-card-lg bg-white/[0.04] border border-white/[0.08] p-6 lg:p-7 hover:border-white/[0.12] transition-colors duration-200 h-full flex flex-col">
                <div className="w-11 h-11 rounded-lg bg-coral/15 text-coral flex items-center justify-center mb-5">
                  {step.icon}
                </div>
                <p className="text-coral/80 text-[13px] font-medium mb-1">Step {i + 1}</p>
                <h3 className="font-serif text-lg font-bold text-white mb-2">{step.title}</h3>
                <p className="text-beige-soft/60 text-[15px] leading-relaxed flex-1">{step.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
