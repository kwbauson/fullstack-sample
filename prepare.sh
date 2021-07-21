#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

mkdir -p tmp dist/api

yarn
touch dist/api/index.js

if [[ ! -e $PGDATA ]];then
  initdb
  pg_ctl -o "-k '$PGDATA'" -D "$PGDATA" start
  createdb -h "$PGDATA" db
  pg_ctl -o "-k '$PGDATA'" -D "$PGDATA" stop
fi
