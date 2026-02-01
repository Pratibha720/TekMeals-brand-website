import Link from "next/link";

const QUICK_LINKS = [
  { href: "#solutions", label: "Solutions" },
  { href: "#philosophy", label: "Philosophy" },
  { href: "#partners", label: "Partner Program" },
  { href: "#about", label: "About Us" },
  { href: "#contact", label: "Contact" },
];

const LEGAL = [
  { href: "#privacy", label: "Privacy Policy" },
  { href: "#terms", label: "Terms" },
  { href: "#careers", label: "Careers" },
];

const SOCIAL = [
  { href: "#linkedin", label: "LinkedIn", icon: "M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z" },
  { href: "#twitter", label: "Twitter", icon: "M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" },
];

export default function Footer() {
  return (
    <footer id="contact" className="bg-charcoal-deep text-beige-soft relative overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_60%_80%_at_80%_100%,rgba(220,74,45,0.05),transparent)] pointer-events-none" />
      <div className="container-custom section-padding relative">
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-12 lg:gap-16">
          <div className="lg:col-span-2">
            <Link href="/" className="inline-block font-serif text-xl font-bold text-white mb-5 tracking-tight">
              TekMeals
            </Link>
            <p className="text-beige-soft/65 max-w-sm text-[15px] leading-relaxed mb-6">
              Smart food solutions for modern workplaces. Elevating corporate dining with customized cafeteria solutions, smart ordering, and curated meals.
            </p>
            <div className="space-y-1 text-beige-soft/65 text-[14px]">
              <p>123 Business Park, Suite 400</p>
              <p>San Francisco, CA 94107</p>
              <p>
                <a href="mailto:hello@tekmeals.com" className="hover:text-coral transition-colors">
                  hello@tekmeals.com
                </a>
              </p>
              <p>
                <a href="tel:+15551234567" className="hover:text-coral transition-colors">
                  +1 (555) 123-4567
                </a>
              </p>
            </div>
          </div>
          <div>
            <h4 className="font-semibold text-white text-[15px] mb-4">Quick Links</h4>
            <ul className="space-y-2.5">
              {QUICK_LINKS.map((link) => (
                <li key={link.href}>
                  <Link href={link.href} className="text-beige-soft/65 hover:text-coral text-[15px] transition-colors">
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
          <div>
            <h4 className="font-semibold text-white text-[15px] mb-4">Legal</h4>
            <ul className="space-y-2.5">
              {LEGAL.map((link) => (
                <li key={link.href}>
                  <Link href={link.href} className="text-beige-soft/65 hover:text-coral text-[15px] transition-colors">
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
            <div className="flex gap-2.5 mt-6">
              {SOCIAL.map((s) => (
                <a
                  key={s.label}
                  href={s.href}
                  className="w-10 h-10 rounded-lg bg-white/5 flex items-center justify-center text-beige-soft/80 hover:bg-coral hover:text-white transition-colors duration-200"
                  aria-label={s.label}
                >
                  <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                    <path d={s.icon} />
                  </svg>
                </a>
              ))}
            </div>
          </div>
        </div>
        <div className="mt-16 pt-8 border-t border-white/10 text-center text-beige-soft/50 text-[14px]">
          &copy; {new Date().getFullYear()} TekMeals. All rights reserved.
        </div>
      </div>
    </footer>
  );
}
