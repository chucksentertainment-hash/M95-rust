@echo off
REM Simple push script - Run this now!

echo.
echo ========================================
echo  Pushing M95-rust to GitHub
echo ========================================
echo.
echo Repository: https://github.com/marvelousufelix/M95-rust
echo User: marvelousufelix
echo.

REM Configure Git to use GitHub CLI credentials
echo [Step 1/4] Configuring Git credentials...
git config --global credential.helper "!gh auth git-credential"
echo Done!
echo.

REM Stage and commit changes
echo [Step 2/4] Staging and committing...
git add -A
git commit -m "Initial commit: M95-rust - Rust backend with all workflows preserved"
echo Done!
echo.

REM Set remote URL
echo [Step 3/4] Setting remote URL...
git remote set-url origin https://github.com/marvelousufelix/M95-rust.git
git remote -v
echo.

REM Push to GitHub
echo [Step 4/4] Pushing to GitHub...
echo.

git push -u origin master

if errorlevel 1 (
    echo.
    echo First push failed. Trying with 'main' branch...
    git branch -M main
    git push -u origin main
    
    if errorlevel 1 (
        echo.
        echo ========================================
        echo  Need to create repository first
        echo ========================================
        echo.
        echo Creating repository on GitHub...
        gh repo create M95-rust --public --source=. --remote=origin --description "M95-rust - Stellar-powered payment backend for African POS systems"
        
        if errorlevel 1 (
            echo.
            echo Please create repository manually:
            echo 1. Go to https://github.com/new
            echo 2. Name: M95-rust
            echo 3. Public
            echo 4. Do NOT initialize
            echo 5. Create
            echo.
            echo Then run this script again.
            pause
            exit /b 1
        )
        
        echo.
        echo Repository created! Now pushing...
        git push -u origin main
    )
)

echo.
echo ========================================
echo  SUCCESS! ✓
echo ========================================
echo.
echo Your repository is live at:
echo https://github.com/marvelousufelix/M95-rust
echo.
echo Opening in browser...
start https://github.com/marvelousufelix/M95-rust
echo.
pause
