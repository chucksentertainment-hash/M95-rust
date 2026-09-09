@echo off
REM Push to GitHub using GitHub CLI (simplest method)

echo.
echo ========================================
echo  Push M95-rust Using GitHub CLI
echo ========================================
echo.

REM Check if gh is authenticated
echo Checking GitHub CLI authentication...
gh auth status
if errorlevel 1 (
    echo.
    echo ERROR: Not authenticated with GitHub CLI
    echo Please run: gh auth login
    pause
    exit /b 1
)
echo.

REM Stage and commit
echo Staging and committing changes...
git add -A
git commit -m "Separate Rust backend into M95-rust repository - All workflows preserved" 2>nul
echo.

REM Check if repo exists, if not create it
echo Checking if repository exists on GitHub...
gh repo view marvelousufelix/M95-rust 2>nul

if errorlevel 1 (
    echo.
    echo Repository doesn't exist. Creating it now...
    echo.
    gh repo create M95-rust --public --source=. --remote=origin --description "M95-rust - Stellar-powered payment backend for African POS systems"
    
    if errorlevel 1 (
        echo.
        echo Failed to create repository.
        echo Please create it manually at: https://github.com/new
        pause
        exit /b 1
    )
    
    echo.
    echo Repository created! Pushing code...
    echo.
) else (
    echo Repository exists!
    echo Updating remote...
    git remote set-url origin https://github.com/marvelousufelix/M95-rust.git
    echo.
)

REM Configure git to use gh credential helper
git config --global credential.helper "!gh auth git-credential"

REM Push
echo Pushing to GitHub...
git push -u origin master

if errorlevel 1 (
    echo.
    echo Push failed. Trying to force push...
    git push -u origin master --force
    
    if errorlevel 1 (
        echo.
        echo ========================================
        echo  MANUAL FIX NEEDED
        echo ========================================
        echo.
        echo Try these commands:
        echo.
        echo 1. Check branch name:
        echo    git branch
        echo.
        echo 2. If on 'main' branch, push to main:
        echo    git push -u origin main
        echo.
        echo 3. Or rename branch to main:
        echo    git branch -M main
        echo    git push -u origin main
        echo.
        pause
        exit /b 1
    )
)

echo.
echo ========================================
echo  SUCCESS!
echo ========================================
echo.
echo Repository URL:
echo https://github.com/marvelousufelix/M95-rust
echo.
echo Next steps:
echo 1. Visit the URL above
echo 2. Add topics: rust, stellar, blockchain, payments
echo.
pause
