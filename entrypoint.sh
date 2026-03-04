#!/bin/sh

set -euo pipefail

# for backwards compatibility, separates host and port from url
export BACKEND_DOMAIN=${BACKEND_DOMAIN:-${BACKEND_HOST%:*}}
export BACKEND_PORT=${BACKEND_PORT:-${BACKEND_HOST##*:}}

# strip https:// or http:// from domain if necessary
BACKEND_DOMAIN=${BACKEND_DOMAIN##*://}

echo using backend: ${BACKEND_DOMAIN} with port: ${BACKEND_PORT}

# Optional: mini app upstreams (export-keys, etc.)
if [ -n "${EXPORT_KEYS_DOMAIN:-}" ]; then
	echo using export-keys: ${EXPORT_KEYS_DOMAIN} with port: ${EXPORT_KEYS_PORT:-3000}
fi

exec caddy run --config Caddyfile --adapter caddyfile 2>&1
