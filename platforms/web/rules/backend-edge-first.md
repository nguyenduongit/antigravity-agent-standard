# Web Platform Rule: Backend Edge-First Architecture (Supabase + Hono)

> **Identifier:** `platforms/web/rules/backend-edge-first.md`  
> **Status:** Platform Invariant  
> **Target:** Supabase Edge Functions, PostgreSQL 15+, Hono, Next.js

---

## 1. Architectural Layering & Direction

```
┌────────────────────────────────────────────────────────────────────────┐
│                        Next.js Web Application                         │
│   (App Router, SSR/Client Components, Route Handlers, Gateway Client)  │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ Calls via Typed Gateway
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│             Shared Contracts (src/contracts/ hoặc packages/contracts)   │
│             (Zod Schemas, Request/Response Types, Common Errors)       │
└───────────────────▲────────────────────────────────▲───────────────────┘
                    │ imports                        │ imports
┌───────────────────┴───────────────┐  ┌─────────────┴───────────────────┐
│     Supabase Edge Functions       │  │    PostgreSQL Database Layer    │
│  (Hono Router, UseCases, Handlers,│  │ (Tables, 100% RLS Policies,     │
│   Zod Validation, Domain Services)│  │  Custom Types, DB Functions/RPC)│
└───────────────────┬───────────────┘  └─────────────────────────────────┘
                    │ Queries / Invokes
                    └──────────────────────────────────┘
```

---

## 2. PostgreSQL Database Layer & Migrations
1. **Versioned Migrations Only:** All database schemas, tables, triggers, and RPC functions must be committed as versioned migration scripts in `supabase/migrations/<timestamp>_<name>.sql`.
2. **Zero Dashboard Schema Editing:** Manually creating or altering tables directly in the Supabase Dashboard on staging or production is strictly forbidden.
3. **100% Row Level Security (RLS):** Every single table must explicitly enable RLS:
   ```sql
   ALTER TABLE table_name ENABLE ROW LEVEL SECURITY;
   ```

---

## 3. Supabase Edge Functions (Hono-Powered)
1. **Domain-Centric Functions:** Group Edge Functions by business domain (e.g., `functions/orders`, `functions/payments`, `functions/webhooks`).
2. **Hono Web Framework:** Use Hono to manage routing, CORS, authentication middleware, and error handling inside Deno runtime.
3. **Mandatory Zod Validation:** Every endpoint must validate input payloads using schemas imported from `contracts/`.

---

## 4. Next.js Gateway Client (BFF)
1. **Thin Typed Gateway:** Frontend components connect to Edge Functions and backend APIs strictly through typed gateway modules (e.g., `src/gateway/orders.gateway.ts`):
   ```ts
   export const ordersGateway = {
     getById: async (id: string): Promise<OrderDto> => { ... },
     create: async (input: CreateOrderInput): Promise<OrderDto> => { ... }
   };
   ```
2. **Prohibition of Direct Raw Queries:** Never scatter raw SQL queries or complex multi-table Supabase queries directly inside React components.
