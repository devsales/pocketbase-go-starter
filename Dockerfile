# Ideas from:
# - https://pnpm.io/docker
# - https://www.liip.ch/en/blog/embed-sveltekit-into-a-go-binary
# - https://dev.to/aryaprakasa/serving-single-page-application-in-a-single-binary-file-with-go-12ij
# - https://github.com/TylerSustare/pocketbase-framework-litestream/tree/main

# Stage 1 - setup node environment with pnpm
FROM node:22-slim AS ui-base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
COPY ./ui /ui
WORKDIR /ui

# Stage 2 - UI install & build
FROM ui-base AS ui-builder
RUN pnpm install
RUN pnpm run build

# Stage 3 - copy static files & build Go server
FROM golang:1.24-alpine AS builder
WORKDIR /src/app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY main.go ./
COPY ./src ./src
COPY ./migrations ./migrations
COPY --from=ui-builder ./ui/embed.go ./ui/embed.go
COPY --from=ui-builder ./ui/dist ./ui/dist

RUN go build -o server

# Download the static build of Litestream directly into the path & make it executable.
# This is done in the builder and copied as the chmod doubles the size.
# Note: You will want to mount your own Litestream configuration file at /etc/litestream.yml in the container.
# Example: https://github.com/benbjohnson/litestream-docker-example or https://litestream.io/guides/docker/
ADD https://github.com/benbjohnson/litestream/releases/download/v0.3.13/litestream-v0.3.13-linux-amd64.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz

# Stage 4 - run server
FROM alpine:3.20
WORKDIR /root/

COPY --from=builder /src/app ./app
COPY --from=builder /usr/local/bin/litestream /usr/local/bin/litestream

RUN apk add bash

# Copy Litestream configuration file & startup script.
COPY etc/litestream.yml /etc/litestream.yml
COPY scripts/run.sh /scripts/run.sh

RUN chmod +x /scripts/run.sh
RUN chmod +x /usr/local/bin/litestream

EXPOSE 8080
#CMD ["./app/server", "serve", "--http=0.0.0.0:8080"]
CMD [ "/scripts/run.sh" ]