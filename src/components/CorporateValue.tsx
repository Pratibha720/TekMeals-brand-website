import Link from "next/link";
import Image from "next/image";

const BENEFITS = [
  "Reduce HR workload — we handle menus, orders, and logistics",
  "Improve employee satisfaction with fresh, curated meals",
  "Predictable food costs and simple billing",
  "Zero cafeteria hassle — full outsourcing available",
];

export default function CorporateValue() {
  return (
    <section id="about" className="section-padding bg-white">
      <div className="container-custom">
        <div className="grid lg:grid-cols-2 gap-14 lg:gap-16 xl:gap-20 items-center">
          <div className="relative rounded-card-xl overflow-hidden shadow-soft-lg aspect-[4/3] lg:aspect-[5/4] lg:min-h-[420px] ring-1 ring-charcoal/[0.06] order-2 lg:order-1">
            <Image
              src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800&q=85"
              alt="Modern office team collaboration"
              fill
              className="object-cover"
              sizes="(max-width: 1024px) 100vw, 50vw"
            />
          </div>
          <div className="order-1 lg:order-2 max-w-xl">
            <p className="section-label text-coral mb-4">Why partner with us</p>
            <h2 className="section-heading mb-6">Corporate Value Proposition</h2>
            <p className="text-charcoal/60 text-[17px] leading-relaxed mb-10">
              Partner with TekMeals to transform workplace dining — less admin, happier teams, and a dining experience worthy of Fortune 500 standards.
            </p>
            <ul className="space-y-4 mb-10">
              {BENEFITS.map((b) => (
                <li key={b} className="flex gap-3 items-start">
                  <span className="mt-1.5 w-1.5 h-1.5 rounded-full bg-coral flex-shrink-0" />
                  <span className="text-charcoal/80 text-[15px] leading-relaxed">{b}</span>
                </li>
              ))}
            </ul>
            <Link href="#contact" className="btn-primary">
              Schedule a Demo
            </Link>
          </div>
        </div>
      </div>
    </section>
  );
}
