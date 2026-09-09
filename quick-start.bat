@echo off
REM Quick start script for Aframp Rust Backend (Windows)

echo.
echo 🚀 Aframp Rust Backend - Quick Start
echo ====================================
echo.

REM Check if .env exists
if not exist .env (
    echo 📝 Creating .env from .env.example...
    copy .env.example .env
    echo ⚠️  Please edit .env and add your secrets!
    echo    Generate secrets with: openssl rand -hex 32
    echo.
    pause
)

REM Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not running. Please start Docker and try again.
    exit /b 1
)

REM Start PostgreSQL if not already running
docker ps | findstr aframp-postgres >nul
if errorlevel 1 (
    echo 🐘 Starting PostgreSQL...
    docker run -d --name aframp-postgres ^
        -e POSTGRES_USER=postgres ^
        -e POSTGRES_PASSWORD=postgres ^
        -e POSTGRES_DB=aframp ^
        -p 5432:5432 ^
        postgres:16
    
    echo ⏳ Waiting for PostgreSQL to be ready...
    timeout /t 5 /nobreak >nul
)

REM Run migrations
echo 📊 Running database migrations...
for %%f in (migrations\*.sql) do (
    echo    Running %%~nxf...
    docker exec -i aframp-postgres psql -U postgres -d aframp < "%%f"
)

echo.
echo ✅ Setup complete!
echo.
echo 🎯 Next steps:
echo    1. Start the server: cargo run
echo    2. The API will be available at: http://127.0.0.1:3000
echo    3. Check health: curl http://127.0.0.1:3000/health
echo.
echo 📚 Documentation:
echo    - API Reference: API.md
echo    - OpenAPI Spec: openapi.yaml
echo    - Command Reference: command.txt
echo.
pause
