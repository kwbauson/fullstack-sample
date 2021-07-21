import http from 'http'
import express from 'express'
import { app } from './api'
const port = 3000

app.use(express.static('dist/app'))

const server = http.createServer((req, res) => app(req, res))
server.listen(port, () => {
  console.log(`Listening on port ${port}`)
})
