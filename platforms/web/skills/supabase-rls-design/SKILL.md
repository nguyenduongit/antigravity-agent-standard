---
name: supabase-rls-design
description: >-
  Use this skill when creating database migrations, designing PostgreSQL schemas,
  or writing bulletproof Row Level Security (RLS) policies in Supabase.
---

# Technology Skill: Supabase PostgreSQL & RLS Design

## Objective
Author secure, versioned database migrations with complete Row-Level Security coverage to ensure multi-tenant data isolation at the database engine level.

---

## Technical Procedures

### 1. Authoring Versioned Migrations
Always generate migrations inside `supabase/migrations/<YYYYMMDDHHMMSS>_<name>.sql`:
```sql
-- 1. Create table
CREATE TABLE public.projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    workspace_id UUID NOT NULL REFERENCES public.workspaces(id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. MANDATORY: Enable RLS
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;

-- 3. Create granular RLS policies
CREATE POLICY "Users can view projects in their workspace"
    ON public.projects
    FOR SELECT
    USING (
        auth.uid() = owner_id OR
        EXISTS (
            SELECT 1 FROM public.workspace_members
            WHERE workspace_members.workspace_id = projects.workspace_id
            AND workspace_members.user_id = auth.uid()
        )
    );

CREATE POLICY "Users can insert projects they own"
    ON public.projects
    FOR INSERT
    WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can update their projects"
    ON public.projects
    FOR UPDATE
    USING (auth.uid() = owner_id)
    WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Owners can delete their projects"
    ON public.projects
    FOR DELETE
    USING (auth.uid() = owner_id);
```

### 2. RLS Security Rules
* Always write policies for `SELECT`, `INSERT`, `UPDATE`, and `DELETE` separately.
* Never use `USING (true)` on writable tables without documented security review.
* Indexes: Always index columns used in foreign keys and RLS `USING` clauses (`owner_id`, `workspace_id`).
