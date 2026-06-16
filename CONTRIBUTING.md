# Contributing to Homebrew Tap

Thank you for your interest in contributing to this Homebrew tap! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Formula Guidelines](#formula-guidelines)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)
- [Style Guide](#style-guide)

## Code of Conduct

This project follows the [Homebrew Code of Conduct](https://github.com/Homebrew/.github/blob/HEAD/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How to Contribute

### Reporting Issues

- Check if the issue already exists in the [issue tracker](https://github.com/MagmaMoose/homebrew-tap/issues)
- Use a clear and descriptive title
- Include as much relevant information as possible
- Include steps to reproduce the issue
- Include your system information (macOS version, Homebrew version)

### Suggesting Enhancements

- Use the issue tracker to suggest enhancements
- Provide a clear description of the enhancement
- Explain why this enhancement would be useful
- Include examples of how it would be used

### Adding a New Formula

1. **Fork the repository** and create a new branch from `main`
2. **Create your formula** in the `Formula/` directory
3. **Follow the naming convention**: `tool-name.rb` (lowercase with hyphens)
4. **Use the template** from `Formula/example-tool.rb` as a starting point
5. **Test thoroughly** before submitting

## Formula Guidelines

### Formula Structure

All formulas must follow the standard Homebrew formula structure:

```ruby
class ToolName < Formula
  desc "Brief description of the tool"
  homepage "https://github.com/owner/repo"
  url "https://github.com/owner/repo/archive/refs/tags/vX.Y.Z.tar.gz"
  sha256 "actual_sha256_hash"
  license "MIT" # or appropriate license

  def install
    # Installation instructions
  end

  test do
    # Test block
  end
end
```

### Required Elements

Every formula must include:

- ✅ **desc**: A brief, clear description
- ✅ **homepage**: Project homepage or repository URL
- ✅ **url**: Download URL for the source or binary
- ✅ **sha256**: SHA256 checksum of the download
- ✅ **license**: Software license (e.g., "MIT", "Apache-2.0", "GPL-3.0")
- ✅ **install block**: Installation instructions
- ✅ **test block**: At least one basic test

### Best Practices

1. **Keep it simple**: Formulas should be as simple as possible
2. **Use stable URLs**: Point to stable release URLs, not moving targets
3. **Document dependencies**: Clearly specify all dependencies
4. **Test thoroughly**: Include comprehensive tests
5. **Follow Homebrew style**: Use `brew audit --strict` to check style
6. **Version pinning**: Use specific version numbers, not `latest` or `master`

### Dependencies

Specify dependencies using:

```ruby
depends_on "dependency-name"           # Runtime dependency
depends_on "build-tool" => :build      # Build-time only
depends_on "test-tool" => :test        # Test-time only
depends_on "optional-dep" => :optional # Optional dependency
```

## Testing

### Local Testing

Before submitting a pull request, test your formula locally:

```bash
# Install from local file
brew install --build-from-source ./Formula/your-tool.rb

# Run formula tests
brew test your-tool

# Audit for style and correctness
brew audit --strict your-tool

# Test on a clean system (recommended)
brew uninstall your-tool
brew install --build-from-source ./Formula/your-tool.rb
```

### Required Tests

Your formula must include a test block that verifies:

- The tool installs correctly
- Basic functionality works
- Version information is accessible

Example:

```ruby
test do
  assert_match version.to_s, shell_output("#{bin}/your-tool --version")
  system "#{bin}/your-tool", "--help"
end
```

## Pull Request Process

### Before Submitting

1. ✅ Test your formula locally
2. ✅ Run `brew audit --strict your-tool`
3. ✅ Ensure tests pass with `brew test your-tool`
4. ✅ Update documentation if needed
5. ✅ Follow commit message guidelines

### Commit Messages

- Use clear, descriptive commit messages
- Start with a verb in present tense (e.g., "Add", "Update", "Fix")
- Reference issues when applicable (e.g., "Fixes #123")

Examples:
```
Add formula for awesome-tool v1.2.3
Update example-tool to version 2.0.0
Fix installation path for my-tool
```

### PR Template

When creating a pull request, fill out the PR template completely:

- Describe what changes you made
- Explain why these changes are necessary
- List any breaking changes
- Confirm you've tested the changes
- Link to related issues

### Review Process

1. A maintainer will review your PR
2. Address any requested changes
3. Once approved, your PR will be merged
4. Your contribution will be included in the tap

## Style Guide

### Ruby Style

Follow the [Homebrew Ruby Style Guide](https://docs.brew.sh/Formula-Cookbook#homebrew-terminology):

- Use 2 spaces for indentation (no tabs)
- Keep lines under 80 characters when possible
- Use double quotes for strings
- Use `snake_case` for methods and variables
- Follow Ruby best practices

### Formula Style

- Order elements: desc, homepage, url, sha256, license, dependencies, install, test
- Use `#{bin}` instead of hardcoded paths
- Use `system` for running commands
- Use `bin.install` for installing executables

### Documentation

- Update README.md when adding new formulas
- Document any special installation requirements
- Include usage examples for complex tools
- Keep documentation clear and concise

## Getting Help

If you need help:

- Check the [Homebrew documentation](https://docs.brew.sh/)
- Review the [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- Ask questions in [GitHub Discussions](https://github.com/MagmaMoose/homebrew-tap/discussions)
- Open an issue for bugs or problems

## Additional Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Formula API](https://rubydoc.brew.sh/Formula)
- [Acceptable Formulae](https://docs.brew.sh/Acceptable-Formulae)
- [Homebrew Maintainer Guide](https://docs.brew.sh/Maintainer-Guidelines)

## License

By contributing, you agree that your contributions will be licensed under the same [MIT License](LICENSE) that covers this project.

## Thank You!

Your contributions help make this tap better for everyone. Thank you for taking the time to contribute! 🎉
