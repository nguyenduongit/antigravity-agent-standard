# Changelog

All notable changes to the Antigravity Agent Standard (AAS) are documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/).

---

## [1.0.0] - 2026-11-03

### Added
- **Core Layer (Universal Governance)**:
  - `00-governance.md`: Priority hierarchy, override mechanics, and ADR policies.
  - `01-agent-conduct.md`: Professional pair programming discipline (Inspect $\rightarrow$ Plan $\rightarrow$ Code $\rightarrow$ Verify $\rightarrow$ Report).
  - `02-scope-control.md`: Rigid bounds on Requested, Necessary, and Out-of-Scope changes.
  - `03-autonomy-levels.md`: Balanced Mode (Fast Path, Plan Gate, Hard Barrier).
  - `04-verification.md`: Risk-based verification requirements and zero-fake-proof mandates.
  - `05-security-baseline.md`: Desktop/Sandbox safety invariants and secret sanitization.
  - `06-reporting.md`: Canonical agent completion report format.
- **Workflow Skills**:
  - `feature-development`: Multi-step feature addition with Plan Gate.
  - `bug-fixing`: Root cause isolation, reproduction, and regression verification.
  - `refactoring`: Behavioral invariant refactoring with strict blast-radius controls.
  - `code-review`: Correctness, security, and architectural review checklist.
  - `testing`: Risk-based test authoring and verification.
  - `technical-planning`: Pre-implementation architectural analysis and impact assessment.
- **Apple Platform Pack (macOS 14+, Swift 6)**:
  - Rules: `swift-language.md`, `swift-concurrency.md`, `swiftui.md`, `spm-architecture.md`, `macos-native.md`, `testing.md`.
  - Skills: `swift-development`, `swiftui-components`, `swift-concurrency`, `spm-module-design`, `macos-file-access`.
  - Blueprints: `macos-app` (Modular SPM Clean Architecture).
- **Templates & Tooling**:
  - `templates/project-AGENTS.md` (Project Anchor < 120 lines).
  - `templates/project-manifest.yaml` & `templates/ADR.md`.
  - `Scripts/check_imports.sh` and `Scripts/check_file_size.sh`.
