FROM node:24-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:24-alpine AS runtime

WORKDIR /app

COPY --from=build /app/build ./build
COPY --from=build /app/package.json ./package.json

EXPOSE 3000

ENV NODE_ENV=production

CMD ["node", "build"]