#Production Docker Image 
FROM node:alpine as builder

WORKDIR /app

# Minimizing Cache Busting and Rebuilds
COPY package.json .
RUN npm i https://github.com/Qix-/node-error-ex
RUN npm install

COPY . .
RUN npm run build

# /app/build => input to run phase

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
