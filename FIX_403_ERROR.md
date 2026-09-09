# Fix 403 Permission Denied Error

## Problem

You got this error:
```
remote: Permission to marvelousufelix/M95-rust.git denied to owolabornn.
fatal: unable to access 'https://github.com/marvelousufelix/M95-rust.git/': The requested URL returned error: 403
```

**Cause:** Git is using cached credentials from the old user `owolabornn` instead of `marvelousufelix`.

---

## ✅ Solution 1: Use GitHub CLI (Recommended - Easiest)

You already authenticated with `gh auth login`, so this is the simplest solution:

```bash
cd M95-rust
push-with-gh-cli.bat
```

This script will:
1. Use your GitHub CLI authentication
2. Create the repository if it doesn't exist
3. Push all code automatically

---

## ✅ Solution 2: Fix Credentials Manually

### Step 1: Configure Git to use GitHub CLI

```bash
git config --global credential.helper ""
git config --global credential.helper "!gh auth git-credential"
```

### Step 2: Push Again

```bash
git push -u origin master
```

---

## ✅ Solution 3: Clear Windows Credentials

### Step 1: Open Credential Manager

**Option A - Via Command:**
```bash
cmdkey /delete:git:https://github.com
```

**Option B - Via GUI:**
1. Press `Windows + R`
2. Type: `control /name Microsoft.CredentialManager`
3. Click "Windows Credentials"
4. Find and remove any GitHub credentials
5. Look for:
   - `git:https://github.com`
   - Any entries with `github.com`

### Step 2: Push Again

```bash
git push -u origin master
```

When prompted:
- Username: `marvelousufelix`
- Password: `[Your Personal Access Token]`

---

## ✅ Solution 4: Use SSH Instead of HTTPS

### Step 1: Check if you have SSH keys

```bash
ls ~/.ssh
```

If you see `id_ed25519` or `id_rsa`, you have keys. Otherwise, create them:

```bash
ssh-keygen -t ed25519 -C "marvelousufelix@gmail.com"
```

### Step 2: Add SSH key to GitHub

```bash
# Copy your public key
cat ~/.ssh/id_ed25519.pub
# or on Windows:
type %USERPROFILE%\.ssh\id_ed25519.pub
```

1. Go to: https://github.com/settings/ssh/new
2. Paste the key
3. Click "Add SSH key"

### Step 3: Change remote to SSH

```bash
git remote set-url origin git@github.com:marvelousufelix/M95-rust.git
git push -u origin master
```

---

## 🚀 Quick Fix Scripts

I've created two scripts for you:

### Script 1: `push-with-gh-cli.bat` (Recommended)
Uses GitHub CLI - no credential issues
```bash
push-with-gh-cli.bat
```

### Script 2: `fix-credentials-and-push.bat`
Clears old credentials and pushes
```bash
fix-credentials-and-push.bat
```

---

## Manual Commands (If Scripts Don't Work)

```bash
# 1. Configure Git to use GitHub CLI
git config --global credential.helper "!gh auth git-credential"

# 2. Verify you're authenticated
gh auth status

# 3. Stage and commit
git add -A
git commit -m "Separate Rust backend into M95-rust repository"

# 4. Update remote
git remote set-url origin https://github.com/marvelousufelix/M95-rust.git

# 5. Push
git push -u origin master
```

---

## If Repository Doesn't Exist

Create it with GitHub CLI:

```bash
gh repo create M95-rust --public --source=. --remote=origin --push
```

Or create manually:
1. Go to: https://github.com/new
2. Name: `M95-rust`
3. Public/Private
4. Do NOT initialize
5. Create

Then push:
```bash
git remote set-url origin https://github.com/marvelousufelix/M95-rust.git
git push -u origin master
```

---

## Verification

After successful push:

```bash
# Check remote is correct
git remote -v

# Visit repository
start https://github.com/marvelousufelix/M95-rust
```

---

## Still Having Issues?

Try these diagnostic commands:

```bash
# Check current git user
git config user.name
git config user.email

# Check credential helper
git config credential.helper

# Check GitHub CLI auth
gh auth status

# Check remote URL
git remote -v

# Check branch name
git branch
```

---

## Summary of What We Did

✅ You ran `gh auth login` and authenticated as `marvelousufelix`
✅ You configured Git with your name and email
✅ Problem: Git still using old credentials from `owolabornn`
✅ Solution: Use GitHub CLI helper or clear credentials

**Recommended next step:**
```bash
push-with-gh-cli.bat
```

This uses your GitHub CLI authentication and avoids credential issues entirely!
