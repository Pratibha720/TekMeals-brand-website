"use client";

import { useState } from "react";

export default function CTASection() {
  const [email, setEmail] = useState("");

  return (
    <section id="get-started" className="section-padding bg-white">
      <div className="container-custom">
        <div className="rounded-card-xl bg-charcoal-deep text-beige-soft p-8 sm:p-10 lg:p-14 text-center max-w-3xl mx-auto border border-charcoal/20">
          <h2 className="font-serif text-2xl sm:text-3xl lg:text-4xl font-bold text-white mb-4 tracking-tight">
            Ready to Upgrade Your Workplace Dining?
          </h2>
          <p className="text-beige-soft/70 text-[17px] mb-10 max-w-xl mx-auto leading-relaxed">
            Join hundreds of companies already using TekMeals. Get a custom proposal in 24 hours.
          </p>
          <form
            className="flex flex-col sm:flex-row gap-3 max-w-md mx-auto"
            onSubmit={(e) => e.preventDefault()}
          >
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="work@company.com"
              className="flex-1 px-4 py-3 rounded-lg bg-white/5 border border-white/10 text-beige-soft placeholder-beige-soft/40 focus:outline-none focus:border-coral/50 transition-colors text-[15px]"
              required
              aria-label="Work email"
            />
            <button type="submit" className="btn-primary whitespace-nowrap">
              Inquire Now
            </button>
          </form>
        </div>
      </div>
    </section>
  );
}
