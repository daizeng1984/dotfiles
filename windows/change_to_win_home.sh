# change wsl to use win's home so that
# backup ssh folder etc.
winusername=`/mnt/c/Windows/System32/cmd.exe "/c" "whoami"`
winusername=$(echo -E $winusername | sed -E s/'^.+\\([^\\]*)$'/'\1'/)
echo "Windows user: $winusername"

sudo sed -i "s/\\/home\\/$(whoami)/\\/mnt\\/c\\/users\\/${winusername//[$'\t\r\n']}/g" /etc/passwd
