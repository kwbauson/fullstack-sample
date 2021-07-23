import express from 'express'

import { PrismaClient, User } from '@prisma/client'

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

router.get('/users', async (_req, res) => {
  const users = await prisma.user.findMany()
  res.json(users)
})

router.post<User[]>('/users', async (req, res) => {
  await prisma.user.createMany({ data: req.params })
  res.json('success!')
})

router.get('/create-random-user', async (_req, res) => {
  try {
    const rand = Math.random()
    await prisma.user.create({
      data: {
        name: `Meme ${rand}`,
        email: `meme_${rand}@example.com`,
      },
    })
    res.json('success!')
  } catch {
    res.json('failed :(')
  }
})
