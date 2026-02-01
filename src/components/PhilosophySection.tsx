// "use client";

// import Image from "next/image";

// export default function PhilosophySection() {
//   return (
//     <section
//       id="philosophy"
//       className="section-padding bg-beige-soft"
//     >
//       <div className="container-custom">
//         <div className="grid lg:grid-cols-2 gap-14 lg:gap-16 xl:gap-20 items-center">
//           <div className="order-2 lg:order-1 max-w-xl">
//             <p className="section-label text-coral mb-5">Our Philosophy</p>
//             <h2 className="font-serif text-2xl sm:text-3xl lg:text-4xl font-bold text-charcoal mb-6 leading-tight tracking-tight">
//               Redefining Corporate Cuisine through Artistry &amp; Science
//             </h2>
//             <p className="text-charcoal/60 text-[17px] leading-relaxed mb-10">
//               We blend culinary mastery with nutritional innovation to fuel the world&apos;s most creative and demanding work environments. Our approach is rooted in the belief that food is the ultimate catalyst for collaboration.
//             </p>

//             <div className="grid sm:grid-cols-2 gap-8 sm:gap-10">
//               <div>
//                 <span className="block h-0.5 w-10 rounded-full bg-coral/50 mb-4" aria-hidden />
//                 <h3 className="font-serif text-lg font-bold text-charcoal mb-2">Farm-to-Desk</h3>
//                 <p className="text-charcoal/60 text-[15px] leading-relaxed">
//                   Sourcing seasonal ingredients from local artisanal producers every morning.
//                 </p>
//               </div>
//               <div>
//                 <span className="block h-0.5 w-10 rounded-full bg-coral/50 mb-4" aria-hidden />
//                 <h3 className="font-serif text-lg font-bold text-charcoal mb-2">Nutritional Integrity</h3>
//                 <p className="text-charcoal/60 text-[15px] leading-relaxed">
//                   Science-backed menus designed to sustain cognitive focus and energy.
//                 </p>
//               </div>
//             </div>
//           </div>

//           <div className="order-1 lg:order-2 relative">
//             <div className="relative aspect-[3/4] max-h-[520px] lg:max-h-none rounded-card-xl overflow-hidden shadow-premium ring-1 ring-charcoal/[0.06]">
//               <Image
//                 src="https://images.unsplash.com/photo-1540420773520-1f126121314e?w=700&q=85"
//                 alt="Fresh seasonal vegetables on a wooden cutting board"
//                 fill
//                 className="object-cover"
//                 sizes="(max-width: 1024px) 100vw, 50vw"
//                 priority={false}
//               />
//             </div>
//             <div
//               className="absolute -bottom-5 right-0 sm:right-6 w-[min(220px,48%)] aspect-square rounded-card-lg overflow-hidden shadow-soft-lg ring-1 ring-charcoal/[0.06] z-10 relative"
//               aria-hidden
//             >
//               <Image
//                 src="https://images.unsplash.com/photo-1577219491095-273fc0e8d76f?w=400&q=85"
//                 alt="Chef plating a dish"
//                 fill
//                 className="object-cover"
//                 sizes="220px"
//               />
//             </div>
//           </div>
//         </div>
//       </div>
//     </section>
//   );
// }



// "use client";

// import Image from "next/image";

// export default function PhilosophySection() {
//   return (
//     <section
//       id="philosophy"
//       className="section-padding bg-beige-soft"
//     >
//       <div className="container-custom">
//         <div className="grid lg:grid-cols-2 gap-14 lg:gap-16 xl:gap-20 items-center">

//           {/* TEXT CONTENT */}
//           <div className="order-2 lg:order-1 max-w-xl">
//             <p className="section-label text-coral mb-5">
//               Our Philosophy
//             </p>

//             <h2 className="font-serif text-2xl sm:text-3xl lg:text-4xl font-bold text-charcoal mb-6 leading-tight tracking-tight">
//               Redefining Corporate Cuisine through Artistry &amp; Science
//             </h2>

//             <p className="text-charcoal/60 text-[17px] leading-relaxed mb-10">
//               We blend culinary mastery with nutritional innovation to fuel the world&apos;s most creative and demanding work environments.
//               Our approach is rooted in the belief that food is the ultimate catalyst for collaboration.
//             </p>

//             <div className="grid sm:grid-cols-2 gap-8 sm:gap-10">
//               <div>
//                 <span
//                   className="block h-0.5 w-10 rounded-full bg-coral/50 mb-4"
//                   aria-hidden
//                 />
//                 <h3 className="font-serif text-lg font-bold text-charcoal mb-2">
//                   Farm-to-Desk
//                 </h3>
//                 <p className="text-charcoal/60 text-[15px] leading-relaxed">
//                   Sourcing seasonal ingredients from local artisanal producers every morning.
//                 </p>
//               </div>

//               <div>
//                 <span
//                   className="block h-0.5 w-10 rounded-full bg-coral/50 mb-4"
//                   aria-hidden
//                 />
//                 <h3 className="font-serif text-lg font-bold text-charcoal mb-2">
//                   Nutritional Integrity
//                 </h3>
//                 <p className="text-charcoal/60 text-[15px] leading-relaxed">
//                   Science-backed menus designed to sustain cognitive focus and energy.
//                 </p>
//               </div>
//             </div>
//           </div>

//           {/* IMAGE CONTENT */}
//           <div className="order-1 lg:order-2 relative">

//             {/* MAIN IMAGE */}
//             <div className="relative aspect-[3/4] max-h-[520px] lg:max-h-none rounded-card-xl overflow-hidden shadow-premium ring-1 ring-charcoal/[0.06]">
//               <Image
//                 src="/images/uncooked vegetables.png"
//                 alt="Fresh seasonal vegetables on a wooden cutting board"
//                 fill
//                 className="object-cover"
//                 sizes="(max-width: 1024px) 100vw, 50vw"
//                 priority
//               />
//             </div>

//             {/* FLOATING IMAGE */}
//             <div
//               className="absolute -bottom-5 right-0 sm:right-6 w-[min(220px,48%)] aspect-square rounded-card-lg overflow-hidden shadow-soft-lg ring-1 ring-charcoal/[0.06] z-10"
//               aria-hidden
//             >
//               <Image
//                 src="/images/chef's plating.png"
//                 alt="Chef plating a dish"
//                 fill
//                 className="object-cover"
//                 sizes="220px"
//               />
//             </div>

//           </div>
//         </div>
//       </div>
//     </section>
//   );
// }


"use client";

import Image from "next/image";

export default function PhilosophySection() {
  return (
    <section
      id="philosophy"
      className="section-padding bg-beige-soft"
    >
      <div className="container-custom">
        <div className="grid lg:grid-cols-2 gap-16 xl:gap-24 items-center">

          {/* LEFT CONTENT */}
          <div className="order-2 lg:order-1 max-w-xl">

            {/* Badge */}
            <span className="inline-block mb-6 px-4 py-1.5 rounded-full bg-blue-100 text-blue-700 text-xs font-semibold tracking-wide uppercase">
              Our Philosophy
            </span>

            <h2 className="font-serif text-3xl sm:text-4xl lg:text-5xl font-bold text-charcoal mb-6 leading-tight">
              Redefining Corporate Cuisine
              <br />
              through Artistry &amp; Science
            </h2>

            <p className="text-charcoal/60 text-[17px] leading-relaxed mb-12">
              We blend culinary mastery with nutritional innovation to fuel the
              world&apos;s most creative and demanding work environments. Our
              approach is rooted in the belief that food is the ultimate
              catalyst for collaboration.
            </p>

            <div className="grid sm:grid-cols-2 gap-10">
              <div>
                <span className="block h-0.5 w-10 bg-amber-500/60 mb-4" />
                <h3 className="font-serif text-lg font-bold text-charcoal mb-2">
                  Farm-to-Desk
                </h3>
                <p className="text-charcoal/60 text-[15px] leading-relaxed">
                  Sourcing seasonal ingredients from local artisanal producers
                  every morning.
                </p>
              </div>

              <div>
                <span className="block h-0.5 w-10 bg-amber-500/60 mb-4" />
                <h3 className="font-serif text-lg font-bold text-charcoal mb-2">
                  Nutritional Integrity
                </h3>
                <p className="text-charcoal/60 text-[15px] leading-relaxed">
                  Science-backed menus designed to sustain cognitive focus and
                  energy.
                </p>
              </div>
            </div>
          </div>

          {/* RIGHT IMAGES */}
          <div className="order-1 lg:order-2 relative">

            {/* Main Image */}
            <div className="relative aspect-[3/4] rounded-[28px] overflow-hidden">
              <Image
                src="/images/uncooked vegetables.png"
                alt="Fresh seasonal vegetables"
                fill
                className="object-cover"
                sizes="(max-width: 1024px) 100vw, 50vw"
                priority
              />
            </div>

            {/* Floating Chef Image */}
            <div className="absolute bottom-[-20px] left-[-40px] sm:left-[-60px] w-[220px] aspect-square bg-white rounded-2xl p-3 shadow-xl">
              <div className="relative w-full h-full rounded-xl overflow-hidden">
                <Image
                  src="/images/Chef's plating.png"
                  alt="Chef plating a dish"
                  fill
                  className="object-cover"
                  sizes="220px"
                />
              </div>
            </div>

          </div>
        </div>
      </div>
    </section>
  );
}
