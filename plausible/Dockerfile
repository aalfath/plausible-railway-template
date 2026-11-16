# Plausible Analytics Community Edition, pinned by version and digest.
# Update: change the tag and digest together, then add a CHANGELOG.md entry.
FROM ghcr.io/plausible/community-edition:v3.2.1@sha256:33e60bfb40f2df5da00f8753b76fad04f67dba3abe6d73eb516e440e3fb62985

# Railway mounts volumes owned by root, so the app runs as root to write /var/lib/plausible.
USER root

COPY --chmod=755 start.sh /railway-start.sh

ENTRYPOINT ["/railway-start.sh"]
