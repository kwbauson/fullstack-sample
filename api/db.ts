import { createConnection } from 'typeorm'
import ormConfig from '../ormconfig.json'
import { User } from './entity/User'

export async function connectToDb() {
  const connection = await createConnection({ ...(ormConfig as any) })
  console.log(connection)
}
