# Web Platform Rule: State Management & Defense-in-Depth Security

> **Identifier:** `platforms/web/rules/state-and-security.md`  
> **Status:** Platform Invariant  
> **Target:** Next.js, Supabase, TanStack Query, Zustand, nuqs

---

## 1. 3-Tier State Management Model

```
┌────────────────────────────────────────────────────────────────────────┐
│ 1. URL-FIRST STATE (nuqs / searchParams)                               │
│ View-altering state (Pagination, Filters, Search Query, Tabs).         │
│ Must survive page reload and be shareable via URL.                     │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│ 2. SERVER STATE (@tanstack/react-query)                                │
│ Asynchronous data fetching, background caching, and cache invalidation.│
│ STRICTLY FORBIDDEN: Using `useEffect` to fetch and store in `useState`.│
└───────────────────────────────────┬────────────────────────────────────┘
                                    │
┌───────────────────────────────────▼────────────────────────────────────┐
│ 3. CLIENT UI STATE (Zustand)                                           │
│ Ephemeral global UI state ONLY (Sidebar toggle, Modals, Theme).        │
│ STRICTLY FORBIDDEN: Caching server entities inside Zustand stores.     │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Row-Level Security (RLS) as Non-Negotiable Barrier
1. **Mandatory RLS on 100% of Tables:**
   * Every table created must execute `ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;`.
   * Explicit policies must exist for `SELECT`, `INSERT`, `UPDATE`, and `DELETE` scoped to `auth.uid()` or role claims.
2. **Never Disable RLS for Convenience:**
   * Never run `DISABLE ROW LEVEL SECURITY` to pass a failing test or bypass permission errors.

---

## 3. Credential Protection & Session Safety
1. **Zero Service Role Key on Client:**
   * The Web App and Gateway Client must strictly connect using the **Supabase Anon Key**.
   * `SUPABASE_SERVICE_ROLE_KEY` is restricted exclusively to the private environment of Supabase Edge Functions for audited administrative operations.
2. **Secure Session Handling via `@supabase/ssr`:**
   * Sessions must be managed via HttpOnly, Secure, SameSite cookies.
   * Client-side JavaScript must never directly access or store JWT tokens in `localStorage`.
