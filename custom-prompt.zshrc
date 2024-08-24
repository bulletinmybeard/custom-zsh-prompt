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
  local current_directory_color=$(get_prompt_var CURRENT_DIR_COLOR)
  local full_path_color=$(get_prompt_var FULL_PATH_COLOR)
  local prompt_symbol=$(get_prompt_var SYMBOL)
  local prompt_symbol_error_color=$(get_prompt_var SYMBOL_ERROR_COLOR)
  local prompt_symbol_success_color=$(get_prompt_var SYMBOL_SUCCESS_COLOR)
  local input_separator=$(get_prompt_var INPUT_SEPERATOR_SYMBOL)
  local input_separator_color=$(get_prompt_var INPUT_SEPERATOR_COLOR)
  local max_length=$(get_prompt_var SHORTEN_LENGTH)
  local path_delimiter=$(get_prompt_var SHORTEN_DELIMITER)
  local prompt_style=$(get_prompt_var STYLE)
  local git_bracket_color=$(get_prompt_var GIT_BRACKET_COLOR)
  local git_branch_color=$(get_prompt_var GIT_BRANCH_COLOR)

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

  if [[ "$prompt_style" == "shorten" ]]; then
    local shortened_relative_path=$(shorten_path "${relative_path}")
    if [[ -n "$shortened_relative_path" ]]; then
      if [[ "${shortened_relative_path}" == "${relative_path}" ]]; then
        display_path="%F{${full_path_color}}${relative_path}%f"
      else
        local path_except_current="${shortened_relative_path%/*}"
        display_path="%F{${full_path_color}}${path_except_current}/%F{${current_directory_color}}${current_directory}%f"
      fi
    else
      display_path="%F{${full_path_color}}${relative_path}%f"
    fi
  else
    local full_path_except_last="${relative_path%/*}"
    if [[ "$full_path_except_last" == "$relative_path" ]]; then
      display_path="%F{${current_directory_color}}${relative_path}%f"
    else
      display_path="%F{${full_path_color}}${full_path_except_last}/%F{${current_directory_color}}${current_directory}%f"
    fi
  fi

  custom_git_prompt_info() {
      git status -s &>/dev/null
      local git_info=$(git_prompt_info)
      local git_bracket_color=$(get_prompt_var GIT_BRACKET_COLOR)
      local git_branch_color=$(get_prompt_var GIT_BRANCH_COLOR)

      if [[ -n "$git_info" ]]; then
          echo "${git_info}"
      else
          # If git_prompt_info returns nothing, get the branch name directly
          local branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
          if [[ -n "$branch_name" ]]; then
              echo "%F{${git_bracket_color}}git:(%F{${git_branch_color}}${branch_name}%F{${git_bracket_color}})%f "
          else
              echo "%F{${input_separator_color}}${input_separator}%f "
          fi
      fi
  }

  # Set the prompt components
  local symbol_part='%(?:%F{'"${prompt_symbol_success_color}"'}::%F{'"${prompt_symbol_error_color}"'})'"${prompt_symbol}"'%f'
  local git_part='$(custom_git_prompt_info)'

  # Construct PROMPT
  PROMPT="${symbol_part} ${display_path} ${git_part}"
}

# Load add-zsh-hook function
autoload -Uz add-zsh-hook

# Automatically update the prompt when changing directories and before each command execution
add-zsh-hook chpwd custom_prompt
add-zsh-hook precmd custom_prompt

# Initialize the prompt
custom_prompt