# custom-zsh-prompt
Customize Oh My Zsh (zsh-syntax-highlighting) prompt.

## Guide Overview
The default prompt (e.g., `PROMPT = %(?:%{%}%1{➜%} :%{%}%1{➜%} ) %{%}%c%{%} $(git_prompt_info)`) doesn't show the full path and only the current working directory (e.g., `➜ github ✗`).
In order to change that, you could simply update your `~/.zshrc` with something like `PROMPT='%1~ %# '`.
For a more customized prompt, you can leverage Zsh's script and hook capabilities and create a function to build the custom prompt.

Copy and paste either of the functions and function/hook calls into your `~/.zshrc` config and run `source ~/.zshrc` to dynamically apply configuration changes to your Zsh environment without restarting your terminal.

## Full path
E.g.,
```bash
/Users/<username>/Library/Mobile Documents/iCloud~md~obsidian/<vault_name>/.obsidian/plugins/obsidian-gitlab-tooling-plugin
```
results to

```bash
➜ ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/<vault_name>/.obsidian/plugins/obsidian-gitlab-tooling-plugin git:(alpha-preview) ✗
```

[➜ full-path.zshrc](./full-path.zshrc)

## Shortened path
E.g.,
```bash
/Users/<username>/Library/Mobile Documents/iCloud~md~obsidian/<vault_name>/.obsidian/plugins/obsidian-gitlab-tooling-plugin
```
results to

```bash
➜ ~/Library/.../obsidian-gitlab-tooling-plugin git:(alpha-preview) ✗
```

[➜ shortened-path.zshrc](./shortened-path.zshrc)
