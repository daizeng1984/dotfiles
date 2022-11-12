Set-Itemproperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -value 0
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
iwr -useb get.scoop.sh | iex
scoop install sudo
sudo scoop install 7zip git openssh --global
#scoop install aria2 curl grep sed less touch
scoop bucket add extras
scoop update
# scoop install python ruby go perl
scoop install vcredist
scoop install firefox flux autohotkey windows-terminal flameshot
scoop install wget
scoop install fzf dust zoxide ag ripgrep bat direnv zip unzip tar fd

# autohotkey
sudo $HOME/scoop/apps/autohotkey/current/setup.exe
$startup = [environment]::getfolderpath("Startup")
Copy-Item "./mac.ahk" -Destination "$startup"
. ./mac.ahk

# copy settings.json to terminal
Copy-Item "./terminal-settings.json" -Destination "$env:LOCALAPPDATA/Microsoft/Windows Terminal/settings.json"
