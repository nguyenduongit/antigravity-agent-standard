# Project Agent Constitution (Web App Anchor)

> **Standard:** Antigravity Agent Standard (AAS)  
> **Status:** Active Project Governance Anchor (Next.js + Supabase Edge-First)

---

## 1. Project Configuration
```yaml
Project Name: [Project Name]
Platform: Web (Node.js 20+, React 19)
Framework: Next.js (App Router)
Backend: Supabase (PostgreSQL 15+, Edge Functions / Hono, Auth, Storage)
Contracts: Shared Zod Schemas (src/contracts/)
State Model: URL-First (nuqs) + TanStack Query + Zustand (UI only)
Security: 100% Postgres RLS + @supabase/ssr Session Cookies
Standards:
  AAS Core: 1.0.0
  Platform Pack: web/1.0.0
Selected Blueprint: platforms/web/blueprints/nextjs-supabase
Active ADRs: []
```

---

## 2. Non-Negotiable Invariants
1. **100% RLS on all tables:** Every migration must explicitly enable and configure Row-Level Security.
2. **Never expose `service_role` key:** Web client and Gateway must use Anon Key only.
3. **Zod as Single Source of Truth:** All request/response contracts must be derived from Zod schemas in `contracts/`.
4. **No `useEffect` data fetching:** All asynchronous data fetching must be handled via TanStack Query.
5. **Never fabricate verification results:** Always provide verbatim terminal output from `npm run type-check && npm test`.

---

## 3. Autonomy Gateways (Balanced Mode)
* **Level 1 (Fast Path):** Local changes ($\le 2$ files in 1 feature/component, no contract breaks) $\rightarrow$ Execute immediately.
* **Level 2 (Plan Gate):** Multi-file ($\ge 3$ files), DB migrations, RLS changes, or shared contracts $\rightarrow$ Present plan and await approval.
* **Level 3 (Hard Barrier):** Dropping database tables/columns, adding npm packages, disabling RLS $\rightarrow$ Explicit human command required.

---

## 4. Verification Protocols
Execute verification according to task risk tier:
* **TypeScript & Contracts:** `npm run type-check` (or `npx tsc --noEmit`)
* **Linter:** `npm run lint`
* **Unit & Contract Tests:** `npm test` (or `npx vitest run`)
* **End-to-End Tests:** `npx playwright test`

---

## 5. Navigation Directory
* Core & Web Rules: `.agents/rules/`
* Technical Skills: `.agents/skills/`
* Architecture Docs: `docs/architecture/`
* ADR Records: `docs/adr/`
