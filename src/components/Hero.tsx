import Link from "next/link";
import Image from "next/image";

export default function Hero() {
  return (
    <section
      id="home"
      className="relative overflow-hidden bg-beige-soft"
    >
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_70%_50%_at_50%_-10%,rgba(220,74,45,0.04),transparent)] pointer-events-none" />
      <div className="container-custom section-padding relative">
        <div className="grid lg:grid-cols-2 gap-14 lg:gap-16 xl:gap-20 items-center min-h-[85vh] lg:min-h-[88vh]">
          <div className="order-2 lg:order-1 max-w-xl animate-slide-up">
            <p className="section-label text-coral mb-5">
              We redefine corporate dining
            </p>
            <h1 className="font-serif text-3xl sm:text-4xl lg:text-5xl xl:text-[2.75rem] font-bold text-charcoal leading-[1.12] tracking-tight mb-6">
              Elevate Your Corporate Dining Experience
            </h1>
            <p className="text-[17px] sm:text-lg text-charcoal/60 leading-relaxed mb-10">
              Customized cafeteria solutions, smart ordering, and curated meals designed for modern workplaces.
            </p>
            <div className="flex flex-col sm:flex-row gap-3">
              <Link href="#get-started" className="btn-primary text-[15px] px-6 py-3">
                Sign Up Your Company
              </Link>
              <Link href="#philosophy" className="btn-secondary text-[15px] px-6 py-3">
                Our Philosophy
              </Link>
            </div>
          </div>

          <div className="order-1 lg:order-2 relative flex justify-center lg:justify-end">
            <div className="relative w-full max-w-md lg:max-w-lg xl:max-w-xl">
              <div className="relative rounded-card-xl overflow-hidden shadow-premium aspect-[4/3] lg:aspect-[5/4] ring-1 ring-charcoal/[0.06]">
                <Image
                  src="https://images.unsplash.com/photo-1555244162-803834f70033?w=800&q=85"
                  alt="Premium plated gourmet meal for corporate dining"
                  fill
                  className="object-cover"
                  sizes="(max-width: 1024px) 100vw, 50vw"
                  priority
                />
              </div>
              <div
                className="absolute -bottom-4 left-4 sm:left-0 right-4 sm:right-auto max-w-[280px] bg-white rounded-card-lg shadow-soft-lg p-5 border border-charcoal/[0.06]"
                aria-label="Client testimonial"
              >
                <p className="text-charcoal/80 text-[15px] leading-relaxed mb-4">
                  &ldquo;Best corporate food service we&apos;ve used — seamless & reliable.&rdquo;
                </p>
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-coral-muted flex items-center justify-center text-coral font-semibold text-sm">
                    JM
                  </div>
                  <div>
                    <p className="font-semibold text-charcoal text-[15px]">Jane Mitchell</p>
                    <p className="text-charcoal/55 text-[13px]">HR Director, TechCorp</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
