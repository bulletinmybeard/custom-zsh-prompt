# custom-zsh-prompt
Customize your Oh My Zsh prompt with features and customization options.

## Overview
The default Zsh prompt provided by [➜ Oh My Zsh](https://ohmyz.sh/) (e.g., `PROMPT='%(?:%{%}%1{➜%} :%{%}%1{➜%} ) %{%}%c%{%} $(git_prompt_info)'`) typically displays only the current working directory (e.g., `➜ obsidian-gitlab-tooling-plugin git:(alpha-preview) ✗`) you're in. This may not provide enough context about your location in the filesystem.
If you prefer a more informative prompt that shows the full path for better context, you can override the default prompt. For example, using `PROMPT='%F{yellow}%~%f %# '` which will display the full path.
Alternatively, you can utilize the custom prompt function provided in `./custom-prompt.zshrc` for further customization.

## Installation
Copy and paste the contents of [➜ custom-prompt.zshrc](./custom-prompt.zshrc) into your `~/.zshrc` configuration file and run `source ~/.zshrc` to apply the changes to your Zsh environment.

## Features
- **Full Path Display:** Show the entire path in your prompt for clear navigation context.
- **Prompt Customization:** Tailor the style and colors of your prompt to fit your preferences.
- **Path Shortening:** Adjust the length and delimiter of the displayed path for a cleaner look.
- **Color Coding:** Assign distinct colors to different elements of your prompt for easy differentiation.
- **Oh My Zsh Integration:** Designed to work seamlessly with Oh My Zsh for a smooth user experience.
- **Environment Variable Customization:** Offers full customization through the use of environment variables, allowing for personalized setup and flexibility.

## Customization
To personalize your prompt, you can configure a variety of settings through environment variables.
Set these variables in your `~/.zshrc` or `~/.zshenv` file to modify aspects like path length, prompt style, colors, and symbols.

### Environment Variables
Below are the environment variables available for customizing the prompt, along with their default values:

| Environment Variable                      | Description                              | Default Value           |
|-------------------------------------------|------------------------------------------|-------------------------|
| `ZSH_CUSTOM_PROMPT_SHORTEN_LENGTH`        | Maximum length before shortening the path| `20`                    |
| `ZSH_CUSTOM_PROMPT_SHORTEN_DELIMITER`     | Indicator for shortened paths            | `...`                   |
| `ZSH_CUSTOM_PROMPT_STYLE`                 | Appearance style of the prompt           | (empty for full path)   |
| `ZSH_CUSTOM_PROMPT_CURRENT_DIR_COLOR`     | ANSI color code for the current directory| `82`                    |
| `ZSH_CUSTOM_PROMPT_FULL_PATH_COLOR`       | Color for the full path                  | `yellow`                |
| `ZSH_CUSTOM_PROMPT_SYMBOL`                | Starting symbol of the prompt            | `➜`                     |
| `ZSH_CUSTOM_PROMPT_SYMBOL_ERROR_COLOR`    | Color for the symbol on error            | `red`                   |
| `ZSH_CUSTOM_PROMPT_SYMBOL_SUCCESS_COLOR`  | Color for the symbol on success          | `green`                 |
| `ZSH_CUSTOM_PROMPT_INPUT_SEPARATOR_SYMBOL`| Symbol before input commands             | `$`                     |
| `ZSH_CUSTOM_PROMPT_INPUT_SEPARATOR_COLOR` | Color for the input separator            | `white`                 |

### Applying Custom Settings
Implement your custom settings with or without `export` commands in your zsh configuration file `~/.zshrc` or `~/.zshenv`. For example:

```bash
export ZSH_CUSTOM_PROMPT_SHORTEN_LENGTH=50
export ZSH_CUSTOM_PROMPT_SHORTEN_DELIMITER="___"
export ZSH_CUSTOM_PROMPT_STYLE="shorten"
export ZSH_CUSTOM_PROMPT_CURRENT_DIR_COLOR="green"
export ZSH_CUSTOM_PROMPT_FULL_PATH_COLOR="magenta"
export ZSH_CUSTOM_PROMPT_SYMBOL="$"
export ZSH_CUSTOM_PROMPT_SYMBOL_ERROR_COLOR="orange"
export ZSH_CUSTOM_PROMPT_SYMBOL_SUCCESS_COLOR="141"
export ZSH_CUSTOM_PROMPT_INPUT_SEPARATOR_SYMBOL="$"
export ZSH_CUSTOM_PROMPT_INPUT_SEPARATOR_COLOR="yellow"
```

> Keep in mind to source the `~/.zshenv` (e.g., `source ~/.zshenv`) or start a new shell session
> to ensure that your environment settings work correctly.
> Moreover, `~/.zshenv` will be loaded before `~/.zshrc` and identical environment variables set in both files will overwrite each other!

### Colors
Colors can be specified using either color names (e.g., green) or ANSI color codes (e.g., 32).
A list of available ANSI color codes is to find [here](https://talyian.github.io/ansicolors/).

