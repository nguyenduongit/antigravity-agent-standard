# Changelog

All notable changes to the Antigravity Agent Standard (AAS) are documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/).

---

## [1.2.0] - 2026-11-03

### Added
- **Native Spec-Driven Development (SDD) Engine (Inspired by GitHub Spec-Kit)**:
  - **New Universal Workflow Skill**: `core/skills/spec-driven-development/SKILL.md` orchestrating the 4-phase lifecycle:
    - Phase 1: `Specify` — Prioritized user journeys (P1 MVP, P2, P3) with Given-When-Then acceptance criteria.
    - Phase 2: `Plan` — Technical architecture, contracts, and Plan Gate approval.
    - Phase 3: `Tasks Breakdown` — Granular, bite-sized tasks with parallel execution flags `[P]` and story checkpoints.
    - Phase 4: `Execute & Verify` — Incremental execution enforced by AAS Quality Gates and Proof-First reporting.
  - **Spec-Kit Standard Templates (`templates/spec-kit/`)**:
    - `spec.template.md`: Product & Functional specification template.
    - `plan.template.md`: Technical architecture and boundary planning template.
    - `tasks.template.md`: Actionable task checklist template with phase dependencies.
  - **Automatic Installation**:
    - `tooling/install-swift.sh` and `tooling/install-web.sh` now automatically provision `docs/specs/templates/` inside project workspaces.

---

## [1.1.0] - 2026-11-03

### Added
- **Web Platform Pack (`platforms/web/`)**:
  - Rules: `typescript-contracts.md`, `backend-edge-first.md`, `frontend-components.md`, `state-and-security.md`, `testing-and-ci.md`.
  - Skills: `web-contract-design`, `supabase-rls-design`, `edge-function-hono`, `frontend-component-ui`, `url-state-management`.
  - Blueprint: `blueprints/nextjs-supabase/architecture.md`.
  - Templates: `templates/project-AGENTS-web.md`, `templates/project-manifest-web.yaml`.
- **Dedicated Stack Installers**:
  - `tooling/install-swift.sh`, `tooling/install-web.sh`.

---

## [1.0.0] - 2026-11-03

### Added
- **Core Layer (Universal Governance)**:
  - Rules: `00-governance.md` through `06-reporting.md`.
  - Workflow Skills: `feature-development`, `bug-fixing`, `refactoring`, `code-review`, `testing`, `technical-planning`.
- **Apple Platform Pack (macOS 14+, Swift 6)**:
  - Rules, skills, and blueprints for Swift macOS Desktop modular architecture.
