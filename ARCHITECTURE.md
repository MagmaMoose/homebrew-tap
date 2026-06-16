# Repository Architecture

This document describes the architecture and structure of the MagmaMoose/homebrew-tap repository.

## Overview

This is a centralized Homebrew tap repository following industry best practices for
maintaining and distributing CLI tools via Homebrew. The repository is designed to be
automated, well-documented, and easy to maintain.

## Directory Structure

```text
homebrew-tap/
├── .github/                    # GitHub-specific configurations
│   ├── workflows/              # GitHub Actions workflows
│   │   ├── audit.yml          # Formula auditing
│   │   ├── auto-update.yml    # Automated formula updates
│   │   ├── ci.yml             # Comprehensive CI pipeline
│   │   ├── test.yml           # Formula testing
│   │   └── update-sha256.yml  # Checksum updates
│   └── pull_request_template.md  # PR template
├── Formula/                    # Homebrew formulas
│   └── example-tool.rb        # Example formula template
├── .editorconfig              # Editor configuration for consistent formatting
├── .gitignore                 # Git ignore patterns
├── .markdownlint.json         # Markdown linting configuration
├── CODEOWNERS                 # Code ownership definitions
├── CONTRIBUTING.md            # Contribution guidelines
├── LICENSE                    # MIT License
├── README.md                  # Main documentation
└── tap-metadata.json          # Tap metadata and configuration
```

## Key Components

### 1. Formula Directory

The `Formula/` directory contains all Homebrew formula definitions. Each formula is a Ruby class that describes:

- Source location and version
- Dependencies
- Installation instructions
- Tests

**Naming Convention**: `tool-name.rb` (lowercase with hyphens)

### 2. GitHub Actions Workflows

#### audit.yml
- **Purpose**: Validates formula syntax and style
- **Triggers**: Pull requests, pushes to main, manual dispatch
- **Features**:
  - Runs `brew audit --strict --online` on all formulas
  - Checks formula style compliance
  - Ensures formulas meet Homebrew standards

#### test.yml
- **Purpose**: Tests formula installation and functionality
- **Triggers**: Pull requests, pushes to main, manual dispatch
- **Features**:
  - Tests on multiple macOS versions (macos-13, macos-14)
  - Installs formulas from source
  - Runs formula test blocks
  - Skips example/template formulas

#### ci.yml
- **Purpose**: Comprehensive CI pipeline
- **Triggers**: All pull requests and pushes
- **Features**:
  - Combined audit and style checks
  - Markdown linting
  - Multiple job stages

#### auto-update.yml
- **Purpose**: Automatically updates formulas to latest versions
- **Triggers**: Daily schedule (02:00 UTC), manual dispatch
- **Features**:
  - Checks for outdated formulas using `brew livecheck`
  - Attempts to auto-update using `brew bump-formula-pr`
  - Creates pull requests for updates
  - Runs daily to keep formulas current

#### update-sha256.yml
- **Purpose**: Updates SHA256 checksums for formulas
- **Triggers**: Manual dispatch only
- **Features**:
  - Can update specific formula or all formulas
  - Fetches correct checksums using `brew fetch`
  - Creates pull requests with updated checksums
  - Useful for security updates

### 3. Configuration Files

#### tap-metadata.json
Central configuration file containing:
- Tap information and maintainers
- Formula registry
- Auto-update settings
- CI/CD configuration

#### .editorconfig
Ensures consistent code formatting across different editors:
- 2-space indentation for Ruby, YAML, JSON
- Unix-style line endings
- UTF-8 encoding
- Trailing whitespace removal

#### .markdownlint.json
Configuration for Markdown linting:
- Line length limits (120 chars)
- Allows HTML in Markdown
- Flexible with certain rules for documentation

### 4. Documentation

#### README.md
Main entry point for users and contributors:
- Installation instructions
- Available tools table
- Usage examples
- Development guidelines
- Resource links

#### CONTRIBUTING.md
Comprehensive contribution guide:
- Code of conduct reference
- How to add formulas
- Testing requirements
- PR process
- Style guidelines

#### CODEOWNERS
Defines code ownership:
- Default owner for all files
- Specific ownership for Formula/ directory
- GitHub Actions ownership
- Documentation ownership

## Workflow Automation

### Daily Operations

1. **Auto-Update Check** (Daily at 02:00 UTC)
   - Scans all formulas for updates
   - Creates PR if updates found
   - Includes updated versions and checksums

2. **CI on Every PR**
   - Audits formula quality
   - Tests installation
   - Validates style
   - Checks documentation

### Manual Operations

1. **SHA256 Update**
   - Triggered manually when needed
   - Updates checksums for security
   - Supports single or bulk updates

2. **On-Demand Testing**
   - Can be triggered manually
   - Useful for debugging
   - Tests specific scenarios

## Formula Development Lifecycle

### 1. Creation
```bash
# Create new formula from template
cp Formula/example-tool.rb Formula/my-tool.rb
# Edit with tool details
```

### 2. Testing
```bash
# Test locally
brew install --build-from-source ./Formula/my-tool.rb
brew test my-tool
brew audit --strict my-tool
```

### 3. Submission
```bash
# Create PR
git checkout -b feature/add-my-tool
git add Formula/my-tool.rb
git commit -m "Add my-tool formula"
git push origin feature/add-my-tool
```

### 4. Review & Merge
- CI runs automatically
- Maintainer reviews
- PR merged to main

### 5. Maintenance
- Auto-updates monitor for new versions
- SHA256 updates as needed
- Tests run on each change

## Best Practices

### Formula Design
1. Keep formulas simple and focused
2. Include comprehensive tests
3. Document all dependencies
4. Use stable release URLs
5. Follow Homebrew style guide

### Version Management
1. Use semantic versioning
2. Point to tagged releases
3. Verify checksums
4. Test before merging

### Testing Strategy
1. Test on clean system
2. Verify all dependencies
3. Check test block coverage
4. Validate on multiple macOS versions

### Documentation
1. Keep README updated
2. Document special requirements
3. Include usage examples
4. Maintain tool table

## Security Considerations

### Checksum Verification
- All downloads verified with SHA256
- Automated updates include checksums
- Manual verification required for PRs

### Code Review
- All PRs require review
- CODEOWNERS enforces ownership
- Automated tests catch issues

### Dependency Management
- Dependencies explicitly declared
- Version pinning when needed
- Regular updates via automation

## Monitoring and Maintenance

### Automated Monitoring
- Daily update checks
- CI on every change
- Style enforcement

### Manual Maintenance
- Review auto-update PRs
- Monitor GitHub Actions
- Address failed workflows

### Community Engagement
- Issue tracking
- PR reviews
- Discussion forum

## Future Enhancements

Potential improvements:
- [ ] Formula deprecation workflow
- [ ] Release notes automation
- [ ] Usage analytics
- [ ] Multi-platform support (Linux)
- [ ] Bottle (binary) generation
- [ ] Performance testing
- [ ] Security scanning integration

## Resources

- [Homebrew Documentation](https://docs.brew.sh/)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Ruby Style Guide](https://rubystyle.guide/)

## Support

For questions or issues:
- Open an issue
- Check discussions
- Review existing documentation

---

Last updated: 2025-01-20
