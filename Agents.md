# Codex Contribution Guide

This repository contains a full-stack monorepo using Supabase, Netlify Functions, and Expo. All contributions must include matching tests and follow the tooling already defined.

## Tools
- **dev:web** – start the Expo web app
- **dev:func** – run Netlify Functions locally
- **test:unit** – run unit tests via Vitest
- **test:int** – run integration tests
- **test:e2e** – run Playwright end-to-end suite

## Rules
1. Write tests first for any new function or component. Place unit tests under `tests/` with matching file names.
2. Record deletions in `deletion_audit` via triggers; never remove rows without auditing.
3. Never disable tests to make CI green.

### Example
When adding `functions/foo.ts`, also create `tests/foo.test.ts` covering its behaviour.
