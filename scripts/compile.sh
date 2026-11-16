#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
exec latexmk -interaction=nonstopmode -halt-on-error "$@"
