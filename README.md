# custom-zsh-prompt

Customize your Oh My Zsh prompt with enhanced features and easy customization options.

## Overview

The default Zsh prompt provided by [Oh My Zsh](https://ohmyz.sh/) typically displays only the current working directory (e.g., `➜ obsidian-gitlab-tooling-plugin git:(alpha-preview) ✗`). This custom prompt script enhances your prompt by providing more context about your location in the filesystem and offering extensive customization options.

## Features

- **Full Path Display:** Show the entire path in your prompt for clear navigation context.
- **Path Shortening:** Adjust the length and delimiter of the displayed path for a cleaner look.
- **Color Coding:** Assign distinct colors to different elements of your prompt for easy differentiation.
- **Prompt Symbol Customization:** Change the prompt symbol and its colors for success and error states.
- **Git Integration:** Displays git branch information with customizable colors.
- **Oh My Zsh Integration:** Designed to work seamlessly with Oh My Zsh for a smooth user experience.
- **Environment Variable Customization:** Offers full customization through the use of environment variables, allowing for personalized setup and flexibility.

## Installation

1. Copy the contents of `custom-prompt.zshrc` into your `~/.zshrc` configuration file.
2. Run `source ~/.zshrc` or `reload_zsh` to apply the changes to your Zsh environment.

## Customization

You can customize your prompt by setting environment variables in your `~/.zshrc` or `~/.zshenv` file. These variables allow you to modify aspects like path length, prompt style, colors, and symbols.

### Environment Variables

Here are the environment variables available for customizing the prompt, along with their default values:

| Environment Variable                       | Description                                      | Default Value |
|--------------------------------------------|--------------------------------------------------|---------------|
| `ZSH_CUSTOM_PROMPT_STYLE`                  | Appearance style of the prompt                   | `full`        |
| `ZSH_CUSTOM_PROMPT_SHORTEN_LENGTH`         | Maximum length before shortening the path        | `50`          |
| `ZSH_CUSTOM_PROMPT_SHORTEN_DELIMITER`      | Indicator for shortened paths                    | `...`         |
| `ZSH_CUSTOM_PROMPT_CURRENT_DIR_COLOR`      | Color for the current directory                  | `82`          |
| `ZSH_CUSTOM_PROMPT_FULL_PATH_COLOR`        | Color for the full path                          | `yellow`      |
| `ZSH_CUSTOM_PROMPT_SYMBOL`                 | Starting symbol of the prompt                    | `➜`           |
| `ZSH_CUSTOM_PROMPT_SYMBOL_ERROR_COLOR`     | Color for the symbol on error                    | `red`         |
| `ZSH_CUSTOM_PROMPT_SYMBOL_SUCCESS_COLOR`   | Color for the symbol on success                  | `green`       |
| `ZSH_CUSTOM_PROMPT_INPUT_SEPERATOR_SYMBOL` | Symbol before input commands                     | `#`           |
| `ZSH_CUSTOM_PROMPT_INPUT_SEPERATOR_COLOR`  | Color for the input separator                    | `white`       |
| `ZSH_CUSTOM_PROMPT_GIT_BRACKET_COLOR`      | Color for the Git brackets (e.g., `git:(...)`)   | `blue`        |
| `ZSH_CUSTOM_PROMPT_GIT_BRANCH_COLOR`       | Color for the Git branch name (e.g., `master`)   | `red`         |

### Applying Custom Settings

To customize your prompt, add your preferred settings to your `~/.zshrc` or `~/.zshenv` file. For example:

```bash
export ZSH_CUSTOM_PROMPT_STYLE="shorten"
export ZSH_CUSTOM_PROMPT_SHORTEN_LENGTH=20
export ZSH_CUSTOM_PROMPT_CURRENT_DIR_COLOR="green"
export ZSH_CUSTOM_PROMPT_FULL_PATH_COLOR="magenta"
export ZSH_CUSTOM_PROMPT_SYMBOL="$"
export ZSH_CUSTOM_PROMPT_GIT_BRACKET_COLOR="cyan"
export ZSH_CUSTOM_PROMPT_GIT_BRANCH_COLOR="magenta"
```

After adding or modifying these variables, restart your terminal or run `source ~/.zshrc` to apply the changes.

### Colors

Colors can be specified using either color names (e.g., green) or ANSI color codes (e.g., 32).
For a list of available ANSI color codes, refer to [this color chart](https://talyian.github.io/ansicolors/).

## Debugging

If you need to check the current status of your custom prompt variables, you can use the `custom_prompt_vars` function:

```bash
custom_prompt_vars status
```

This will display all supported environment variables and their current values or default settings if not set.

## Notes

- The `~/.zshenv` file is loaded before `~/.zshrc`. If you set identical environment variables in both files, the ones in `~/.zshrc` will take precedence.
- Remember to source your configuration file (`source ~/.zshrc`) or start a new shell session after making changes to ensure your settings are applied correctly.