@echo off
REM Fix Git credentials and push to GitHub

echo.
echo ========================================
echo  Fixing Credentials and Pushing
echo ========================================
echo.

REM Step 1: Clear old GitHub credentials
echo [1/6] Clearing old GitHub credentials...
echo This will open Windows Credential Manager...
echo.
cmdkey /list | findstr github
echo.
echo Removing old credentials...
cmdkey /delete:git:https://github.com 2>nul
cmdkey /delete:LegacyGeneric:target=git:https://github.com 2>nul
echo     Done!
echo.

REM Step 2: Configure Git to use GitHub CLI
echo [2/6] Configuring Git to use GitHub CLI helper...
git config --global credential.helper ""
git config --global credential.helper "!gh auth git-credential"
echo     Done!
echo.

REM Step 3: Verify GitHub CLI authentication
echo [3/6] Verifying GitHub CLI authentication...
gh auth status
echo.

REM Step 4: Stage and commit
echo [4/6] Staging and committing changes...
git add -A
git commit -m "Separate Rust backend into M95-rust repository - All workflows preserved" 2>nul
echo     Done!
echo.

REM Step 5: Update remote
echo [5/6] Updating remote URL...
git remote set-url origin https://github.com/marvelousufelix/M95-rust.git
git remote -v
echo.

REM Step 6: Push to GitHub
echo [6/6] Pushing to GitHub...
echo.
echo Using GitHub CLI credentials...
echo.

git push -u origin master

if errorlevel 1 (
    echo.
    echo ========================================
    echo  PUSH FAILED - ALTERNATIVE SOLUTION
    echo ========================================
    echo.
    echo Let's try using gh CLI directly:
    echo.
    pause
    
    echo Trying with gh...
    gh repo view marvelousufelix/M95-rust 2>nul
    if errorlevel 1 (
        echo Repository might not exist. Creating it...
        gh repo create M95-rust --public --source=. --remote=origin --push
    ) else (
        echo Repository exists. Pushing...
        git push -u origin master
    )
    
    if errorlevel 1 (
        echo.
        echo Still failed. Manual steps:
        echo.
        echo 1. Delete and re-add remote:
        echo    git remote remove origin
        echo    git remote add origin https://github.com/marvelousufelix/M95-rust.git
        echo.
        echo 2. Try SSH instead:
        echo    git remote set-url origin git@github.com:marvelousufelix/M95-rust.git
        echo    git push -u origin master
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
echo Your repository is now at:
echo https://github.com/marvelousufelix/M95-rust
echo.
pause
