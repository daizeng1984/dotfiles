sudo scoop install 7zip openssh --global
#scoop install aria2 curl grep sed less touch
# scoop install python ruby go perl
scoop install vcredist
scoop install firefox flux autohotkey windows-terminal flameshot
scoop install fzf dust zoxide ag ripgrep bat direnv zip unzip tar fd neovim

# autohotkey
sudo $HOME/scoop/apps/autohotkey/current/setup.exe
$startup = [environment]::getfolderpath("Startup")
Copy-Item "./mac.ahk" -Destination "$startup"
. ./mac.ahk

# copy settings.json to terminal
start ~/scoop/apps/windows-terminal/current/WindowsTerminal.exe
Copy-Item "./terminal-settings.json" -Destination "$env:LOCALAPPDATA/Microsoft/Windows Terminal/settings.json"
