#!/bin/bash
TMPDIR='./tmp/'
declare -a cmd=(
"cmd1" 
"cmd2" 
"cmd3" 
)

pgid=$$

# Run all cmds
for i in "${!cmd[@]}"; do 
    c="${cmd[$i]}"
    cmdname=$(echo ${c} | awk '{print $1;}' | tr '[a-z]' '[A-Z]')
    tmplog="${TMPDIR}/${cmdname}.log"

    touch "$tmplog"
    esc=$(printf '\e')
    title="$esc[0;$(($i+41))m[${cmdname}]$esc[0m"
    common="$c 2>&1 | tee ${tmplog}" 
    eval "$c " 2>&1 | tee "${tmplog}" 2>&1 | sed -e "s/^/${title}  /" & p=$!
    PID_LIST+="$p "
    #
done

killall() {
for pid in $1; do
for child in $(ps -o pid,pgid -ax | awk "{ if ( \$2 == $pid ) { print \$1 }}"); do
    if [ "$child" != "$pid" ]; then
        #echo "kill $child"
        kill -9 "$child" &> /dev/null
    fi
done
done
}
trap "killall $pgid" SIGINT
wait $PID_LIST


