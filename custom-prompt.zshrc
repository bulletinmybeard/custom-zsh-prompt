# Define custom prompt variables and their default values
typeset -A custom_prompt_vars
custom_prompt_vars=(
    [ZSH_CUSTOM_PROMPT_STYLE]="full"
    [ZSH_CUSTOM_PROMPT_CURRENT_DIR_COLOR]="82"
    [ZSH_CUSTOM_PROMPT_FULL_PATH_COLOR]="yellow"
    [ZSH_CUSTOM_PROMPT_SYMBOL]="➜"
    [ZSH_CUSTOM_PROMPT_SYMBOL_ERROR_COLOR]="red"
    [ZSH_CUSTOM_PROMPT_SYMBOL_SUCCESS_COLOR]="green"
    [ZSH_CUSTOM_PROMPT_INPUT_SEPERATOR_SYMBOL]="#"
    [ZSH_CUSTOM_PROMPT_INPUT_SEPERATOR_COLOR]="white"
    [ZSH_CUSTOM_PROMPT_SHORTEN_LENGTH]="20"
    [ZSH_CUSTOM_PROMPT_SHORTEN_DELIMITER]="..."
    [ZSH_CUSTOM_PROMPT_GIT_BRACKET_COLOR]="blue"
    [ZSH_CUSTOM_PROMPT_GIT_BRANCH_COLOR]="red"
)

# Helper function to get the value of a custom prompt variable
get_prompt_var() {
    local var_name="ZSH_CUSTOM_PROMPT_$1"
    echo "${(P)var_name:-${custom_prompt_vars[$var_name]}}"
}

# Function to manage custom prompt variables
custom_prompt_vars() {
    local action=$1

    case "$action" in
        status)
            for var in ${(k)custom_prompt_vars}; do
                if [[ -v $var ]]; then
                    echo "$var=${(P)var}"
                else
                    echo "$var is not set (default: ${custom_prompt_vars[$var]})"
                fi
            done
            ;;
        *)
            echo "Usage: custom_prompt_vars [set|unset|status]"
            ;;
    esac
}

# Reload Zsh
reload_zsh() {
  exec zsh
}

# Custom prompt function
custom_prompt() {
  local current_directory_color="${ZSH_CUSTOM_PROMPT_CURRENT_DIR_COLOR:-"82"}"
  local full_path_color="${ZSH_CUSTOM_PROMPT_FULL_PATH_COLOR:-"yellow"}"

  local prompt_symbol="${ZSH_CUSTOM_PROMPT_SYMBOL:-"➜"}"
  local prompt_symbol_error_color="${ZSH_CUSTOM_PROMPT_SYMBOL_ERROR_COLOR:-"red"}"
  local prompt_symbol_success_color="${ZSH_CUSTOM_PROMPT_SYMBOL_SUCCESS_COLOR:-"green"}"

  local input_separator="${ZSH_CUSTOM_PROMPT_INPUT_SEPERATOR_SYMBOL:-"#"}"
  local input_separator_color="${ZSH_CUSTOM_PROMPT_INPUT_SEPERATOR_COLOR:-"white"}"

  if [[ "$ZSH_CUSTOM_PROMPT_STYLE" == "shorten" ]]; then
    local max_length="${ZSH_CUSTOM_PROMPT_SHORTEN_LENGTH:-"20"}"
    local path_delimiter="${ZSH_CUSTOM_PROMPT_SHORTEN_DELIMITER:-"..."}"

    local relative_path="${PWD/#$HOME/~}"
    local current_directory="${PWD##*/}"
    local display_path=""

    shorten_path() {
      local p="$1"
      local -a path_parts=("${(@s:/:)p}")
      local result=""
      local path_length=${#path_parts[@]}

      if (( ${#p} <= max_length || path_length <= 3 )); then
        echo "$p"
        return
      fi

      # Build the shortened path.
      result="${path_parts[1]}"
      for (( i = 2; i <= path_length - 1; i++ )); do
        if (( ${#result} + 4 + ${#path_parts[i]} + ${#current_directory} < max_length )); then
          result="${result}/${path_parts[i]}"
        else
          break
        fi
      done

      echo "${result}/${path_delimiter}/${current_directory}"
    }

    local shortened_path=$(shorten_path "${relative_path}")
    if [[ "${shortened_path}" == "${relative_path}" ]]; then
      display_path="%{%F{${full_path_color}}%}${relative_path}%b"
    else
      local path_except_current="${shortened_path%/*}"
      display_path="%{%F{${full_path_color}}%}${path_except_current}/%{%F{${current_directory_color}}%}${current_directory}%b"
    fi
  else
    # Gets the relative path of the current working directory
    # and replaces the home directory with a tilde (~) to shorten the full path.
    local relative_path="${PWD/#$HOME/~}"

    # Gets all the directory components of the relative path except for the last one.
    local full_path_except_last="${relative_path%/*}"

    # Checks if there were subdirectories within the home directory.
    if [[ "$full_path_except_last" == "$relative_path" ]]; then
      full_path_except_last=""
    fi

    # Extracts only the final directory name.
    local current_directory="${PWD##*/}"

    # Colorizes the path to the current working directory and the working directory itself in a distinct color.
    local display_path
    if [[ -z "$full_path_except_last" || "$full_path_except_last" == "~" ]]; then
      display_path="%{%F{${current_directory_color}}%}%B${current_directory}%b%{%f%}"
    else
      display_path="%{%F{${full_path_color}}%}${full_path_except_last}/%{%F{${current_directory_color}}%}%B${current_directory}%b%{%f%}"
    fi
  fi

  custom_git_prompt_info() {
    local git_info=$(git_prompt_info)
    if [[ -n "$git_info" ]]; then
      echo "${git_info}"
    else
      echo "%{%F{${input_separator_color}}%}${input_separator} "
    fi
  }

  PROMPT='%(?:'"%{%F{${prompt_symbol_success_color}}%}${prompt_symbol}%{%f%}"' :'"%{%F{${prompt_symbol_error_color}}%}${prompt_symbol}%{%f%}"' )'"${display_path} $(custom_git_prompt_info)"
}

# Call the function to set the initial prompt.
custom_prompt

# Automatically update the prompt when changing directories.
autoload -Uz add-zsh-hook
add-zsh-hook chpwd custom_prompt
