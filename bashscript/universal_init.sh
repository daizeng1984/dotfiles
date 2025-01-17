# fix annoying PATH mess by tmux in Mac https://superuser.com/questions/544989/does-tmux-sort-the-path-variable
if [ "$DOTFILES_SYSTEM_NAME" = "darwin" ]; then
    if [ -f /etc/profile ]; then
        PATH=""
        source /etc/profile
    fi
fi

export TERM=xterm-256color
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000
export HISTTIMEFORMAT="";
# This bashrc load the universal setup for bash
# enable color in terminal
export CLICOLOR=1
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


# git branch
parse_git_branch() {
     git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/"
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[00m\]\[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]> '
else
    PS1='${debian_chroot:+($debian_chroot)}\u \w$(parse_git_branch)> '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
alias ls='ls -hF --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# A copy that can solve Mac's "problem"
alias copy='rsync --progress -ravzI'
alias v='vim -n --cmd "filetype indent on" -u "NONE"'
alias vim="vim -u $HOME/.config/nvim/init.vim"
alias nvim="nvim -u $HOME/.config/nvim/init.vim"
alias vimprofile='vim --startuptime /tmp/vimstartuptime.txt -c ":q" && cat /tmp/vimstartuptime.txt'
alias nvimprofile='nvim --startuptime /tmp/vimstartuptime.txt -c ":q" && cat /tmp/vimstartuptime.txt'

source "$HOME/.dotfiles/bashscript/function_definitions.sh"
# pkg manager priority Nix > Conda > Adhoc
# adhoc
export DOTFILE_LOCAL_PREFIX=$HOME/.dotfiles/.local
export PATH=$DOTFILE_LOCAL_PREFIX/bin:${PATH}

# conda
installedConda=$(checkIfInstalled "$DOTFILE_LOCAL_PREFIX/lib/miniconda/bin/conda" installConda.sh --quiet)
if [ "$installedConda" = "1" ] ; then
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
    # TODO: do we need this?
    conda deactivate
    conda activate
    if [ -f "$DOTFILE_LOCAL_PREFIX/lib/miniconda/etc/profile.d/mamba.sh" ]; then
        . "$DOTFILE_LOCAL_PREFIX/lib/miniconda/etc/profile.d/mamba.sh"
    fi
fi

# brew
if [ -e /home/linuxbrew/.linuxbrew ]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; fi
if [ -e ~/.brew/ ]; then eval "$(~/.brew/bin/brew shellenv)"; fi

# nix
export PROOT_NO_SECCOMP=1
if [ -e $NIX_HOME_PATH/etc/profile.d/nix.sh ]; then . $NIX_HOME_PATH/etc/profile.d/nix.sh; fi # added by Nix installer
# nix home-manager
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
[ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ] && source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh


# Fzf and ag is my new love
installedFzf=$(checkIfInstalled "fzf" fzf --quiet)
installedAg=$(checkIfInstalled "ag" the_silver_searcher --quiet)
installedFd=$(checkIfInstalled "fd" fd-find --quiet)
installedFasd=$(checkIfInstalled "fasd" fasd --quiet)
installedZoxide=$(checkIfInstalled "zoxide" zoxide --quiet)
installedDirenv=$(checkIfInstalled "direnv" direnv --quiet)
installedDircolors=$(checkIfInstalled "dircolors" dircolors --quiet)
installedExa=$(checkIfInstalled "exa" exa --quiet)
installedRipGrep=$(checkIfInstalled "rg" ripgrep --quiet)
installedXdgOpen=$(checkIfInstalled "xdg-open" xdg-open --quiet)
installedTgpt=$(checkIfInstalled "tgpt" tgpt --quiet)

# ls aliases
if [ "$installedDircolors" = "1" ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ "$installedExa" = "1" ] ; then
    alias la='ls -A'
    alias l='ls -CF'
    alias ll='exa -alF -snew'
else
    alias ll='ls -ahlF'
    alias la='ls -A'
    alias l='ls -CF'
fi

# TODO: export certainfile='$(fzf)'
# Initialize zoxide or fasd
if [ "$installedZoxide" = "1" ] ; then
    export _ZO_MAXAGE=99999
    # fasd
    z() {
        local dir
        dir="$(zoxide query -l | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
    }

    zz() {
        echo "not implemented yet!"
    }
    
    eval "$(zoxide init ${DOTFILES_SHELL_TYPE} --no-aliases)"
elif [ "$installedFasd" = "1" ] ; then
    eval "$(fasd --init ${DOTFILES_SHELL_TYPE}-hook ${DOTFILES_SHELL_TYPE}-ccomp ${DOTFILES_SHELL_TYPE}-ccomp-install)"
    # fasd
    z() {
        local dir
        dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
    }
    zz() {
        local file
        file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && open "${file}" || return 1
    }
fi

if [ "$installedFzf" = "1" ] ; then
# FZF from fzf.zsh
# Auto-completion
# ---------------
if [[ $- == *i* ]] ; then
    # Try to find different source of fzf, make sure you are not installing multiple version
    if [ -x $NIX_HOME_PATH/bin/fzf ] ; then
        source "$NIX_HOME_PATH/share/fzf/completion.${DOTFILES_SHELL_TYPE}" 2> /dev/null
        source $NIX_HOME_PATH/share/fzf/key-bindings.${DOTFILES_SHELL_TYPE}
    elif [ -x $CONDA_PREFIX/bin/fzf ] ; then
        source "$CONDA_PREFIX/share/fzf/shell/completion.${DOTFILES_SHELL_TYPE}" 2> /dev/null
        source $CONDA_PREFIX/share/fzf/shell/key-bindings.${DOTFILES_SHELL_TYPE}
    elif [ -r $HOME/.fzf/shell/key-bindings.${DOTFILES_SHELL_TYPE} ] ; then
        source "$HOME/.fzf/shell/completion.${DOTFILES_SHELL_TYPE}" 2> /dev/null
        source $HOME/.fzf/shell/key-bindings.${DOTFILES_SHELL_TYPE}
    fi
fi
alias j=fd
alias ja=fda
alias jj=cdf
alias fzf="fzf --multi --bind 'ctrl-e:jump'"
fi
# Alias for open, you know we don't need to do this on mac
if [ "$installedXdgOpen" = "0" ]; then
    alias xdg-open=open
fi

# Initialize direnv
if [ "$installedDirenv" = "1" ] ; then
    eval "$(direnv hook ${DOTFILES_SHELL_TYPE} )"
fi

# Setup tgpt
if [ "$installedTgpt" = "0" ] ; then
    source $DOTFILES_HOME/misc/installTgpt.sh
fi
export AI_PROVIDER=duckduckgo

