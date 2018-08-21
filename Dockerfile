FROM node:10 as builder
WORKDIR /build/
COPY package.json .
COPY elm-package.json .
COPY yarn.lock .
RUN yarn install
RUN yarn global add elm
RUN elm-package install -y
COPY webpack.config.js .
COPY src/ ./src/
RUN yarn build

FROM nginx:alpine as complete
COPY --from=builder /build/dist/ /usr/share/nginx/html/
EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
