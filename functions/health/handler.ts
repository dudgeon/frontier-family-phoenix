import { Handler, stream } from "@netlify/functions";
import { ReadableStream } from "node:stream/web";

export const handler: Handler = async () => {
  const body = JSON.stringify({ ok: true, ts: Date.now() });
  const readable = new ReadableStream({
    start(controller) {
      controller.enqueue(new TextEncoder().encode(body));
      controller.close();
    },
  });
  return stream(readable, {
    status: 200,
    headers: { "content-type": "application/json" },
  });
};
