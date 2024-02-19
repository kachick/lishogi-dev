#!/bin/bash

set -euxo pipefail

databaseDir="$1"

echo "${databaseDir="$(mktemp -d --suffix=.lishogi.mongo.database)"}"
singularity run --bind "${databaseDir}:/data/db" docker://mongo:5.0.24-focal
