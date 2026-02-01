import Link from "next/link";

const DASHBOARDS = [
  {
    title: "Corporate Admin Dashboard",
    items: ["Employee management", "Weekly menu planning", "Order analytics", "Billing & invoices"],
  },
  {
    title: "Employee Interface",
    items: ["Browse menu", "Order food", "Preferences & dietary filters"],
  },
  {
    title: "Kitchen Partner Dashboard",
    items: ["Incoming orders", "Preparation timeline", "Payment tracking"],
  },
];

export default function DashboardsMention() {
  return (
    <section className="section-padding bg-beige-soft border-t border-charcoal/[0.06]">
      <div className="container-custom">
        <div className="text-center max-w-2xl mx-auto mb-14 lg:mb-16">
          <p className="section-label text-coral mb-4">Platform</p>
          <h2 className="section-heading mb-4">Powerful Platforms for Everyone</h2>
          <p className="text-charcoal/60 text-[17px] leading-relaxed">
            Dedicated dashboards for admins, employees, and kitchen partners — all integrated, secure, and easy to use.
          </p>
        </div>
        <div className="grid md:grid-cols-3 gap-6 lg:gap-6 mb-12">
          {DASHBOARDS.map((d) => (
            <div
              key={d.title}
              className="rounded-card-lg bg-white p-6 lg:p-7 border border-charcoal/[0.06] hover:border-charcoal/[0.08] hover:shadow-soft transition-all duration-200"
            >
              <h3 className="font-serif text-lg font-bold text-charcoal mb-4">
                {d.title}
              </h3>
              <ul className="space-y-2.5 text-charcoal/65 text-[15px]">
                {d.items.map((i) => (
                  <li key={i} className="flex gap-2.5 items-center">
                    <span className="w-1.5 h-1.5 rounded-full bg-coral flex-shrink-0" />
                    {i}
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
        <div className="text-center">
          <Link href="#get-started" className="btn-primary">
            Get Started
          </Link>
        </div>
      </div>
    </section>
  );
}
