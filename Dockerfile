# ---------- Stage 1: build (the kitchen) ----------
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --ignore-scripts
COPY . .
RUN npm run build

# ---------- Stage 2: final image (the lunchbox) ----------
FROM node:22-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY package*.json ./
RUN npm ci --omit=dev --ignore-scripts
COPY --from=build /app/dist ./dist
USER node
# Documentation only: says the app listens on 3000. It doesn't open or publish the port.
EXPOSE 3000
CMD ["node", "dist/main"]
