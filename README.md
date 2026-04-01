# ShopSavvy CLI Docker Image

Run the ShopSavvy CLI in a container.

## Quick Start

```bash
# Search for products
docker run --rm -e SHOPSAVVY_API_KEY=ss_live_yourkey shopsavvy/cli search "AirPods Pro"

# Check prices
docker run --rm -e SHOPSAVVY_API_KEY=ss_live_yourkey shopsavvy/cli price B0D1XD1ZV3

# Browse deals
docker run --rm -e SHOPSAVVY_API_KEY=ss_live_yourkey shopsavvy/cli deals
```

## Docker Compose

```yaml
services:
  shopsavvy:
    image: shopsavvy/cli
    environment:
      - SHOPSAVVY_API_KEY=${SHOPSAVVY_API_KEY}
    command: ["search", "AirPods Pro"]
```

## Build Locally

```bash
docker build -t shopsavvy/cli .
docker run --rm -e SHOPSAVVY_API_KEY=ss_live_yourkey shopsavvy/cli search "iPhone 16"
```

## Getting an API Key

1. Go to [shopsavvy.com/data](https://shopsavvy.com/data)
2. Create an account and get your API key
3. Pass it via `SHOPSAVVY_API_KEY` environment variable

## All Commands

```bash
docker run --rm shopsavvy/cli help
```

See [shopsavvy-cli](https://github.com/shopsavvy/shopsavvy-cli) for full CLI documentation.

## License

MIT
