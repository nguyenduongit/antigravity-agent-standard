# Changelog

All notable changes to the Antigravity Agent Standard (AAS) are documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/).

---

## [1.1.0] - 2026-11-03

### Added
- **Web Platform Pack (`platforms/web/`)**:
  - Technical Rules:
    - `typescript-contracts.md`: Zod-first shared contracts & boundary validation.
    - `backend-edge-first.md`: Supabase Edge Functions with Hono, 100% Postgres RLS, and Gateway BFF.
    - `frontend-components.md`: 4-tier component hierarchy (C0 Primitives, C1 Generic UI, C2 Domain Organisms, C3 Route Screens).
    - `state-and-security.md`: URL-First state via `nuqs`, TanStack Query server cache, and cookie session security via `@supabase/ssr`.
    - `testing-and-ci.md`: Definition of Done for Web (TypeScript strict, Biome/ESLint, Vitest, Playwright).
  - Specialized Skills:
    - `web-contract-design`: Portable Zod schemas & DTO generation.
    - `supabase-rls-design`: Bulletproof PostgreSQL Row-Level Security policies.
    - `edge-function-hono`: Serverless Hono microservices on Deno runtime.
    - `frontend-component-ui`: 4-tier React component construction.
    - `url-state-management`: Deep-linking and query param synchronization.
  - Architecture Blueprint:
    - `blueprints/nextjs-supabase/architecture.md`: Canonical Next.js App Router + Supabase Edge architecture.
  - Templates:
    - `templates/project-AGENTS-web.md`: Web Project Anchor (< 120 lines).
    - `templates/project-manifest-web.yaml`: Project manifest for Web applications.
- **Dedicated Tooling Installers**:
  - `tooling/install-swift.sh`: Dedicated installer for Swift macOS projects.
  - `tooling/install-web.sh`: Dedicated installer for Web App projects.
  - Updated `README.md` with explicit, separated command blocks per project stack.

---

## [1.0.0] - 2026-11-03

### Added
- **Core Layer (Universal Governance)**:
  - `00-governance.md`, `01-agent-conduct.md`, `02-scope-control.md`, `03-autonomy-levels.md`, `04-verification.md`, `05-security-baseline.md`, `06-reporting.md`.
  - Workflow Skills: `feature-development`, `bug-fixing`, `refactoring`, `code-review`, `testing`, `technical-planning`.
- **Apple Platform Pack (macOS 14+, Swift 6)**:
  - Rules, skills, and blueprints for Swift macOS Desktop modular architecture.
