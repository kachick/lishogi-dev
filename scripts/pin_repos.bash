#!/usr/bin/env bash

set -euxo pipefail

cd ./repos/lishogi && git checkout acb3b12286dd41bc88edfa81172e6a5e7f68c52b && cd ../..
cd ./repos/lila-ws && git checkout 4329e717f2ddebcfd3f167897199ec4ee02f90c5 && cd ../..
cd ./repos/shoginet && git checkout 2669e52994445e772a043fa76f471b7a8b2ba884 && cd ../..
cd ./repos/lishogi-db-scripts && git checkout daffb4f68654f894c02da02ad648ef6739b9d02f && cd ../..
