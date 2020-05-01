'use strict'

const express = require('express')

const HOST = process.env.LISTEN_HOST
const PORT = process.env.LISTEN_PORT
const SECRET = process.env.TEST_SECRET

const app = express()

app.get('/', (req, res) => {
  console.log(`Said hello to ${req.ip}`)
  // Example secret retrieval, obviously in the real world you
  // would never put secrets in public places!
  res.send(`Top secret message: ${SECRET}`)
});

app.listen(PORT, HOST)

console.log(`Listening on http://${HOST}:${PORT}`)

