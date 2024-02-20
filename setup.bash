#!/usr/bin/env bash

set -euxo pipefail

[ -d "./repos/lila-ws" ] || git -C ./repos clone git@github.com:WandererXII/lila-ws.git
[ -d "./repos/shoginet" ] || git -C ./repos clone git@github.com:WandererXII/shoginet.git
