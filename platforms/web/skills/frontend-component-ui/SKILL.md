---
name: frontend-component-ui
description: >-
  Use this skill when developing React/Next.js UI components.
  Enforces the 4-tier component hierarchy (C0-C3), Tailwind styling,
  and presentational separation.
---

# Technology Skill: 4-Tier Frontend Component Development

## Objective
Author responsive, accessible, and maintainable React components adhering to the 4-tier hierarchy.

---

## 4-Tier Implementation Guide

### Level 0: Primitives (`src/components/primitives/`)
* Base Radix wrappers and unstyled layout atoms.
```tsx
import * as DialogPrimitive from "@radix-ui/react-dialog";
export const Dialog = DialogPrimitive.Root;
export const DialogTrigger = DialogPrimitive.Trigger;
```

### Level 1: Generic Controls (`src/components/ui/`)
* Reusable UI kit elements. Receives primitive props or callbacks; zero Domain knowledge.
```tsx
interface StatusBadgeProps {
  label: string;
  variant?: "success" | "warning" | "danger";
}

export function StatusBadge({ label, variant = "success" }: StatusBadgeProps) {
  const styles = {
    success: "bg-emerald-100 text-emerald-800 dark:bg-emerald-950 dark:text-emerald-300",
    warning: "bg-amber-100 text-amber-800 dark:bg-amber-950 dark:text-amber-300",
    danger: "bg-rose-100 text-rose-800 dark:bg-rose-950 dark:text-rose-300",
  };
  return <span className={`px-2 py-0.5 rounded text-xs font-medium ${styles[variant]}`}>{label}</span>;
}
```

### Level 2: Domain Organisms (`src/features/<feature>/components/`)
* Presentational components consuming typed DTOs from `contracts/`. No internal `fetch` or `useQuery`.
```tsx
import type { OrderDto } from "@/contracts/orders";
import { StatusBadge } from "@/components/ui/status-badge";

interface OrderCardProps {
  order: OrderDto;
  onCancel: (id: string) => void;
}

export function OrderCard({ order, onCancel }: OrderCardProps) {
  return (
    <div className="p-4 border rounded-lg flex justify-between items-center">
      <div>
        <h4 className="font-semibold">{order.customerName}</h4>
        <p className="text-sm text-muted-foreground">${order.totalAmount.toFixed(2)}</p>
      </div>
      <StatusBadge label={order.status} />
      <button onClick={() => onCancel(order.id)} className="text-sm text-red-600 hover:underline">
        Cancel
      </button>
    </div>
  );
}
```

### Level 3: Route Screens & Pages (`src/app/**/page.tsx`)
* Connects TanStack Query, URL-first searchParams, and renders C0-C2 components.
```tsx
"use client";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { ordersGateway } from "@/gateway/orders.gateway";
import { OrderCard } from "@/features/orders/components/order-card";

export default function OrdersPage() {
  const queryClient = useQueryClient();
  const { data: orders, isLoading } = useQuery({
    queryKey: ["orders"],
    queryFn: ordersGateway.list,
  });

  const cancelMutation = useMutation({
    mutationFn: ordersGateway.cancel,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["orders"] }),
  });

  if (isLoading) return <div>Loading orders...</div>;
  return (
    <div className="space-y-4 max-w-2xl mx-auto p-6">
      <h1 className="text-2xl font-bold">Orders</h1>
      {orders?.map((o) => (
        <OrderCard key={o.id} order={o} onCancel={(id) => cancelMutation.mutate(id)} />
      ))}
    </div>
  );
}
```
