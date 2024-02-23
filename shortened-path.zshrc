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
    for (( i = 2; i < path_length; i++ )); do
      if (( ${#result} + 4 + ${#path_parts[i]} + ${#current_directory} < max_length )); then
        result="${result}/${path_parts[i]}"
      else
        result="${result}/..."
        break
      fi
    done
  
    echo "${result}"
  }

  local shortened_path=$(shorten_path "${relative_path}")
  local path_without_current="${shortened_path%/*}"

  # Determine if the path was actually shortened by checking for presence of `...`
  if [[ "${shortened_path}" == *"..."* || "${relative_path}" != *"/"* ]]; then
    # Path was shortened, apply formatting to both parts
    display_path="%{%F{cyan}%}${path_without_current}/.../%b%{%F{82}%}%B${current_directory}%b%{%f%}"
  else
    # Path was not shortened, apply distinct formatting only to the current directory
    if [[ "${relative_path}" == "~" || "${relative_path}" == "" ]]; then
      display_path="%{%F{82}%}%B${current_directory}%b%{%f%}"
    else
      display_path="%{%F{cyan}%}${relative_path%/*}/%b%{%F{82}%}%B${current_directory}%b%{%f%}"
    fi
  fi

  PROMPT='%(?:%{%F{green}%}%1{➜%} :%{%F{red}%}%1{➜%} )'"${display_path} $(git_prompt_info)"
}

# Call the function to set the initial prompt.
custom_prompt

# Automatically update the prompt when changing directories.
autoload -Uz add-zsh-hook
add-zsh-hook chpwd custom_prompt
