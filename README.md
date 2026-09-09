# Aframp - Rust Backend

**Building the POS network for Stellar in Africa.**

This is the core Rust backend API for Aframp, handling all payment processing, Stellar integration, and merchant management.

## Architecture

This repository contains only the Rust backend. The Cloudflare Worker proxy has been separated into its own repository.

## Quick Start

### Prerequisites

- Rust (stable, 2021 edition)
- PostgreSQL

### Setup

```bash
cp .env.example .env
# Edit .env with your configuration
```

### Environment Variables

| Variable | Required | Default | Description |
|---|---|---|---|
| `DATABASE_URL` | yes | — | Postgres connection string |
| `APP_BIND_ADDR` | no | `127.0.0.1:3000` | Address the HTTP server binds to |
| `JWT_SECRET` | yes | — | Secret used to sign merchant session tokens. Generate with `openssl rand -hex 32` |
| `WEBHOOK_SECRET` | yes | — | Secret used to verify inbound provider webhooks. Generate with `openssl rand -hex 32` |
| `WALLET_ENCRYPTION_KEY` | yes | — | AES-256-GCM key encrypting Stellar wallet secrets at rest. Generate with `openssl rand -hex 32` (must decode to exactly 32 bytes) |
| `STELLAR_SYSTEM_WALLET_ADDRESS` | yes | — | Reserved for a future platform settlement/sweep wallet. Validated at startup but not used by deposit detection today |
| `STELLAR_HORIZON_URL` | no | `https://horizon-testnet.stellar.org` | Horizon endpoint to poll |
| `STELLAR_POLL_INTERVAL_SECS` | no | `60` | How often the deposit-detection worker polls Horizon, per wallet |
| `PAYSTACK_SECRET_KEY` | yes | — | Paystack Dashboard → Settings → API Keys & Webhooks. `sk_test_...` for dev, `sk_live_...` only once the business is verified/activated for Transfers |
| `CORS_ALLOWED_ORIGINS` | no | `http://localhost:3001` | Comma-separated browser origins allowed to call the API |
| `COOKIE_SECURE` | no | `true` | Whether the session cookie carries `Secure` |
| `COOKIE_SAME_SITE` | no | `lax` | `lax` or `none` |

### Running with Docker Postgres

```bash
docker run -d --name aframp-postgres \
  -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=aframp \
  -p 5432:5432 postgres:16

# Run migrations
for f in migrations/*.sql; do
  docker exec -i aframp-postgres psql -U postgres -d aframp < "$f"
done

# Start the server
cargo run
```

### Running Tests

```bash
docker exec -i aframp-postgres psql -U postgres -c "CREATE DATABASE aframp_test;"
TEST_DATABASE_URL=postgres://postgres:postgres@localhost:5432/aframp_test cargo test
```

## Tech Stack

- **Rust** + [Axum](https://github.com/tokio-rs/axum) — HTTP API
- **PostgreSQL** via [sqlx](https://github.com/launchbadge/sqlx) — runtime-checked queries
- **Stellar** ([Horizon](https://developers.stellar.org/docs/data/horizon)) — settlement network
- **ed25519-dalek** + **stellar-strkey** — Stellar keypair generation
- **aes-gcm** — encrypts wallet private keys at rest
- **JWT** ([jsonwebtoken](https://github.com/Keats/jsonwebtoken)) + **Argon2** — auth and password hashing
- **Tokio** — async runtime, including the background Stellar polling worker
- **Paystack Transfers API** — Nigerian bank payouts

## Documentation

- **[`WORKFLOW.md`](WORKFLOW.md)** - Complete development workflow guide (setup, testing, deployment)
- **[`API.md`](API.md)** - Complete API reference with examples
- **[`openapi.yaml`](openapi.yaml)** - Machine-readable OpenAPI spec
- **[`command.txt`](command.txt)** - Quick command reference for copy/paste

## Project Structure

```
src/
  api/         HTTP handlers (thin — validation + calling services)
  auth/        JWT signing/verification, password hashing, auth extractor
  blockchain/  Stellar integration: keypair generation, wallet-secret encryption,
               Horizon deposit polling, and the background worker that drives it
  models/      Request/response and row types
  services/    Business logic (users, wallets, balances, payments, payment_requests, withdrawals)
  payments/    PaymentProvider abstraction — real PaystackProvider + a MockProvider for tests
migrations/    SQL schema migrations (sqlx)
tests/         Integration tests (auth, wallet, payment request, withdrawal flows)
examples/      prove_payment_loop.rs — end-to-end demo harness (real testnet payment)
```

## Deployment

The server binds to `127.0.0.1:3000` by default and expects a TLS-terminating reverse proxy in front of it.

For Cloudflare deployment, see the separate `aframp-cloudflare-worker` repository.

## Contributing

Open an issue or PR against `master`.

## License

See LICENSE file.
