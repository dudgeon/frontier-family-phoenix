# Frontier Family Phoenix

![CI](https://github.com/dudgeon/frontier-family-phoenix/actions/workflows/ci.yml/badge.svg?branch=main)

Bootstrap monorepo for a **Supabase + Netlify + Expo** chat assistant.

---

## Quick Start

```bash
# install all workspace dependencies
npm install

# run the Expo-web dev server from the repo root
npm run dev:web        # → http://localhost:19006/

# optional – Expo mobile client (when apps/expo exists)
npm run dev:mobile

# optional – start a local Supabase stack (requires Supabase CLI)
supabase start
```

---

## Environment Setup

1. Clone the repo and run `npm install`.  
2. Copy `.env.example` → `.env` and fill in your keys (see **CI Secrets**).  
3. Run `supabase start` **only** if you want a local Postgres; every PR automatically gets its own preview database.

---

## Supabase CLI

After each migration, refresh type-safe DB helpers:

```bash
pnpm dlx supabase-gen types typescript --local
```

This regenerates types in `packages/db`.

---

## 🧑‍💻 Using Codex on This Repo

- Generate test skeletons with

  ```bash
  npm run gen:test path/to/file.ts
  ```

- **Always** include this line in PR descriptions:

  > “Update or create tests in `tests/*` matching each changed function/component…”

- Keep coverage at **80 % +** (CI fails below that).

---

## 🚀 CI / CD Workflow

| Branch / PR | Automation |
|-------------|------------|
| **Pull Request** | • Lint → Tests → Coverage ≥ 80 %<br>• Supabase **preview DB** (branch-isolated)<br>• Netlify **preview URL** auto-commented on the PR |
| **`main`** | • Migrations apply to production DB<br>• Netlify production site deploys |

---

## CI Secrets

Add these repository secrets (Settings → Secrets → Actions):

| Secret | Purpose |
|--------|---------|
| `SUPABASE_ACCESS_TOKEN` | Personal token for Supabase CLI |
| `SUPABASE_PROJECT_ID`   | 6-char Supabase project ref |
| `NETLIFY_AUTH_TOKEN`    | Personal token from Netlify |
| `NETLIFY_SITE_ID`       | UUID of your Netlify site |
| `PROD_SUPABASE_URL`     | URL of prod database |
| `PROD_SUPABASE_ANON_KEY`| Public anon key for prod |

---

Happy building — issues & PRs welcome!
