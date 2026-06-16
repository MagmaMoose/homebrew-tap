# Homebrew Tap

[![Homebrew](https://img.shields.io/badge/Homebrew-tap-orange)](https://github.com/MagmaMoose/homebrew-tap)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI](https://github.com/MagmaMoose/homebrew-tap/workflows/CI/badge.svg)](https://github.com/MagmaMoose/homebrew-tap/actions)

<!-- Quality & Security Overview -->
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Known Vulnerabilities](https://snyk.io/test/github/CalebSargeant/infra/badge.svg)](https://snyk.io/test/github/CalebSargeant/infra)

<!-- Code Quality & Maintainability -->
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=reliability_rating)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=sqale_index)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)

<!-- Code Metrics -->
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=coverage)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=bugs)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=vulnerabilities)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Code Smells](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=code_smells)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)

<!-- Project Stats -->
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=ncloc)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=MagmaMoose_homebrew-tap&metric=duplicated_lines_density)](https://sonarcloud.io/summary/new_code?id=MagmaMoose_homebrew-tap)

A Centralised Homebrew tap for various tools, with automated updates and best practices.

## Installation

### Tap This Repository

```bash
brew tap MagmaMoose/tap
```

### Install a Formula

Once tapped, you can install any tool from this tap:

```bash
brew install MagmaMoose/tap/<formula-name>
```

Or after tapping, simply:

```bash
brew install <formula-name>
```

## Available Tools

| Tool | Description | Version | Install Command |
|------|-------------|---------|-----------------|
| transcribe | Video/audio transcription with auto-watch, OpenAI summarization, and Slack notifications | 1.0.8 | `brew install transcribe` |
| maniforge | Terraform-like tool for managing Kubernetes applications | 1.2.0 | `brew install maniforge` |
| chargate | Net-new security and lint gate with a global git-hooks installer | 2.0.0 | `brew install chargate` |

## Usage Examples

### Transcribe

```bash
# Configure with API keys
transcribe config

# Transcribe a video file
transcribe video.mp4

# Watch a directory for new videos
transcribe watch ~/Movies

# Setup as background daemon
transcribe setup-daemon
```

### Maniforge

```bash
# Deploy Kubernetes manifests
maniforge apply -f manifests/

# Check deployment status
maniforge status
```

## Development

### Adding a New Formula

1. Create a new Ruby file in the `Formula/` directory
2. Follow the template structure from `Formula/example-tool.rb`
3. Test your formula locally:

```bash
brew install --build-from-source ./Formula/your-tool.rb
brew test your-tool
brew audit --strict your-tool
```

### Testing Formulas

```bash
# Install from local tap
brew install --build-from-source ./Formula/your-tool.rb

# Run formula tests
brew test your-tool

# Audit formula for issues
brew audit --strict --online your-tool
```

### Updating Formulas

Formulas are automatically updated via GitHub Actions when new releases are detected. Manual updates can be made by:

1. Updating the version and URL in the formula
2. Running `brew fetch --force <formula>` to get the new SHA256
3. Updating the `sha256` field in the formula
4. Testing the changes locally

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Contribution Guide

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/new-tool`)
3. Add or update formulas in the `Formula/` directory
4. Test your changes locally
5. Commit your changes (`git commit -am 'Add new tool'`)
6. Push to your branch (`git push origin feature/new-tool`)
7. Create a Pull Request

## Best Practices

- Follow [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) guidelines
- Use `brew audit --strict` to ensure formula quality
- Include a comprehensive `test do` block
- Keep formulas simple and maintainable
- Document any special installation requirements

## Automated Updates

This tap uses GitHub Actions to:

- ✅ Lint formulas on every pull request
- ✅ Verify formula installation
- ✅ Auto-update formulas when new releases are available
- ✅ Validate SHA256 checksums

## Resources

- [Homebrew Documentation](https://docs.brew.sh/)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Formula API](https://rubydoc.brew.sh/Formula)
- [Acceptable Formulae](https://docs.brew.sh/Acceptable-Formulae)

## License

This tap is available under the [MIT License](LICENSE).

## Support

If you encounter any issues or have questions:

- Open an [issue](https://github.com/MagmaMoose/homebrew-tap/issues)
- Check existing [discussions](https://github.com/MagmaMoose/homebrew-tap/discussions)

## Maintainers

- [@CalebSargeant](https://github.com/CalebSargeant)

---

**Note**: This is a third-party tap. For official Homebrew formulas, see [Homebrew/homebrew-core](https://github.com/Homebrew/homebrew-core).
