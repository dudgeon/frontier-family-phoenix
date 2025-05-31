import { describe, it, expect } from "vitest";
import { handler } from "../../functions/health/handler";

describe("health function", () => {
  it("returns status 200", async () => {
    const res: any = await handler({} as any, {} as any);
    expect(res.statusCode ?? res.status).toBe(200);
  });
});
