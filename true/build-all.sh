#!/usr/bin/env bash
set -Eeuo pipefail

dir="$(dirname "$BASH_SOURCE")"
cd "$dir"

make clean
docker build --pull --file Dockerfile.all --tag khulnasoft/true:all .
docker run --rm khulnasoft/true:all sh -c 'tar --create true-*' | tar --extract --verbose
