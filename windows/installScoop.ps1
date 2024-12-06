sudo scoop install 7zip openssh --global
#scoop install aria2 curl grep sed less touch
# scoop install python ruby go perl
scoop install vcredist
scoop install firefox windows-terminal flameshot
scoop install fzf dust zoxide ag ripgrep bat zip unzip tar fd neovim

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# fzf in native win git bash
echo "PROMPT_COMMAND='history -a'" | Add-Content ~/.bash_profile -NoNewLine -Encoding ascii

# 7zip context menu
start "$env:HOMEPATH/scoop/apps/7zip/current/install-context.reg"

# alacritty
scoop bucket add extras
scoop install extras/alacritty
scoop install extras/vcredist2022
# scoop install extras/winaero-tweaker # doesn't install on win arm but prbly run okay and need further look
# scoop install extras/audacious not arm64
scoop install extras/foobar2000
# open this once to set it as default image previewer, much better!
scoop install extras/imageglass
# scoop install extras/flow-launcher buggy and not arm64
scoop install extras/powertoys
New-Item -ItemType Directory -Path "$env:HOMEPATH/AppData/Roaming/alacritty/"
Copy-Item "$env:HOMEPATH/.dotfiles/windows/alacritty.yml" -Destination "$env:HOMEPATH/AppData/Roaming/alacritty/alacritty.yml"
Copy-Item "$env:HOMEPATH/.dotfiles/windows/alacritty.toml" -Destination "$env:HOMEPATH/AppData/Roaming/alacritty/alacritty.toml"

# fonts
scoop bucket add nerd-fonts
scoop install nerd-fonts/UbuntuMono-NF

# autohotkey
scoop bucket add versions
$startup = [environment]::getfolderpath("Startup")
sudo . "`"$(Convert-Path -Path '~/.dotfiles/windows/create_ahk_task.ps1')`""

# flux (startup)
# $WshShell = New-Object -comObject WScript.Shell
# $Shortcut = $WshShell.CreateShortcut("$startup\flux.lnk")
# $Shortcut.TargetPath = "$env:HOMEPATH/scoop/apps/flux/current/flux.exe"
# $Shortcut.Save()

# copy settings.json to terminal
start "$env:HOMEPATH/scoop/apps/windows-terminal/current/WindowsTerminal.exe"
Copy-Item "$env:HOMEPATH/.dotfiles/windows/terminal-settings.json" -Destination "$env:HOMEPATH/scoop/apps/windows-terminal/current/settings/settings.json"

# hostname
sudo Rename-Computer -NewName "windesktop"
# wmic.exe computersystem where name="%computername%" call rename name="windesktop"

# file explorer
sudo reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /v FolderType /t REG_SZ /d NotSpecified /f
# disable lock
# sudo reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableLockWorkstation /t REG_DWORD /d 1 /f
# disable win key
# sudo reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWinKeys /t REG_DWORD /d 1 /f

# install wsl
sudo wsl --install

# install apple fonts
sudo "$env:HOMEPATH/.dotfiles/windows/installFont.ps1"

# restart
