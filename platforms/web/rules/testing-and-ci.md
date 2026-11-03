# Web Platform Rule: Quality Gates & Testing Standards

> **Identifier:** `platforms/web/rules/testing-and-ci.md`  
> **Status:** Platform Invariant  
> **Target:** TypeScript, Vitest, Playwright, ESLint

---

## 1. Verification Tooling & Commands

The agent must execute automated checks before declaring completion:

| Check | Primary Command | Objective |
|---|---|---|
| **Type Check** | `npm run type-check` (or `npx tsc --noEmit`) | Validate TypeScript strict types across contracts, gateway, and UI. |
| **Lint & Format** | `npm run lint` | Verify code cleanliness, import order, and hook dependency arrays. |
| **Unit & Contract Tests** | `npm test` (or `npx vitest run`) | Verify Zod validation schemas, business logic services, and pure components. |
| **E2E Core Flows** | `npx playwright test` | Verify critical end-to-end checkout, auth, and onboarding flows. |

---

## 2. Mandatory Quality Gates (Definition of Done)

A task is officially complete only when all criteria below are verified:

1. **Zero TypeScript Errors:**
   * `npm run type-check` completes with 0 errors.
2. **Zero Linter Warnings:**
   * ESLint / Biome passes without warnings on touched files.
3. **Deterministic Contract & Unit Tests:**
   * All touched Zod schemas and Edge Function services have passing Vitest tests.
4. **Clean Code Hygiene:**
   * Zero debugging `console.log` statements left behind.
   * Zero `useEffect` hooks used for API data fetching.
   * No `service_role` keys exposed to client code.
5. **Raw Output Attached:**
   * The final report includes the exact verbatim terminal output and exit code `0`.
