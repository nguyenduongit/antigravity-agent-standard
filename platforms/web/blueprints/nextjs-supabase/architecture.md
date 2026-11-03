# Blueprint: Next.js App Router + Supabase Edge-First

> **Identifier:** `platforms/web/blueprints/nextjs-supabase/architecture.md`  
> **Target:** Modern Full-Stack Web Applications

---

## 1. Overview
This blueprint establishes a production-grade fullstack web architecture decoupling the client presentation layer from business logic via **Shared Zod Contracts**, **Serverless Edge Functions**, and **PostgreSQL Row-Level Security**.

---

## 2. Directory Layout & Module Responsibilities

```text
my-web-app/
├── package.json
├── tsconfig.json
├── supabase/
│   ├── config.toml
│   ├── migrations/               # 100% RLS + Versioned SQL migrations
│   └── functions/                # Deno / Hono Edge Functions
│       └── orders/
│           ├── index.ts          # Hono router & Zod validator middleware
│           └── services/         # Pure domain services
│
└── src/
    ├── contracts/                # SINGLE SOURCE OF TRUTH (Shared Zod DTOs)
    │   ├── common/               # ApiResponse, PaginationSchema
    │   └── orders/               # OrderDtoSchema, CreateOrderSchema
    │
    ├── gateway/                  # Thin typed client connecting to Edge/Supabase
    │   └── orders.gateway.ts
    │
    ├── components/
    │   ├── primitives/           # C0: Radix primitives & visual tokens
    │   └── ui/                   # C1: Generic UI Kit (Button, Input, Badge)
    │
    ├── features/                 # Domain-driven feature slices
    │   └── orders/
    │       ├── components/       # C2: Domain Organisms (OrderCard, OrderTable)
    │       ├── hooks/            # TanStack Query hooks (useOrdersQuery)
    │       └── views/            # Feature container views
    │
    ├── app/                      # C3: Next.js App Router pages
    │   ├── layout.tsx
    │   └── orders/
    │       └── page.tsx
    │
    └── lib/                      # Supabase client helpers (@supabase/ssr)
```

---

## 3. Data Flow

```
[ User Interaction ] ──► [ C3 Route Page (TanStack Query + nuqs) ]
                                      │
                                      ▼
                        [ Typed Gateway Client (BFF) ]
                                      │ (HTTPS request with Anon JWT)
                                      ▼
                      [ Supabase Edge Function (Hono) ]
                                      │ (Zod Validator Middleware)
                                      ▼
                        [ Domain Business Service ]
                                      │ (PostgreSQL query)
                                      ▼
                      [ PostgreSQL Layer (100% RLS) ]
```
