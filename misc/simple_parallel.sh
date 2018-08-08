#!/bin/bash
#TODO: kill if any commands fail
TMPDIR='./tmp/'
declare -a cmd=(
"cmd1" 
"cmd2" 
"cmd3" 
)
trapcmd=""
for i in "${!cmd[@]}"; do 
    if [ ${i} -eq 0 ]; then
        trapcmd="kill %$(($i+1))"
    else
        trapcmd="$trapcmd; kill %$(($i+1))"
    fi
done
echo $trapcmd
trap "$trapcmd" SIGINT

# Run all cmds
for i in "${!cmd[@]}"; do 
    c="${cmd[$i]}"
    cmdname=$(echo ${c} | awk '{print $1;}' | tr '[a-z]' '[A-Z]')
    tmplog="${TMPDIR}/${cmdname}.log"

    touch "$tmplog"
    title="\$(echo '\\\\\\e[0;$(($i+41))m[${cmdname}]\\\\\\e[0m') "
    echo $title
    common="$c  2>&1 | tee ${tmplog} | sed -e \"s/^/${title} /\" "
    iplusone=$(($i+1))
    if [ ${iplusone} -eq ${#cmd[@]} ]; then
        eval "$common"
    else
        eval "$common &"
    fi
done
