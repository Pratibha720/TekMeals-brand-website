"use client";

import Header from "@/components/Header";
import Hero from "@/components/Hero";
import TrustMetrics from "@/components/TrustMetrics";
import CoreServices from "@/components/CoreServices";
import PhilosophySection from "@/components/PhilosophySection";
import HowItWorks from "@/components/HowItWorks";
import CorporateValue from "@/components/CorporateValue";
import Testimonials from "@/components/Testimonials";
import PartnerWithUs from "@/components/PartnerWithUs";
import DashboardsMention from "@/components/DashboardsMention";
import CTASection from "@/components/CTASection";
import Footer from "@/components/Footer";

export default function Home() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <TrustMetrics />
        <CoreServices />
        <PhilosophySection />
        <HowItWorks />
        <CorporateValue />
        <Testimonials />
        <PartnerWithUs />
        <DashboardsMention />
        <CTASection />
        <Footer />
      </main>
    </>
  );
}
