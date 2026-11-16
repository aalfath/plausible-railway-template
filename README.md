[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/plausible-analytics?utm_medium=integration&utm_source=button&utm_campaign=plausible)

# Plausible Analytics on Railway

A Railway template for [Plausible Analytics Community Edition](https://github.com/plausible/community-edition), the self-hosted, cookie-free, privacy-friendly web analytics app.

## What it deploys

| Service | Source | Purpose |
|---|---|---|
| **Plausible** | `plausible/` in this repo, `ghcr.io/plausible/community-edition:v3.2.1` pinned by digest | Web app and event collector, public on a Railway domain. Volume at `/var/lib/plausible` |
| **ClickHouse** | `clickhouse/` in this repo, `clickhouse/clickhouse-server:24.12.6.70-alpine` pinned by digest | Event storage, with Plausible's low-resource settings. Private network only. Volume at `/var/lib/clickhouse` |
| **Postgres** | Railway's PostgreSQL | Users, sites and settings |

## Variables

| Service | Variable | Default | Notes |
|---|---|---|---|
| Plausible | `BASE_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Change it if you add a custom domain |
| Plausible | `SECRET_KEY_BASE` | generated, 64 characters | Signs sessions. Keep it stable |
| Plausible | `TOTP_VAULT_KEY` | generated, Base64 of 32 bytes | Encrypts two-factor secrets. Keep it stable |
| Plausible | `DATABASE_URL` | `${{Postgres.DATABASE_URL}}` | |
| Plausible | `CLICKHOUSE_DATABASE_URL` | built from the ClickHouse service | |
| ClickHouse | `CLICKHOUSE_PASSWORD` | generated | Password of the `plausible` ClickHouse user |

Set in `plausible/start.sh`, and overridable with a service variable: `HTTP_PORT` (Railway's `PORT`), `DISABLE_REGISTRATION=invite_only` (only the first account can sign up, everyone else needs an invite), `ENABLE_EMAIL_VERIFICATION=false`.

Optional, not set by the template: email (`MAILER_EMAIL`, `SMTP_HOST_ADDR`, `SMTP_HOST_PORT`, `SMTP_USER_NAME`, `SMTP_USER_PWD`, or Postmark, Mailgun, SendGrid keys), Google Search Console import (`GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`) and MaxMind city geolocation (`MAXMIND_LICENSE_KEY`). See Plausible's [configuration wiki](https://github.com/plausible/community-edition/wiki/configuration).

## First steps

1. Open the Plausible service's public URL and create the first account. That account owns the instance.
2. Add your site and paste the tracking snippet into your pages.
3. Invite teammates from the site settings. Open registration is off.

## Updates

Each service builds from this repo's `main` branch. When we bump a pinned version here, Railway shows an "update available" notice on your project, and you choose when to apply it. Read [CHANGELOG.md](CHANGELOG.md) first: breaking changes are listed at the top of each entry. Plausible runs its database migrations on every start.

Health check: `/api/health` on the Plausible service.
