@echo off
REM Final push solution - Forces push to both main and master branches

echo.
echo ========================================
echo  FINAL PUSH TO GITHUB
echo ========================================
echo.

REM Configure larger buffer
git config --global http.postBuffer 524288000
git config --global http.timeout 600

REM Stage new files
git add -A
git commit -m "Add push scripts"

REM Try push to master branch (where origin is currently pointing)
echo.
echo [1/2] Pushing to master branch...
git push -u origin HEAD:master --force

if errorlevel 1 (
    echo Master push failed.
) else (
    echo Master push succeeded!
)

echo.
echo [2/2] Pushing to main branch...
git push -u origin main --force

if errorlevel 1 (
    echo Main push failed.
) else (
    echo Main push succeeded!
)

echo.
echo ========================================
echo  Verifying...
echo ========================================
echo.

git ls-remote origin

echo.
echo Visit your repository:
echo https://github.com/marvelousufelix/M95-rust
echo.
start https://github.com/marvelousufelix/M95-rust

pause
