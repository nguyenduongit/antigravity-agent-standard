# Web Platform Rule: Frontend Component Architecture (4 Tiers)

> **Identifier:** `platforms/web/rules/frontend-components.md`  
> **Status:** Platform Invariant  
> **Target:** React 19, Next.js (App Router), Tailwind CSS, Radix UI

---

## 1. The 4-Tier Component Hierarchy

```
[ C0: Tokens & Primitives ]  ──► Pure visual/styling (Tailwind/Radix), zero domain knowledge
              ▼
[ C1: Generic Controls ]     ──► Reusable UI Kit (Button, Input), receives primitive props
              ▼
[ C2: Domain Organisms ]     ──► Bound to Shared Contracts (DTOs), presentational only, NO fetch
              ▼
[ C3: Route Screens/Pages ]  ──► Owns TanStack Query & URL State, orchestrates C0–C2
```

### Level 0: Design Tokens & Primitives
* **Location:** `src/components/primitives/` and `tailwind.config.ts`.
* **Scope:** Typography tokens, color palettes, spacing variables, unstyled Radix UI wrappers (Dialog, DropdownMenu, Tooltip).
* **Prohibitions:** Must never contain business logic; must never import Domain entities.

### Level 1: Generic Controls & Molecules
* **Location:** `src/components/ui/`.
* **Scope:** Reusable interactive UI Kit elements: `Button`, `Input`, `Select`, `StatusBadge`, `ModalDialog`.
* **Rules:** Accepts primitive props (`string`, `number`, `boolean`, `ReactNode`) and event callbacks (`onClick`, `onChange`).
* **Prohibitions:** Must never import Domain contracts; must never call APIs or include TanStack Query.

### Level 2: Domain Organisms & Composite Blocks
* **Location:** `src/features/<feature>/components/`.
* **Scope:** Business-aware composite components: `UserProfileCard`, `OrderSummaryTable`, `InvoiceItemRow`.
* **Rules:** Consumes typed contract DTOs from `contracts/` (e.g. `props: { order: OrderDto; onCancel: (id: string) => void }`). Purely presentational; mutations emitted via callback props.
* **Prohibitions:** Must NEVER invoke `useQuery`, `fetch()`, or `supabase.from()` directly inside Level 2.

### Level 3: Route Screens, Pages & Containers
* **Location:** `src/app/**/page.tsx` or `src/features/<feature>/views/`.
* **Scope:** Next.js Route Pages, Server Components, and feature container views.
* **Rules:** The sole layer permitted to call Gateway Clients, TanStack Query hooks (`useQuery`, `useMutation`), and URL state managers (`nuqs`). Assembles C0, C1, and C2 components into complete user journeys.

---

## 2. Anti-Overengineering Directives

1. **Rule of Three:** Do not extract a component into Level 1 (Generic UI) unless it is reused in at least 2 distinct screens or forms part of the global design system.
2. **Prohibit Single-Use Wrappers:** Never create a custom component solely to wrap a primitive HTML tag or Radix component without adding styling, interaction, or accessibility (e.g., do not write `<CustomBox>` that only renders `<div className="p-4 rounded-lg">`).
3. **Maximum Nesting Depth:** Component trees must not exceed 4 levels of depth (`C3 Page -> C2 Organism -> C1 Control -> C0 Primitive`).

---

## 3. Code Complexity & Size Ceilings
* Component / Module file: $\le$ **250 lines**.
* Function / Custom Hook: $\le$ **40 lines**.
* JSX render body: $\le$ **50 lines**.
* Block nesting depth: $\le$ **3 levels** (use early returns / guards to flatten branches).
