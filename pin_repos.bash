#!/usr/bin/env bash

set -euxo pipefail

cd lishogi && git checkout a664c1909115b3f5fd427f510d1634335d0b2c1d && cd ..
cd lila-ws && git checkout 60e3a2b02e11c4bb1ce4bfe2d3cb844486a884c5 && cd ..
cd shoginet && git checkout 9d2d5244b5de9e1076deb04d598c4efc13ac6d21 && cd ..

