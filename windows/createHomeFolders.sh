winhome=$(cmd.exe /c 'echo %USERPROFILE%')
winhome=$(echo -E "$winhome" | sed 's/\\/\\\\/g')
winhome=`wslpath -u $winhome`
winhome=$(echo "$winhome" | tr -d '\r')
__tmp=`pwd`
cd $HOME
ln -sf $winhome/Downloads Downloads
ln -sf $winhome/Music Music
ln -sf $winhome/Videos Videos
ln -sf $winhome/OneDrive/Desktop Desktop
ln -sf $winhome/OneDrive/Pictures Pictures
ln -sf $winhome/OneDrive/Documents Documents
ln -sf $winhome WinHome
cd $__tmp
