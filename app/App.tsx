import React, { useState, useEffect } from 'react'
import type { User } from '@prisma/client'

const Counter = () => {
  const [count, setCount] = useState(0)
  const increment = () => setCount(count + 1)
  return <button onClick={increment}>increment {count}</button>
}

const ApiView = ({ path }: { path: string }) => {
  const [response, setResponse] = useState<string>()
  const [clicked, setClicked] = useState(false)
  useEffect(() => {
    async function doFetch() {
      const res = await fetch(path)
      setResponse(await res.json())
    }
    if (clicked) {
      doFetch()
      setClicked(false)
    }
  })
  return (
    <div>
      <button onClick={() => setClicked(true)}>get {path}</button> response:{' '}
      <code>{JSON.stringify(response)}</code>
    </div>
  )
}

const LookMaAUser = () => {
  const user: User = {
    id: 1,
    name: 'Colton Nerd',
    email: 'colton@nerd.com',
  }
  return (
    <>
      Look ma, a user!
      <pre>{JSON.stringify(user)}</pre>
    </>
  )
}

export const App = () => (
  <>
    <p>hello from app</p>
    <p>
      you can use this counter to test react hmr. changing text shouldn't reset
      the counter
    </p>
    <Counter />
    <hr />
    <ApiView path="/api/hello" />
    <ApiView path="/api/now" />
    <ApiView path="/api/random" />
    <ApiView path="/api/users" />
    <ApiView path="/api/create-random-user" />
    <LookMaAUser />
  </>
)
