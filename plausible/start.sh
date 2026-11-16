#!/bin/sh
# Railway start script for Plausible Analytics CE.
# Fixed settings live here, so the template only carries references and secrets.
set -e

# Listen on Railway's PORT (Plausible's default is 8000).
export HTTP_PORT="${HTTP_PORT:-${PORT:-8000}}"

# Public URL: BASE_URL from the template, else the Railway domain.
if [ -z "$BASE_URL" ] && [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
  export BASE_URL="https://${RAILWAY_PUBLIC_DOMAIN}"
fi

# Only the first account may sign up; everyone else needs an invite.
export DISABLE_REGISTRATION="${DISABLE_REGISTRATION:-invite_only}"
export ENABLE_EMAIL_VERIFICATION="${ENABLE_EMAIL_VERIFICATION:-false}"

# Temp files and the geolocation database go on the volume.
export TMPDIR="${TMPDIR:-/var/lib/plausible/tmp}"
mkdir -p "$TMPDIR"

/entrypoint.sh db createdb
/entrypoint.sh db migrate
exec /entrypoint.sh run
