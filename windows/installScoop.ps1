sudo scoop install 7zip openssh --global
#scoop install aria2 curl grep sed less touch
# scoop install python ruby go perl
scoop install vcredist
scoop install firefox flux autohotkey windows-terminal flameshot
scoop install fzf dust zoxide ag ripgrep bat zip unzip tar fd neovim

# autohotkey
sudo $HOME/scoop/apps/autohotkey/current/setup.exe
$startup = [environment]::getfolderpath("Startup")
Copy-Item "./mac.ahk" -Destination "$startup"
cd $startup
start ./mac.ahk

# copy settings.json to terminal
start "$env:HOMEPATH/scoop/apps/windows-terminal/current/WindowsTerminal.exe"
Copy-Item "$env:HOMEPATH/.dotfiles/windows/terminal-settings.json" -Destination "$env:HOMEPATH/scoop/apps/windows-terminal/current/settings/settings.json"
