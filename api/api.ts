import express from 'express'

import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

const router = express.Router()

export const app = express()
app.use('/api', router)

router.get('/hello', (_req, res) => {
  res.json('hello from api')
})

router.get('/now', (_req, res) => {
  res.json(new Date())
})

router.get('/random', (_req, res) => {
  res.json(Math.random())
})
