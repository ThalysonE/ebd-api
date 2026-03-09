# --- Stage 1: Build ---
FROM node:18-alpine AS builder

RUN npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
COPY prisma ./prisma

RUN pnpm install --frozen-lockfile --strict-peer-dependencies=false

RUN pnpm prisma generate

COPY . .

RUN pnpm run build

# --- Stage 2: Production ---
FROM node:18-alpine

RUN npm install -g pnpm

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
COPY prisma ./prisma

RUN pnpm install --frozen-lockfile --prod --strict-peer-dependencies=false

COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma
COPY --from=builder /app/node_modules/@prisma ./node_modules/@prisma
COPY --from=builder /app/dist ./dist

EXPOSE ${PORT:-3333}

CMD ["sh", "-c", "pnpm prisma migrate deploy && node dist/src/infra/main"]
