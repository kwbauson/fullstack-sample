import { createConnection } from 'typeorm'

export async function connectToDb() {
  const connection = await createConnection({
    type: 'postgres',
    database: 'db',
  })
  console.log(connection)
}
