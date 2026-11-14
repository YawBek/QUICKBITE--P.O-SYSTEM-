# Git Bash + VS Code, three-person workflow (Windows)

## Prerequisites
Install Git for Windows, VS Code, Node.js LTS, MySQL Community Server. Verify in Git Bash:
```bash
git --version
node --version
npm --version
```

## Clone the EXISTING repository
```bash
git config --global user.name "Your real name"
git config --global user.email "your-github-email@example.com"
git clone https://github.com/YawBek/QUICKBITE--P.O-SYSTEM-.git
cd QUICKBITE--P.O-SYSTEM-
code .
```
Sign in to GitHub using VS Code's Accounts menu; Git Credential Manager/browser handles authentication, not pasted passwords.

## Each member's feature branch
```bash
git checkout main
git pull origin main
git checkout -b feature/customer-menu
# edit files in VS Code, then:
git status
git add .
git commit -m "feat: add customer menu UI"
git push -u origin feature/customer-menu
```
On GitHub open **Compare & pull request**, request a teammate review, merge after tests. Then:
```bash
git checkout main
git pull origin main
git branch -d feature/customer-menu
```
Member B uses `feature/api-sessions`, member C `feature/staff-dashboard`. Create new branch per issue.

## Avoid conflicts
Do not edit main simultaneously. Agree API request/response shape first. Do not commit node_modules, .env, passwords or API tokens. Use .env.example placeholders only.

## Git Bash troubleshooting
- `code: command not found`: open repository using VS Code File → Open Folder, then use integrated terminal.
- Authentication fails: sign in again with VS Code/Git Credential Manager and confirm collaborator access.
- `non-fast-forward`: git fetch origin; git rebase origin/main on your feature branch; resolve conflicts, retest, then push.
- Never `git push --force` to main.
