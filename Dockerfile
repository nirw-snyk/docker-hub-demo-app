# Node 22 on Debian Bullseye for a current LTS runtime with a stable glibc base.
# App still pins an older Express release for dependency-focused security demos.
FROM node:22-bullseye

LABEL org.opencontainers.image.title="docker-hub-demo"
LABEL org.opencontainers.image.description="Demo HTTP app for container / Docker Hub and security tooling workshops"
LABEL org.opencontainers.image.version="1.2.0"

WORKDIR /app

COPY package.json ./
# Use --omit=dev (not --production): newer npm removed/deprecated --production and can exit 1.
RUN npm install --omit=dev --no-audit --no-fund

COPY server.js ./

ENV NODE_ENV=production \
    APP_VERSION=1.2.0 \
    PORT=3000

EXPOSE 3000

USER node

CMD ["node", "server.js"]
