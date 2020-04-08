'use strict'

const express = require('express')

const HOST = process.env.LISTEN_HOST
const PORT = process.env.LISTEN_PORT

const app = express()

app.get('/', (req, res) => {
  console.log(`Said hello to ${req.ip}`)
  res.send('Hello World')
});

app.listen(PORT, HOST)

console.log(`Listening on http://${HOST}:${PORT}`)

