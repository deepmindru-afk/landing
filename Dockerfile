# syntax=docker/dockerfile:1

# ---- deps -------------------------------------------------------------------
# Only the manifest and lockfile, so this layer is reused whenever app source
# changes but dependencies do not.
FROM node:24-slim AS deps

ENV PNPM_HOME=/pnpm
ENV PATH=$PNPM_HOME:$PATH

RUN corepack enable

WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# pnpm 12 ignores PNPM_STORE_DIR/npm_config_store_dir for the store location, so
# the cache-mount path is passed explicitly via --store-dir.
# The `nuxt prepare` postinstall runs here and succeeds without app/ source,
# which keeps this layer cacheable across source-only changes.
RUN --mount=type=cache,id=pnpm-store,target=/pnpm/store \
    pnpm install --frozen-lockfile --store-dir /pnpm/store

# ---- build ------------------------------------------------------------------
FROM node:24-slim AS build

ENV PNPM_HOME=/pnpm
ENV PATH=$PNPM_HOME:$PATH
ENV NODE_ENV=production

RUN corepack enable

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN pnpm build

# ---- runtime ----------------------------------------------------------------
# The Nitro `node-server` output has no native modules, so the runtime image
# only needs Node and the built .output directory.
FROM node:24-slim AS runtime

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=3000
ENV NITRO_PORT=3000

WORKDIR /app

COPY --from=build --chown=node:node /app/.output ./.output

USER node

EXPOSE 3000

CMD ["node", ".output/server/index.mjs"]
