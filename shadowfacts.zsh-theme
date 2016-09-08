local current_dir='${PWD/#$HOME/~}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✖︎︎"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}●"

local git_info='$(git_prompt_info)'

# # USER in DIRECTORY on git:BRANCH STATE [TIME]
# â
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$fg[cyan]%}%n \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info} \
%{$fg[white]%}[%D{%r}]
%{$terminfo[bold]$fg[red]%}→ %{$reset_color%}"
