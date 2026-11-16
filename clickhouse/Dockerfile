# ClickHouse for Plausible's event data, pinned by version and digest.
# 24.12 is the version Plausible CE's own compose file uses.
FROM clickhouse/clickhouse-server:24.12.6.70-alpine@sha256:cd450891db46cc6ffe313ca2b0fb7dbfb897a6873ca74a724cbe050a2cf62621

# Database and user created on first start. The password comes from CLICKHOUSE_PASSWORD.
ENV CLICKHOUSE_DB=plausible_events_db \
    CLICKHOUSE_USER=plausible \
    CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT=0

# Plausible's recommended low-resource and logging settings, plus IPv4/IPv6 listening.
COPY logs.xml listen.xml low-resources.xml /etc/clickhouse-server/config.d/
COPY default-profile-low-resources-overrides.xml /etc/clickhouse-server/users.d/
