#!/usr/bin/env bash

cd "$(dirname "$0")"

set -e
mkdir -p tmp dist/api

yarn
touch dist/api/index.js

if [[ ! -e $PGDATA ]];then
  initdb --username test --pwfile <(echo test)
  pg_ctl -o "-k '$PGDATA'" -D "$PGDATA" start
  createdb -h "$PGDATA" test -U test
  prisma db push
  pg_ctl -o "-k '$PGDATA'" -D "$PGDATA" stop
fi
