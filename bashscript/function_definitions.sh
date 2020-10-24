# Color
RED='\033[0;31m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Installation check
checkIfInstalled() {
    if ! type ${1}  > /dev/null 2>&1; then
        if [ "${3}" != "--quiet" ]; then
            >&2 printf "${RED}${1} might not be found or installed correctly.${NC} Try ${GREEN}nix-env or conda to install ${2}${NC}!\n"
        fi
        echo "0"
    else
        if [ "${3}" != "--quiet" ]; then
            >&2 printf "${GREEN}${1}${NC} is ready.\n"
        fi
        echo "1"
    fi
}

# fasd
z() {
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

zz() {
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && open "${file}" || return 1
}

# fzf tools from https://github.com/junegunn/fzf/wiki/examples
# fd - cd to selected directory
cdd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
}
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}
sfkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    sudo kill -${1:-9} $pid
  fi
}
# fshow - git commit browser
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --bind 'ctrl-e:jump' --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue

    param1=$(echo $shas | tr '\n' ' ' | cut -d " " -f 1)
    param2=$(echo $shas | tr '\n' ' ' | cut -d " " -f 2)

    if [ "$k" = ctrl-d ]; then
        git d ${param2} ${param1} --
        break
    else
        git --no-pager diff ${param2} ${param1} | diff-so-fancy | less --tabs=4 -R
    fi
  done
}


rgrep(){
    rg -p "$@" | less -R
}

search(){
    fd -HI $@
}

# ftpane - switch pane (@george-b) https://github.com/junegunn/fzf/wiki/Examples#tmux
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

delete(){
    trash-put -v $@
}
# restore the trash files
frestore() {
    CHOICE=$(echo -ne '\n' | trash-restore  / | grep -P '^\s+\d+.*$' | fzf -m )
    if [ -z $CHOICE ] ; then
        printf "No files for restore...\n"
    else
        CHOICE_ID=$(echo $CHOICE | awk '{print $1}')
        CHOICE_FULL_PATH=$(echo $CHOICE | awk '{print $4}')
        echo -ne "$CHOICE_ID" | trash-restore /  > /dev/null
        printf "Restored file $CHOICE_FULL_PATH.\n"
    fi
}

fwmctrl() {
    CHOICE=$(wmctrl -l | fzf -m )
    if [ -z $CHOICE ] ; then
        printf "No window to show...\n"
    else
        CHOICE_ID=$(echo $CHOICE | awk '{print $1}')
		# hack to layout all openai gym windows in a row, e.g.  fwmctrl layout 100 200 300
		if [ "$1" != "layout" ]; then
            while read -r line; do
                wmctrl -i -r "$line" $@
            done <<< "$CHOICE_ID"
        else
			_w_x=$2
			_w_y=$3
			_w_w=$4
            while read -r line; do
                printf "Moving window starting ($_w_x , $_w_y ) of width $_w_w...\n"
                wmctrl -i -r "$line" -e 0,$_w_x,$_w_y,-1,-1
                _w_x=$(expr $_w_x + $_w_w)
            done <<< "$CHOICE_ID"
        fi
    fi
}

# use nvim and fugitive
gst(){
GIT_INDEX="$(git rev-parse --show-toplevel)/.git/index"
if [ -f $GIT_INDEX ]; then
    # nvim $GIT_INDEX
    nvim . -c ":Gstatus"
fi
}

# check listening port
listen_port() {
    lsof -i -P -n | grep LISTEN
}

e() {
    dtrx -v $@
}

br() {
    broot --sort-by-size -h $@
}
