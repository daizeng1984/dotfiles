# fix annoying PATH mess by tmux in Mac https://superuser.com/questions/544989/does-tmux-sort-the-path-variable
if [ "$DOTFILES_SYSTEM_NAME" = "darwin" ]; then
    if [ -f /etc/profile ]; then
        PATH=""
        source /etc/profile
    fi
fi

# This bashrc load the universal setup for bash
# enable color in terminal
export CLICOLOR=1
# Color
RED='\033[0;31m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if [ -n "$force_color_prompt" ]; then
   if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
   else
	color_prompt=
   fi
fi

if [ "$color_prompt" = yes ]; then
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
   PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -hF --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# A copy that can solve Mac's "problem"
alias copy='rsync --progress -ravzI'
alias v='vim -n --cmd "filetype indent on" -u "NONE"'
alias vimm="vim -u $HOME/.config/nvim/init.vim"

# conda
# Dotfile Binary PATH
export DOTFILE_LOCAL_PREFIX=$HOME/.dotfiles/.local
# Override all bin
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$DOTFILE_LOCAL_PREFIX/lib/miniconda/bin/conda' 'shell.${DOTFILES_SHELL_TYPE}' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$DOTFILE_LOCAL_PREFIX/lib/miniconda/etc/profile.d/conda.sh" ]; then
        . "$DOTFILE_LOCAL_PREFIX/lib/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="$DOTFILE_LOCAL_PREFIX/lib/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate
conda activate
export PATH=$DOTFILE_LOCAL_PREFIX/bin:${PATH}


source "$HOME/.dotfiles/bashscript/function_definitions.sh"

# Fzf and ag is my new love
installedFzf=$(checkIfInstalled "fzf" fzf)
installedAg=$(checkIfInstalled "ag" the_silver_searcher)
installedFd=$(checkIfInstalled "fd" fd-find)
installedFasd=$(checkIfInstalled "fasd" fasd)
installedRipGrep=$(checkIfInstalled "rg" ripgrep)
installedXdgOpen=$(checkIfInstalled "xdg-open" xdg-open --quiet)

# TODO: export certainfile='$(fzf)'
# Initialize fasd
if [ "$installedFasd" = "1" ] && [ "$installedFzf" = "1" ] ; then
# FZF from fzf.zsh
# Auto-completion
# ---------------
eval "$(fasd --init ${DOTFILES_SHELL_TYPE}-hook ${DOTFILES_SHELL_TYPE}-ccomp ${DOTFILES_SHELL_TYPE}-ccomp-install)"
[[ $- == *i* ]] && source "$CONDA_PREFIX/share/fzf/shell/completion.${DOTFILES_SHELL_TYPE}" 2> /dev/null
# Key bindings
# ------------
source "$CONDA_PREFIX/share/fzf/shell/key-bindings.${DOTFILES_SHELL_TYPE}"
alias j=fd
alias ja=fda
alias jj=cdf
alias fzf="fzf --multi --bind 'ctrl-e:jump'"
fi
# Alias for open, you know we don't need to do this on mac
if [ "$installedXdgOpen" = "0" ]; then
    alias xdg-open=open
fi
