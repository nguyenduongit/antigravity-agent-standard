# Blueprint: Modular macOS Clean Architecture

> **Identifier:** `platforms/apple/blueprints/macos-app/architecture.md`  
> **Target:** Native macOS 14+ Applications

---

## 1. Overview
This blueprint provides a production-grade modular architecture optimized for native macOS applications. It achieves complete decoupling between pure business rules, presentation logic, and system infrastructure.

---

## 2. Directory Layout & Target Responsibilities

```text
Sources/
├── Domain/                  # Pure Swift business logic
│   ├── Entities/            # Immutable value types (Sendable structs)
│   ├── Repositories/        # Protocol contracts (e.g. ProjectRepositoryProtocol)
│   └── Commands/            # Command Pattern types for Undo/Redo stack
│
├── Infrastructure/          # Concurrency actors & concrete implementations
│   ├── Persistence/         # SwiftData or File storage implementations
│   └── Security/            # Security-scoped bookmarks & Keychain bridge
│
├── UIComponents/            # Shared Design System
│   ├── Tokens/              # C0: Semantic colors, typography, spacers
│   └── Controls/            # C1: Generic controls (zero Domain knowledge)
│
├── Features/                # Feature modules
│   └── FeatureEditor/
│       ├── Components/      # C2: Domain organisms (receive entities/actions)
│       ├── ViewModels/      # Observation @Observable @MainActor ViewModels
│       └── Screens/         # C3: Window & sheet composition
│
└── DesktopApp/              # App Target (Composition Root)
    ├── DesktopApp.swift     # @main entry point, WindowGroups, MenuBar
    ├── Commands/            # Centralized menu shortcuts
    └── DependencyContainer/ # Concrete assembly & dependency injection
```

---

## 3. Data Flow & Communication Pattern

```
[ User Interaction ] ──► [ C3 Screen / C2 Organism ]
                                  │
                                  ▼
                     [ @MainActor ViewModel ]
                                  │ (async call)
                                  ▼
                     [ Domain Repository Protocol ]
                                  │ (implements)
                                  ▼
                   [ Infrastructure Concrete Actor ]
```

---

## 4. Testing Strategy
* `DomainTests`: Fast, pure Swift unit tests verifying commands and entities.
* `InfrastructureTests`: Integration tests verifying serialization and file storage with temporary sandboxes.
* `FeatureTests`: ViewModels tested using mock repositories.
* Previews: 100% offline previews using Mock ViewModels.
