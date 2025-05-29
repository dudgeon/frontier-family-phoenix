import * as Sentry from 'sentry-expo'
Sentry.init({ dsn: process.env.SENTRY_DSN })
export default function App() {
  return null
}
