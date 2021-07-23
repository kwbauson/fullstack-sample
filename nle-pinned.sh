#!/usr/bin/env bash
set -e
rev=650b11934ec808bb5c973983cee88855be41c71f
result=~/.cache/nle/.pinned/$rev
url=https://github.com/kwbauson/cfg/archive/$rev.tar.gz
local_nix_conf=$(dirname "$0")/nix/nix.conf

if [[ -e $local_nix_conf ]];then
  export NIX_CONFIG=$(< "$local_nix_conf")
fi

if [[ ! -e $result ]];then
  mkdir -p "$(dirname "$result")"
  nix build --file "$url" nle.unwrapped --out-link "$result"
fi

exec "$result"/bin/nle "$@"
