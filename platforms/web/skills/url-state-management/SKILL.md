---
name: url-state-management
description: >-
  Use this skill when managing view-altering state (pagination, search, filters, tabs)
  using URL query parameters via nuqs or Next.js searchParams.
---

# Technology Skill: URL-First State Management

## Objective
Persist all UI state that affects what data is presented into URL query parameters, enabling deep-linking, browser history navigation, and shareable URLs.

---

## Technical Procedures

### 1. Using `nuqs` for Type-Safe URL Query Params
```tsx
"use client";
import { useQueryState, parseAsString, parseAsInteger } from "nuqs";

export function useOrderFilters() {
  const [search, setSearch] = useQueryState("q", parseAsString.withDefault(""));
  const [page, setPage] = useQueryState("page", parseAsInteger.withDefault(1));
  const [status, setStatus] = useQueryState("status", parseAsString.withDefault("all"));

  return {
    search,
    setSearch,
    page,
    setPage,
    status,
    setStatus,
  };
}
```

### 2. Passing URL State into TanStack Query
Always include URL search parameters in the TanStack Query key to trigger automatic re-fetching on URL change:
```tsx
export function useOrders() {
  const { search, page, status } = useOrderFilters();

  return useQuery({
    queryKey: ["orders", { search, page, status }],
    queryFn: () => ordersGateway.list({ search, page, status }),
  });
}
```

### 3. Anti-Pattern Warning
* **NEVER** store search keyword or active tab inside local `useState` if refreshing the page should retain that state.
* **NEVER** sync `useState` with URL parameters using a reactive `useEffect`; bind directly to the URL state hook.
