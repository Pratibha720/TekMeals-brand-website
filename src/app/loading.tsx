export default function Loading() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-beige-soft">
      <div className="text-center">
        <div className="w-12 h-12 border-4 border-coral/30 border-t-coral rounded-full animate-spin mx-auto mb-4" />
        <p className="text-charcoal/70 font-medium">Loading TekMeals…</p>
      </div>
    </div>
  );
}
