---
name: edge-function-hono
description: >-
  Use this skill when implementing or modifying Supabase Edge Functions powered by Hono.
  Covers routing, CORS, authentication middleware, error handling, and domain services.
---

# Technology Skill: Edge Functions with Hono

## Objective
Build high-throughput, low-latency serverless Edge Functions on Deno using the lightweight Hono web framework.

---

## Technical Procedures

### 1. Canonical Edge Function Layout
```text
supabase/functions/orders/
├── index.ts              # Hono entrypoint, middleware, route registration
├── middleware/           # Auth, rate-limiting, error handler
└── services/             # Pure domain business logic & database interactions
```

### 2. Standard Hono Implementation
```ts
import { Hono } from "https://deno.land/x/hono@v4.3.11/mod.ts";
import { cors } from "https://deno.land/x/hono@v4.3.11/middleware.ts";
import { CreateOrderInputSchema } from "@/contracts/orders.ts";

const app = new Hono();

// Global CORS & Error Handling
app.use("*", cors());

app.onError((err, c) => {
  console.error(`[Edge Error] ${err.message}`, err.stack);
  return c.json({
    success: false,
    error: { code: "INTERNAL_ERROR", message: err.message }
  }, 500);
});

// Authenticated Route
app.post("/", async (c) => {
  const authHeader = c.req.header("Authorization");
  if (!authHeader) {
    return c.json({ success: false, error: { code: "UNAUTHORIZED", message: "Missing token" } }, 401);
  }

  const rawJson = await c.req.json();
  const input = CreateOrderInputSchema.parse(rawJson);

  // Invoke business logic service
  const order = await orderService.create(input, authHeader);
  return c.json({ success: true, data: order }, 201);
});

Deno.serve(app.fetch);
```
