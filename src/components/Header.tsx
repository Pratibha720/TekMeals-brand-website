"use client";

import { useState } from "react";
import Link from "next/link";

const NAV_LINKS = [
  { href: "#home", label: "Home" },
  { href: "#solutions", label: "Solutions" },
  { href: "#philosophy", label: "Philosophy" },
  { href: "#partners", label: "Partners" },
  { href: "#about", label: "About Us" },
  { href: "#contact", label: "Contact" },
];

export default function Header() {
  const [mobileOpen, setMobileOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 w-full bg-beige-soft/80 backdrop-blur-xl border-b border-charcoal/[0.06]">
      <nav className="container-custom flex items-center justify-between h-16 lg:h-[72px] px-5 sm:px-6 lg:px-8">
        <Link href="/" className="flex items-center gap-2" aria-label="TekMeals Home">
          <span className="font-serif text-xl lg:text-2xl font-bold text-charcoal tracking-tight">
            TekMeals
          </span>
        </Link>

        <ul className="hidden lg:flex items-center gap-8">
          {NAV_LINKS.map((link) => (
            <li key={link.href}>
              <Link
                href={link.href}
                className="text-[15px] font-medium text-charcoal/70 hover:text-charcoal transition-colors duration-200"
              >
                {link.label}
              </Link>
            </li>
          ))}
        </ul>

        <div className="hidden lg:flex items-center gap-3">
          <Link
            href="#login"
            className="text-[15px] font-medium text-charcoal/70 hover:text-charcoal transition-colors px-4 py-2"
          >
            Log in
          </Link>
          <Link href="#get-started" className="btn-primary">
            Get Started
          </Link>
        </div>

        <button
          type="button"
          onClick={() => setMobileOpen(!mobileOpen)}
          className="lg:hidden p-2.5 rounded-lg text-charcoal hover:bg-charcoal/[0.06] transition-colors"
          aria-expanded={mobileOpen}
          aria-label="Toggle menu"
        >
          <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            {mobileOpen ? (
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
            ) : (
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
            )}
          </svg>
        </button>
      </nav>

      {mobileOpen && (
        <div className="lg:hidden border-t border-charcoal/[0.06] bg-white px-5 py-6 animate-fade-in">
          <ul className="flex flex-col gap-1">
            {NAV_LINKS.map((link) => (
              <li key={link.href}>
                <Link
                  href={link.href}
                  onClick={() => setMobileOpen(false)}
                  className="block py-3 text-[15px] font-medium text-charcoal/80 hover:text-charcoal"
                >
                  {link.label}
                </Link>
              </li>
            ))}
            <li className="pt-4 mt-2 border-t border-charcoal/[0.06] flex flex-col gap-2">
              <Link href="#login" onClick={() => setMobileOpen(false)} className="btn-secondary text-center py-3">
                Log in
              </Link>
              <Link href="#get-started" onClick={() => setMobileOpen(false)} className="btn-primary text-center py-3">
                Get Started
              </Link>
            </li>
          </ul>
        </div>
      )}
    </header>
  );
}
