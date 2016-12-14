# Which machine? we use uname to see: http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
if [ "$(expr substr $(uname -s) 1 6)" == "Darwin" ]; then
	echo "Find Darwin System..."
    [ -r $HOME/.macbashrc ] && source $HOME/.macbashrc
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	echo "Find Linux System..."
    [ -r $HOME/.linuxbashrc ] && source $HOME/.linuxbashrc
elif [ "$(expr substr $(uname -s) 1 9)" == "CYGWIN_NT" ]; then
	echo "Find Cygwin System..."
    [ -r $HOME/.cygwinbashrc ] && source $HOME/.cygwinbashrc
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	echo "Find MingW32 System..."
    [ -r $HOME/.cygwinbashrc ] && source $HOME/.cygwinbashrc
fi

