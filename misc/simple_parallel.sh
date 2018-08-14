#!/bin/bash
# Inspired by npm's concurent script, mainly use for easier development
# Example: 
#   ./simple_parallel.sh "redis-server= && redis
#           flask= && python app.py
#           somewatcher= && python nightwatcher.py

echo $TMPDIR
if [ "$TMPDIR" = "" ]; then
    TMPDIR='/tmp/'
fi
[ ! -d $TMPDIR ] && mkdir -p $TMPDIR
echo "Dump log to tmpdir: $TMPDIR"

IFS=$'\n' read -d '' -r -a cmd << EOF
$@
EOF

pgid=$(ps -o pgid= $$ | grep -o '[0-9]\+')

# Run all cmds
for i in "${!cmd[@]}"; do 
    c="${cmd[$i]}"
    cmdname=$(echo ${c} | awk '{print $1;}' | tr '[a-z]' '[A-Z]')
    tmplog="${TMPDIR}/${cmdname}.log"
    touch "$tmplog"
    esc=$(printf '\e')
    echo "Executing command: $c"
    title="$esc[0;$(($i+41))m[${cmdname}]$esc[0m"
    eval "$c " 2>&1 | tee "${tmplog}" 2>&1 | sed -e "s/^/${title}  /" & p=$!
    PID_LIST+="$p "
done

killall() {
    echo "kill $1"
    pkill -9 -g $1
}
trap "killall $pgid" SIGINT
wait $PID_LIST
