#!/bin/bash
# Quick start script for Aframp Rust Backend

set -e

echo "🚀 Aframp Rust Backend - Quick Start"
echo "===================================="
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "📝 Creating .env from .env.example..."
    cp .env.example .env
    echo "⚠️  Please edit .env and add your secrets!"
    echo "   Generate secrets with: openssl rand -hex 32"
    echo ""
    read -p "Press enter when you've updated .env..."
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Start PostgreSQL if not already running
if ! docker ps | grep -q aframp-postgres; then
    echo "🐘 Starting PostgreSQL..."
    docker run -d --name aframp-postgres \
        -e POSTGRES_USER=postgres \
        -e POSTGRES_PASSWORD=postgres \
        -e POSTGRES_DB=aframp \
        -p 5432:5432 \
        postgres:16
    
    # Wait for PostgreSQL to be ready
    echo "⏳ Waiting for PostgreSQL to be ready..."
    sleep 5
fi

# Run migrations
echo "📊 Running database migrations..."
for f in migrations/*.sql; do
    echo "   Running $(basename $f)..."
    docker exec -i aframp-postgres psql -U postgres -d aframp < "$f"
done

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎯 Next steps:"
echo "   1. Start the server: cargo run"
echo "   2. The API will be available at: http://127.0.0.1:3000"
echo "   3. Check health: curl http://127.0.0.1:3000/health"
echo ""
echo "📚 Documentation:"
echo "   - API Reference: API.md"
echo "   - OpenAPI Spec: openapi.yaml"
echo "   - Command Reference: command.txt"
echo ""
