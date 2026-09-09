# Push M95-rust to GitHub

## Repository Details

- **GitHub Username**: marvelousufelix
- **Repository Name**: M95-rust
- **Repository URL**: https://github.com/marvelousufelix/M95-rust.git

---

## Prerequisites

Before pushing, make sure:

1. ✅ You have created the repository on GitHub:
   - Go to https://github.com/new
   - Repository name: `M95-rust`
   - Choose Public or Private
   - **DO NOT** initialize with README, .gitignore, or license (we have these already)
   - Click "Create repository"

2. ✅ You have Git configured locally:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

3. ✅ You're authenticated with GitHub (HTTPS or SSH)

---

## Step-by-Step Guide

### Step 1: Navigate to M95-rust

```bash
cd M95-rust
```

### Step 2: Check Current Git Status

```bash
git status
git log --oneline -5
```

This shows your current branch and recent commits.

### Step 3: Update Remote URL

```bash
# Set the remote to your GitHub repository
git remote set-url origin https://github.com/marvelousufelix/M95-rust.git

# Verify it's set correctly
git remote -v
```

**Expected output:**
```
origin  https://github.com/marvelousufelix/M95-rust.git (fetch)
origin  https://github.com/marvelousufelix/M95-rust.git (push)
```

### Step 4: Check Current Branch

```bash
git branch
```

If you're on `master` branch, great! If on `main`, that's fine too.

### Step 5: Stage and Commit Any Changes

```bash
# Check if there are any uncommitted changes
git status

# If there are changes, stage them
git add -A

# Commit the changes
git commit -m "Separate Rust backend into M95-rust repository"
```

### Step 6: Push to GitHub

**If you're on `master` branch:**
```bash
git push -u origin master
```

**If you're on `main` branch:**
```bash
git push -u origin main
```

**If you get an error about branch names:**
```bash
# Rename local branch to main (if needed)
git branch -M main
git push -u origin main
```

---

## Authentication Methods

### Option A: HTTPS (Recommended for beginners)

You'll be prompted for:
- **Username**: marvelousufelix
- **Password**: Use a **Personal Access Token** (not your GitHub password)

**To create a Personal Access Token:**
1. Go to https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Name it: "M95-rust push access"
4. Select scopes: `repo` (full control of private repositories)
5. Click "Generate token"
6. Copy the token (you won't see it again!)
7. Use this token as your password when pushing

### Option B: SSH

If you prefer SSH:

```bash
# Use SSH URL instead
git remote set-url origin git@github.com:marvelousufelix/M95-rust.git

# Then push
git push -u origin master
```

**Setting up SSH keys:**
1. Generate SSH key: `ssh-keygen -t ed25519 -C "your.email@example.com"`
2. Copy public key: `cat ~/.ssh/id_ed25519.pub` (or use `type` on Windows)
3. Add to GitHub: https://github.com/settings/ssh/new
4. Test: `ssh -T git@github.com`

---

## Troubleshooting

### Error: "remote origin already exists"

```bash
# Remove existing remote
git remote remove origin

# Add new remote
git remote add origin https://github.com/marvelousufelix/M95-rust.git

# Push
git push -u origin master
```

### Error: "src refspec master does not match any"

Your branch might be named `main` instead:
```bash
git branch -M main
git push -u origin main
```

### Error: "failed to push some refs"

The remote has changes you don't have locally (shouldn't happen with new repo):
```bash
# Force push (only safe for new/empty repo)
git push -u origin master --force
```

### Error: "Authentication failed"

- For HTTPS: Use Personal Access Token, not password
- For SSH: Make sure SSH key is added to GitHub

### Large File Warning

If you get warnings about large files, it's likely the Git history from original repo:
```bash
# Check repository size
git count-objects -vH

# If needed, clean up Git history (advanced)
git gc --aggressive --prune=now
```

---

## Verification

After successful push:

1. **Visit your repository:**
   https://github.com/marvelousufelix/M95-rust

2. **You should see:**
   - README.md displaying
   - All source files (src/, tests/, migrations/)
   - Documentation files
   - Commit history

3. **Check branches:**
   ```bash
   git branch -r
   ```
   Should show: `origin/master` (or `origin/main`)

---

## Quick Command Summary

```bash
# Full sequence (copy-paste ready)
cd M95-rust
git remote set-url origin https://github.com/marvelousufelix/M95-rust.git
git remote -v
git status
git add -A
git commit -m "Separate Rust backend into M95-rust repository"
git push -u origin master
```

---

## After First Push

For future updates:

```bash
# Make changes to files
# ...

# Stage changes
git add .

# Commit changes
git commit -m "Your commit message"

# Push changes
git push
```

(The `-u origin master` is only needed for the first push)

---

## Repository Description (Optional)

Add this description to your GitHub repository:

```
M95-rust - Stellar-powered payment backend for African POS systems. Rust API server with PostgreSQL, Stellar blockchain integration, and Paystack payment processing.
```

**Topics to add:**
- rust
- stellar
- blockchain
- payments
- api
- backend
- postgresql
- africa
- fintech

---

## Success Checklist

After pushing, verify:

- [ ] Repository exists at https://github.com/marvelousufelix/M95-rust
- [ ] README.md is visible and formatted
- [ ] All directories visible (src/, tests/, migrations/)
- [ ] Can clone the repo: `git clone https://github.com/marvelousufelix/M95-rust.git`
- [ ] Commit history is intact
- [ ] Repository description is set
- [ ] Topics/tags are added

---

## Next Steps

1. **Update Repository Settings** (optional):
   - Add description
   - Add topics/tags
   - Enable Issues
   - Add license file
   - Configure branch protection

2. **Share Repository**:
   - Add collaborators if needed
   - Update documentation with GitHub URL
   - Link from other projects

3. **Set up CI/CD** (optional):
   - GitHub Actions for tests
   - Automated builds
   - Deployment workflows

---

**Ready to push!** 🚀

Start with Step 1 and follow the guide above. If you encounter any issues, check the Troubleshooting section.
