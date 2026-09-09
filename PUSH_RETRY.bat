@echo off
REM Retry push with larger buffer to handle timeout

echo.
echo ========================================
echo  Retry Push with Larger Buffer
echo ========================================
echo.

REM Increase Git buffer size for large repos
echo Increasing Git HTTP buffer size...
git config --global http.postBuffer 524288000
git config --global http.timeout 300
echo Done!
echo.

REM Try pushing to main branch (you're on main now)
echo Pushing to main branch...
git push -u origin main

if errorlevel 1 (
    echo.
    echo Main push failed. Trying master branch...
    git push -u origin HEAD:master --force
    
    if errorlevel 1 (
        echo.
        echo ========================================
        echo  Alternative: Use GitHub CLI
        echo ========================================
        echo.
        echo Using gh CLI to push...
        gh repo sync
        
        if errorlevel 1 (
            echo.
            echo Trying direct gh push...
            git push https://marvelousufelix:%GH_TOKEN%@github.com/marvelousufelix/M95-rust.git main
        )
    )
)

echo.
echo ========================================
echo  Checking Status
echo ========================================
echo.
git status
echo.
echo Visit: https://github.com/marvelousufelix/M95-rust
echo.
pause
