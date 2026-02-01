# TekMeals — Premium Corporate Dining Platform

A world-class corporate food ordering platform website. Built with **Next.js 14** and **Tailwind CSS**. Mobile-first, responsive, and accessibility-friendly.

## Open in VS Code

1. Open **VS Code**.
2. **File → Open Folder**.
3. Choose `c:\Users\lenovo\Desktop\Tekmeals brand website`.
4. Use the integrated terminal (**View → Terminal** or `` Ctrl+` ``) to run the commands below.

## Commands to Run & View on Localhost

### 1. Install dependencies (first time only)

```bash
cd "c:\Users\lenovo\Desktop\Tekmeals brand website"
npm install
```

### 2. Start the development server

```bash
npm run dev
```

**If it’s slow or stuck loading:** use the faster dev server with Turbopack:

```bash
npm run dev:turbo
```

### 3. Open in your browser

Go to **[http://localhost:3000](http://localhost:3000)**.

If you see “Port 3000 is in use,” close other terminals or stop other Node apps, then run `npm run dev` again.

### 4. Build for production (optional)

```bash
npm run build
npm start
```

Then open [http://localhost:3000](http://localhost:3000).

## Project structure

- `src/app/` — Next.js App Router (layout, page, styles)
- `src/components/` — Reusable sections (Header, Hero, Trust Metrics, Menu, etc.)

## Tech stack

- **Next.js 14** (App Router)
- **TypeScript**
- **Tailwind CSS**
- **Google Fonts**: Playfair Display, DM Sans

## Features

- Sticky header with mobile menu (mobile-friendly hamburger)
- Hero, Trust Metrics, Core Services, Menu, How It Works
- Corporate Value, Testimonials, Partner With Us
- Dashboards mention (Corporate Admin, Employee, Kitchen Partner)
- CTA section with email capture
- Footer with links and social icons

## Troubleshooting

- **Port 3000 in use:** Stop other `npm run dev` or Node processes (Task Manager → end `node.exe` if needed), then run `npm run dev` again.
- **Slow or stuck “Loading…”:** Use `npm run dev:turbo` for a faster dev server. Ensure you open **http://localhost:3000** (not 3001, 3002, etc.).
- **`Cannot find module 'cssesc'`:** Run `npm install` (the project includes `cssesc` as a dependency).
- **EPERM / file locked:** Close other terminals or apps using the project folder, delete the `.next` folder, then run `npm run dev` again.
