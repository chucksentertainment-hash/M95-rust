@echo off
REM Push M95-rust to GitHub - marvelousufelix/M95-rust

echo.
echo ========================================
echo  Pushing M95-rust to GitHub
echo ========================================
echo.
echo Repository: https://github.com/marvelousufelix/M95-rust
echo.

REM Step 1: Stage all changes
echo [1/5] Staging all changes...
git add -A
if errorlevel 1 (
    echo ERROR: Failed to stage changes
    pause
    exit /b 1
)
echo     Done!
echo.

REM Step 2: Commit changes
echo [2/5] Committing changes...
git commit -m "Separate Rust backend into M95-rust repository - All workflows preserved"
if errorlevel 1 (
    echo     Note: Nothing to commit or commit failed
)
echo     Done!
echo.

REM Step 3: Update remote URL
echo [3/5] Updating remote URL to your repository...
git remote set-url origin https://github.com/marvelousufelix/M95-rust.git
if errorlevel 1 (
    echo ERROR: Failed to update remote URL
    pause
    exit /b 1
)
echo     Done!
echo.

REM Step 4: Verify remote
echo [4/5] Verifying remote configuration...
git remote -v
echo.

REM Step 5: Push to GitHub
echo [5/5] Pushing to GitHub...
echo.
echo You may be prompted for credentials:
echo   Username: marvelousufelix
echo   Password: Use your GitHub Personal Access Token
echo.
echo Pushing to master branch...
echo.

git push -u origin master

if errorlevel 1 (
    echo.
    echo ========================================
    echo  PUSH FAILED
    echo ========================================
    echo.
    echo Common issues:
    echo   1. Repository doesn't exist on GitHub
    echo      - Create it at: https://github.com/new
    echo      - Name: M95-rust
    echo      - DO NOT initialize with README
    echo.
    echo   2. Authentication failed
    echo      - Use Personal Access Token as password
    echo      - Create at: https://github.com/settings/tokens
    echo.
    echo   3. Branch mismatch
    echo      - Try: git branch -M main
    echo      - Then: git push -u origin main
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo  SUCCESS!
echo ========================================
echo.
echo Your repository is now available at:
echo https://github.com/marvelousufelix/M95-rust
echo.
echo Next steps:
echo   1. Visit the URL above to verify
echo   2. Add repository description
echo   3. Add topics: rust, stellar, blockchain, payments
echo.
pause
