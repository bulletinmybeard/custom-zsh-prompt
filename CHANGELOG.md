# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.6.0] - 2024-08-24
### Added
- New `custom_prompt_vars` helper function to manage custom prompt environment variables:
  - status: Display current status of all supported environment variables
- Introduced reload_zsh helper function to easily reload the Zsh session

### Changed
- Completely refactored `custom_prompt()` function for improved reliability and performance
- Enhanced customization options for Git-related colors in the prompt:
  - Added `ZSH_CUSTOM_PROMPT_GIT_BRACKET_COLOR` for Git status brackets
  - Added `ZSH_CUSTOM_PROMPT_GIT_BRANCH_COLOR` for branch names
- Updated `README` with comprehensive documentation on new features and customization options
- Overall prompt responsiveness and consistency across different environments

## [1.3.0] - 2024-03-01
### Added
- A second `zsh-hook` was added to automatically run the `custom_prompt` function when changing directories and before executing each command.

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
