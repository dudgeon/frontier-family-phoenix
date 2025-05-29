import { test, expect } from "@playwright/test";

const base = process.env.E2E_BASE_URL || "http://localhost:8888";

test("banner visible", async ({ page }) => {
  await page.goto(base);
  const banner = page.locator('[testID="health-banner"]');
  await expect(banner).toBeVisible();
});
