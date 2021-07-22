#!/usr/bin/env bash
set -e
rev=674da62391d2306578f118052fd9d6535c387230
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
