"use client";

import { useState } from "react";

const QUOTES = [
  {
    text: "TekMeals transformed our office culture. Employees actually look forward to lunch now.",
    name: "Sarah Chen",
    role: "Chief People Officer",
    company: "ScaleAI",
    initials: "SC",
  },
  {
    text: "Seamless ordering, predictable costs, zero cafeteria headaches. Exactly what we needed.",
    name: "Marcus Webb",
    role: "Operations Director",
    company: "Nexus Labs",
    initials: "MW",
  },
  {
    text: "Best corporate food service we've used — reliable, delicious, and the team loves it.",
    name: "Priya Sharma",
    role: "HR Lead",
    company: "TechVentures",
    initials: "PS",
  },
];

export default function Testimonials() {
  const [index, setIndex] = useState(0);
  const q = QUOTES[index];

  return (
    <section className="section-padding bg-beige-soft">
      <div className="container-custom">
        <div className="text-center max-w-2xl mx-auto mb-14 lg:mb-16">
          <p className="section-label text-coral mb-4">Testimonials</p>
          <h2 className="section-heading mb-4">What Our Clients Say</h2>
          <p className="text-charcoal/60 text-[17px] leading-relaxed">
            Trusted by HR teams and corporates worldwide.
          </p>
        </div>
        <div className="max-w-3xl mx-auto">
          <div className="rounded-card-xl bg-white p-8 sm:p-10 lg:p-12 shadow-soft border border-charcoal/[0.06]">
            <p className="font-serif text-xl sm:text-2xl text-charcoal mb-8 leading-relaxed">
              &ldquo;{q.text}&rdquo;
            </p>
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 rounded-full bg-coral-muted flex items-center justify-center text-coral font-semibold text-[15px]">
                {q.initials}
              </div>
              <div>
                <p className="font-semibold text-charcoal text-[15px]">{q.name}</p>
                <p className="text-charcoal/55 text-[14px]">
                  {q.role}, {q.company}
                </p>
              </div>
            </div>
          </div>
          <div className="flex justify-center gap-2 mt-8">
            {QUOTES.map((_, i) => (
              <button
                key={i}
                type="button"
                onClick={() => setIndex(i)}
                className={`h-1.5 rounded-full transition-all duration-200 ${
                  i === index ? "bg-coral w-6" : "bg-charcoal/20 w-1.5 hover:bg-charcoal/30"
                }`}
                aria-label={`View testimonial ${i + 1}`}
              />
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
