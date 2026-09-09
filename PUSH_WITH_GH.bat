@echo off
REM Use GitHub CLI to push (avoids HTTP timeout issues)

echo.
echo ========================================
echo  Push Using GitHub CLI
echo ========================================
echo.

REM First, let's check if the repo exists
echo Checking repository status...
gh repo view marvelousufelix/M95-rust 2>nul

if errorlevel 1 (
    echo.
    echo Repository doesn't exist. Creating it...
    gh repo create M95-rust ^
        --public ^
        --source=. ^
        --remote=origin ^
        --description "M95-rust - Stellar-powered payment backend for African POS systems" ^
        --push
    
    if errorlevel 1 (
        echo Failed to create and push.
        pause
        exit /b 1
    )
    
    echo.
    echo ========================================
    echo  SUCCESS!
    echo ========================================
) else (
    echo Repository exists!
    echo.
    echo Syncing with gh...
    
    REM Use gh to handle the push
    gh repo sync marvelousufelix/M95-rust --source=. --force
    
    if errorlevel 1 (
        echo.
        echo Sync failed. Trying direct push with gh auth...
        
        REM Get gh token and push with it
        for /f "tokens=*" %%a in ('gh auth token') do set GH_TOKEN=%%a
        
        echo Pushing with authenticated token...
        git push https://oauth2:%GH_TOKEN%@github.com/marvelousufelix/M95-rust.git main
        
        if errorlevel 1 (
            echo.
            echo Still failed. Last resort: force push to master
            git push https://oauth2:%GH_TOKEN%@github.com/marvelousufelix/M95-rust.git HEAD:master --force
        )
    )
)

echo.
echo Verification:
git ls-remote origin
echo.
echo Visit: https://github.com/marvelousufelix/M95-rust
start https://github.com/marvelousufelix/M95-rust
echo.
pause
