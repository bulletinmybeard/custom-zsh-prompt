custom_prompt() {
  # Maximum allowed length of the displayed path.
  local max_length=50
  local relative_path="${PWD/#$HOME/~}"
  local current_directory="${PWD##*/}"
  local display_path=""

  # Shorten the path to the current working directory.
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

    echo "${result}/.../${current_directory}"
  }

  local shortened_path=$(shorten_path "${relative_path}")
  if [[ "${shortened_path}" == "${relative_path}" ]]; then
    display_path="%{%F{cyan}%}${relative_path}%b"
  else
    display_path="%{%F{cyan}%}${shortened_path}%b"
  fi

  PROMPT='%(?:%{%F{green}%}%1{➜%} :%{%F{red}%}%1{➜%} )'"${display_path} $(git_prompt_info)"
}

# Call the function to set the initial prompt.
custom_prompt

# Automatically update the prompt when changing directories.
autoload -Uz add-zsh-hook
add-zsh-hook chpwd custom_prompt
