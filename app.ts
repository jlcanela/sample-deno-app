// src/app.ts
import { Hono } from 'hono'
const app = new Hono()

app.get('/', (c) => c.text('Hello App!'))
app.get('/health', (c) => c.text('ok'))

export default app
