import * as Sentry from "sentry-expo";
import CoreApp from "../app/App";

Sentry.init({ dsn: process.env.SENTRY_DSN });

export default function App() {
  return <CoreApp />;
}
