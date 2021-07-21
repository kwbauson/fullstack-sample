#!/usr/bin/env bash

cd "$(dirname "$0")"

set -e
mkdir -p tmp dist/api

yarn
touch dist/api/index.js

if [[ ! -e $PGDATA ]];then
  initdb
fi
