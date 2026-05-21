# Intentionally outdated stack for security scanning / training demos:
# - Node 14 is end-of-life; the Debian Bullseye base accumulates unfixed OS CVEs over time.
# - Pin older app dependencies so scanners have something to report.
FROM node:14-bullseye

LABEL org.opencontainers.image.title="docker-hub-demo"
LABEL org.opencontainers.image.description="Demo app on EOL Node (security tooling workshops)"
LABEL org.opencontainers.image.version="1.1.0"

WORKDIR /app

COPY package.json ./
# Use --omit=dev (not --production): newer npm removed/deprecated --production and can exit 1.
RUN npm install --omit=dev --no-audit --no-fund

COPY server.js ./

ENV NODE_ENV=production \
    APP_VERSION=1.1.0 \
    PORT=3000

EXPOSE 3000

USER node

CMD ["node", "server.js"]
