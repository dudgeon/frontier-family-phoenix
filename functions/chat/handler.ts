import { Handler, stream } from '@netlify/functions'

export const handler: Handler = async (event) => {
  const { messages } = JSON.parse(event.body || '{}')

  const response = await fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${process.env.OPENAI_KEY}`,
    },
    body: JSON.stringify({
      model: 'gpt-4',
      stream: true,
      messages,
    }),
  })

  return stream(response.body!, { status: response.status })
}
