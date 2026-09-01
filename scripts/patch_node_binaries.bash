#!/usr/bin/env bash

set -euxo pipefail

INTERP="$(cat "$(nix-build '<nixpkgs>' -A stdenv.cc --no-out-link)/nix-support/dynamic-linker")"
LIB_PATH="$(nix-build '<nixpkgs>' -A stdenv.cc.cc.lib --no-out-link)/lib"

find ./repos/lishogi/node_modules -type f \( -name "dart" -o -name "biome" \) | while read -r bin; do
	patchelf --set-interpreter "$INTERP" --set-rpath "$LIB_PATH" "$bin" 2>/dev/null || true
done
