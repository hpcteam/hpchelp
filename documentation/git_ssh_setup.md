---
title: 📜 Git_ssh_setup
parent: Documentation
---

# 📜 Git_ssh_setup

Documentation for Git_ssh_steup.md.

```markdown
# Git SSH Setup and Repository Push Guide

This document explains the **complete process** to set up SSH connectivity between your laptop and GitHub, clone a repository, set the correct remote, and push changes safely.

---

## 1. Check SSH Setup

Test if SSH is configured:

```bash
ssh -T git@github.com
````

Expected output:

```
Hi hpcteam! You've successfully authenticated, but GitHub does not provide shell access.
```

✅ If you see this, SSH is working correctly.

---

## 2. Clone the Repository

Navigate to the directory where you want the repo:

```bash
cd ~/Web
```

Clone the repository:

```bash
git clone git@github.com:hpcteam/hpchelp.git
```

Enter the repository:

```bash
cd hpchelp
```

Check the directory structure:

```bash
ls
```

Expected output:

```
assets  _config.yml  documentation  documentation.md  index.md  README.md
```

---

## 3. Check Remote Repository

Verify the current remote URL:

```bash
git remote -v
```

You should see:

```
origin  git@github.com:hpcteam/hpchelp.git (fetch)
origin  git@github.com:hpcteam/hpchelp.git (push)
```

> ⚠️ If your username is different, make sure the remote URL matches your **actual GitHub username**.

---

## 4. Set Correct Remote (If Needed)

If the remote is incorrect (for example pointing to `loki/hpchelp.git`), fix it:

```bash
git remote set-url origin git@github.com:hpcteam/hpchelp.git
```

Verify:

```bash
git remote -v
```

Expected:

```
origin  git@github.com:hpcteam/hpchelp.git (fetch)
origin  git@github.com:hpcteam/hpchelp.git (push)
```

---

## 5. Check Git Status

Before committing, check the current status:

```bash
git status
```

Output should indicate if there are uncommitted changes:

```
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

---

## 6. Stage and Commit Changes

Add files to staging:

```bash
git add .
```

Commit the changes:

```bash
git commit -m "Your commit message"
```

---

## 7. Push Changes

Push your changes to GitHub:

```bash
git push origin main
```

✅ This will succeed if:

* The repository exists under your account (`hpcteam`)
* SSH authentication works
* Remote URL is correct

---

## 8. Common Issues

| Symptom                        | Cause                              | Solution                                                |
| ------------------------------ | ---------------------------------- | ------------------------------------------------------- |
| `ERROR: Repository not found`  | Remote points to non-existent repo | Set correct remote using `git remote set-url`           |
| `fatal: not a git repository`  | You are not inside a Git repo      | Navigate to the cloned repo directory                   |
| Git asks for username/password | Remote uses HTTPS                  | Use SSH remote URL (`git@github.com:username/repo.git`) |

---

## 9. Optional: Test SSH Connection

```bash
ssh -T git@github.com
```

Expected output:

```
Hi hpcteam! You've successfully authenticated.
```

---

## ✅ Notes

* Always make sure you are **inside the repository folder** before running Git commands like `git status` or `git push`.
* Using SSH avoids repeated username/password prompts.
* If collaborating, ensure you have proper **write access** to the repository.

