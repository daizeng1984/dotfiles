# -*- sh -*- vim:set ft=sh ai et sw=4 sts=4:
PROMPT='${__VIM_MODE__}%{${FG[045]}%}%B%2~ %{$FG[166]%}$(parse_git_branch)%{$reset_color%}%(!.#.>)%b '
RPROMPT='${__VIM_MODE__}%{$fg_bold[green]%}%D{%Y/%m/%f}|%*%{$reset_color%}'
