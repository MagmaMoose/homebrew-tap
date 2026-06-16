# Quick Reference Guide

Quick reference for common tasks in the homebrew-tap repository.

## For Users

### Installing the Tap

```bash
# Tap this repository
brew tap MagmaMoose/tap

# Install a tool
brew install tool-name
```

### Updating Tools

```bash
# Update Homebrew and all taps
brew update

# Upgrade specific tool
brew upgrade tool-name

# Upgrade all tools
brew upgrade
```

### Uninstalling

```bash
# Uninstall a tool
brew uninstall tool-name

# Untap the repository
brew untap MagmaMoose/tap
```

## For Contributors

### Adding a New Formula

```bash
# 1. Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/homebrew-tap.git
cd homebrew-tap

# 2. Create a new branch
git checkout -b add-my-tool

# 3. Create formula from template
cp Formula/example-tool.rb Formula/my-tool.rb

# 4. Edit the formula
vim Formula/my-tool.rb

# 5. Get SHA256 checksum
curl -L -o v1.0.0.tar.gz https://github.com/owner/repo/archive/refs/tags/v1.0.0.tar.gz
shasum -a 256 v1.0.0.tar.gz

# 6. Test the formula
brew install --build-from-source ./Formula/my-tool.rb
brew test my-tool
brew audit --strict my-tool

# 7. Commit and push
git add Formula/my-tool.rb
git commit -m "Add my-tool formula"
git push origin add-my-tool

# 8. Create Pull Request on GitHub
```

### Updating a Formula

```bash
# 1. Create update branch
git checkout -b update-tool-version

# 2. Edit formula with new version
vim Formula/tool-name.rb

# 3. Get new SHA256
curl -L -o v2.0.0.tar.gz https://github.com/owner/repo/archive/refs/tags/v2.0.0.tar.gz
shasum -a 256 v2.0.0.tar.gz

# 4. Update formula
# - Change version in URL
# - Update sha256 field

# 5. Test
brew uninstall tool-name
brew install --build-from-source ./Formula/tool-name.rb
brew test tool-name

# 6. Commit and push
git add Formula/tool-name.rb
git commit -m "Update tool-name to v2.0.0"
git push origin update-tool-version
```

### Testing Locally

```bash
# Install from source
brew install --build-from-source ./Formula/tool-name.rb

# Run tests
brew test tool-name

# Audit for issues
brew audit --strict tool-name

# Check style
brew style Formula/tool-name.rb

# Complete audit with online checks
brew audit --strict --online tool-name

# Clean up
brew uninstall tool-name
```

## For Maintainers

### Manual Formula Update

```bash
# Check for updates
brew livecheck tool-name

# Bump version (interactive)
brew bump-formula-pr tool-name

# Or update manually
vim Formula/tool-name.rb
```

### Triggering Workflows

```bash
# Trigger auto-update workflow
gh workflow run auto-update.yml

# Trigger SHA256 update for specific formula
gh workflow run update-sha256.yml -f formula=tool-name

# Trigger SHA256 update for all formulas
gh workflow run update-sha256.yml
```

### Managing Pull Requests

```bash
# Review PR locally
gh pr checkout PR_NUMBER

# Test the changes
brew install --build-from-source ./Formula/new-tool.rb
brew test new-tool
brew audit --strict new-tool

# Approve and merge
gh pr review --approve
gh pr merge
```

### Debugging Failed Workflows

```bash
# View workflow runs
gh run list

# View specific run
gh run view RUN_ID

# Download logs
gh run download RUN_ID

# Re-run failed jobs
gh run rerun RUN_ID --failed
```

## Common Formula Patterns

### Simple Binary Installation

```ruby
def install
  bin.install "tool-name"
end

test do
  assert_match version.to_s, shell_output("#{bin}/tool-name --version")
end
```

### Go Application

```ruby
def install
  system "go", "build", *std_go_args(ldflags: "-s -w")
end

test do
  assert_match "version #{version}", shell_output("#{bin}/tool-name version")
end
```

### Python Application

```ruby
depends_on "python@3.11"

def install
  virtualenv_install_with_resources
end

test do
  system bin/"tool-name", "--help"
end
```

### Node.js Application

```ruby
depends_on "node"

def install
  system "npm", "install", *std_npm_args
  bin.install_symlink Dir["#{libexec}/bin/*"]
end

test do
  assert_match version.to_s, shell_output("#{bin}/tool-name --version")
end
```

### Compiled Application (Make)

```ruby
def install
  system "make", "install", "PREFIX=#{prefix}"
end

test do
  system "#{bin}/tool-name", "--version"
end
```

## Useful Homebrew Commands

```bash
# Get formula info
brew info tool-name

# See formula dependencies
brew deps tool-name

# Check what depends on a formula
brew uses --installed tool-name

# Fetch source without installing
brew fetch tool-name

# Install specific version
brew install tool-name@1.0

# Pin a formula version
brew pin tool-name

# Unpin
brew unpin tool-name

# List tapped repositories
brew tap

# Get tap info
brew tap-info MagmaMoose/tap
```

## Troubleshooting

### Formula Won't Install

```bash
# Clear cache
rm -rf "$(brew --cache)/tool-name"

# Try verbose install
brew install --build-from-source --verbose ./Formula/tool-name.rb

# Check logs
cat ~/Library/Logs/Homebrew/tool-name
```

### Audit Failures

```bash
# Fix style issues
brew style --fix Formula/tool-name.rb

# Check specific issue
brew audit --strict tool-name 2>&1 | grep ERROR

# Test online connectivity
brew audit --strict --online tool-name
```

### Test Failures

```bash
# Run test with verbose output
brew test --verbose tool-name

# Check test block syntax
ruby -c Formula/tool-name.rb

# Manual test
brew install tool-name
tool-name --version
```

## GitHub CLI Commands

```bash
# Create issue
gh issue create --title "Bug: tool-name fails" --body "Description"

# List PRs
gh pr list

# Create PR
gh pr create --title "Add new-tool" --body "Description"

# View PR
gh pr view PR_NUMBER

# Check PR status
gh pr status

# List workflows
gh workflow list

# View workflow
gh workflow view ci.yml
```

## Git Helpers

```bash
# Update from main
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/my-feature

# Check status
git status

# View changes
git diff

# Amend last commit
git commit --amend

# Interactive rebase (last 3 commits)
git rebase -i HEAD~3

# Force push (use carefully)
git push --force-with-lease
```

## Links

- [Homebrew Documentation](https://docs.brew.sh/)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Git Documentation](https://git-scm.com/doc)

---

**Tip**: Save this file locally for quick reference!
