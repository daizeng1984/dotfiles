local filestat='$(expr $(ls -afq | wc -l) - 2)'
# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
# It might be bash like, but I can't have my co-workers knowing I use zsh
PROMPT='%U%{$FG[214]%}%n@%m:%u%{$reset_color%}%{$FG[045]%}%B%2~%b $(git_prompt_info)%{$reset_color%}%(!.#.$)  '
RPROMPT="${filestat} Files"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[166]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%}"

