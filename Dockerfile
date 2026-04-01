FROM oven/bun:1 AS builder

WORKDIR /app

# Clone and build the CLI
RUN apt-get update && apt-get install -y git && \
    git clone --depth 1 https://github.com/shopsavvy/shopsavvy-cli.git . && \
    bun install && \
    bun build --compile src/cli.ts --outfile shopsavvy

# Minimal runtime image
FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/shopsavvy /usr/local/bin/shopsavvy

ENTRYPOINT ["shopsavvy"]
