# Web Platform Rule: TypeScript & Shared Zod Contracts

> **Identifier:** `platforms/web/rules/typescript-contracts.md`  
> **Status:** Platform Invariant  
> **Target:** TypeScript 5.0+ (Strict), Next.js, Supabase Edge Functions

---

## 1. Zod-First Contracts (Single Source of Truth)

All network data contracts (Request Input, Response DTOs, and Domain enums) must be declared as **Zod Schemas** located in `src/contracts/` (or `packages/contracts/` in monorepos):

* **Single Source of Truth:** TypeScript types must be derived directly using `z.infer<typeof Schema>`:
  ```ts
  import { z } from "zod";

  export const OrderStatusSchema = z.enum(["pending", "processing", "completed", "cancelled"]);
  export type OrderStatus = z.infer<typeof OrderStatusSchema>;

  export const OrderDtoSchema = z.object({
    id: z.string().uuid(),
    customerName: z.string().min(1),
    totalAmount: z.number().nonnegative(),
    status: OrderStatusSchema,
    createdAt: z.string().datetime(),
  });
  export type OrderDto = z.infer<typeof OrderDtoSchema>;
  ```
* **Independence:** The `contracts/` module must remain pure and portable; it must NEVER import UI frameworks (React, Next.js) or database drivers (Supabase, Prisma).

---

## 2. Boundary Validation

Data crossing system boundaries must be parsed and verified:
1. **Edge Function Requests:** Every incoming JSON body and query parameter must pass through Zod schema validation before reaching business services:
   ```ts
   const body = CreateOrderInputSchema.parse(await c.req.json());
   ```
2. **Gateway Responses:** Gateway fetchers on the Web client must validate or type-check responses to prevent silent runtime failures.

---

## 3. Standardized API Responses & Error Handling

* **Explicit Response Contract:** All API endpoints and Edge Functions must return standard envelope types:
  ```ts
  export type ApiResponse<T> =
    | { success: true; data: T; meta?: Record<string, unknown> }
    | { success: false; error: { code: string; message: string; details?: unknown } };
  ```
* **Zero Silent Swallowing:**
  * Prohibit empty `catch (e) {}` blocks.
  * Prohibit concealing errors with fallback `null` or `[]` unless the contract explicitly declares it.
  * Never leak raw database errors or stack traces to client browsers.

---

## 4. Environment Variable Validation
All environment variables (`NEXT_PUBLIC_SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY`) must be validated on app initialization via Zod (`src/env.mjs` or `src/lib/env.ts`). Never access unvalidated `process.env.XYZ` directly in application logic.
