#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/pypi.sh"

versions_hooks+=( hook_no-prereleases )

export KHULNASOFT_PYTHON_FROM_TEMPLATE='python:%%PYTHON%%-alpine3.20'

json="$(pypi 'ruamel.yaml')"

jq <<<"$json" '.' > versions.json
