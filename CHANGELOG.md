# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.2] - 2024-02-24
### Added
- A new `custom-prompt.zshrc` file has been created, merging the two functions from `full-path.zshrc` and `shortened-path.zshrc`.
- Customization support is available through environment variables.

### Removed
- `full-path.zshrc` and `shortened-path.zshrc` in favour of `custom-prompt.zshrc`.

## [1.0.0] - 2024-02-21
Initial release of the project, providing Zsh scripts including:
- Full path and current working directory showing in different colors.
- Shortened path and current working directory showing in different colors.
