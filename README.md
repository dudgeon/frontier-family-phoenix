# Frontier Family Phoenix

Bootstrap monorepo for a Supabase + Netlify + Expo chat assistant.

## Quick Start

```bash
npm install
# requires Supabase CLI
supabase start
npm run dev:web
```

## Environment Setup

Clone the repo and run `npm install`. Create a `.env` file with your keys. Run `supabase start` to launch the local database.

## Supabase CLI

Ensure `supabase` CLI is installed. Use `pnpm dlx supabase-gen types typescript --local` after running migrations to refresh DB types in `packages/db`.

## 🧑‍💻 Using Codex on This Repo

- Generate test skeletons with `npm run gen:test path/to/file.ts`.
- When sending feature PRs include the snippet:
  "Update or create tests in tests/* matching each changed function/component…"
- Keep coverage at **80% or higher**.
