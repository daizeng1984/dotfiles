if [[ `id -u` != 0 ]]; then
    echo "Run: script with sudo!"
    exit 1
fi

change_to_shell="$(which ${1})"

echo "${change_to_shell}" >> /etc/shells

chsh ${2} #username

echo "Please logout/login your environment if necessary"

# Nonroot way (.bash_profile)
# export SHELL=`which zsh`
# [ -z "$ZSH_VERSION" ] && exec "$SHELL" -l

