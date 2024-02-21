custom_prompt() {
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
  # Colorizes the path to the current working directory
  # and the working directory itself in a distinct color.
  local display_path
  if [[ -z "$full_path_except_last" || "$full_path_except_last" == "~" ]]; then
    display_path="%{%F{82}%}%B${current_directory}%b%{%f%}"
  else
    display_path="%{%F{yellow}%}${full_path_except_last}/%{%F{82}%}%B${current_directory}%b%{%f%}"
  fi
  # Formats the prompt (e.g., ➜ ~/development/github/myproject git:(master) ✗).
  PROMPT='%(?:%{%F{green}%}%1{➜%} :%{%F{red}%}%1{➜%} )'"${display_path}"' $(git_prompt_info) '
}

# Call the function to set the initial prompt.
custom_prompt

# Automatically update the prompt when changing directories.
autoload -Uz add-zsh-hook
add-zsh-hook chpwd custom_prompt
