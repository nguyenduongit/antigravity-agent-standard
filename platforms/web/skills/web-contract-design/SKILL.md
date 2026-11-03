---
name: web-contract-design
description: >-
  Use this skill when designing, adding, or modifying shared Zod schemas, DTOs,
  and API contracts in a TypeScript/Next.js/Supabase application.
---

# Technology Skill: Web Contract Design (Zod-First)

## Objective
Author portable, type-safe, and validated shared contracts that serve as the single source of truth across Edge Functions, database entities, and client components.

---

## Technical Procedures

### 1. Declaring Schemas in `src/contracts/`
Always place shared contracts in `src/contracts/<domain>/`:
```ts
import { z } from "zod";

export const CreateUserInputSchema = z.object({
  email: z.string().email(),
  fullName: z.string().min(2).max(100),
  role: z.enum(["member", "admin"]).default("member"),
});

export const UserDtoSchema = CreateUserInputSchema.extend({
  id: z.string().uuid(),
  createdAt: z.string().datetime(),
});

export type CreateUserInput = z.infer<typeof CreateUserInputSchema>;
export type UserDto = z.infer<typeof UserDtoSchema>;
```

### 2. Validating at Edge Function Boundary
```ts
import { Hono } from "hono";
import { CreateUserInputSchema } from "@/contracts/users";

const app = new Hono();

app.post("/", async (c) => {
  const rawBody = await c.req.json();
  const input = CreateUserInputSchema.parse(rawBody);
  // Execute domain service with typed input
  return c.json({ success: true, data: result });
});
```

### 3. Writing Contract Unit Tests
Verify that schemas reject invalid payloads deterministically:
```ts
import { describe, it, expect } from "vitest";
import { CreateUserInputSchema } from "./user.schema";

describe("CreateUserInputSchema", () => {
  it("rejects invalid emails", () => {
    expect(() => CreateUserInputSchema.parse({ email: "invalid", fullName: "Alice" })).toThrow();
  });
});
```
