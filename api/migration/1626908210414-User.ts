import { MigrationInterface, QueryRunner } from 'typeorm'

export class User1626908210414 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    queryRunner.query('CREATE TABLE user')
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    queryRunner.query('DROP TABLE user')
  }
}
