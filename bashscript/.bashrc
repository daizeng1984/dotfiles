# Which machine? we use uname to see: http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
if [ "$(uname -s)" == "Darwin" ]; then
    [ -r $HOME/.macbashrc ] && source $HOME/.macbashrc
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    [ -r $HOME/.linuxbashrc ] && source $HOME/.linuxbashrc
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
    [ -r $HOME/.cygwinbashrc ] && source $HOME/.cygwinbashrc
fi
