#!/usr/bin/env bash

set -euxo pipefail

[ -d "./repos/lishogi" ] || git -C ./repos clone git@github.com:WandererXII/lishogi.git
[ -d "./repos/lila-ws" ] || git -C ./repos clone git@github.com:WandererXII/lila-ws.git
[ -d "./repos/shoginet" ] || git -C ./repos clone git@github.com:WandererXII/shoginet.git
[ -d "./repos/lishogi-db-scripts" ] || git -C ./repos clone git@github.com:WandererXII/lishogi-db-scripts.git
