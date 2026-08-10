FROM node:20-slim AS build
WORKDIR /app

COPY package*.json ./
RUN npm install ajv@^8 ajv-keywords@^5 zod@^3.22.3 --legacy-peer-deps


COPY . .
RUN DISABLE_ESLINT_PLUGIN=true npm run build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
