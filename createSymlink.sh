# some code is from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh with slightly modification
dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
folders="bashscript zshscript vim74lua linux screen tmux misc term direnv"    # list of folders that have dot files

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
[ ! -d $olddir ] && mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# https://stackoverflow.com/questions/18641864/git-bash-shell-fails-to-create-symbolic-links#answer-25394801
windows() { [[ -n "$WINDIR" ]]; }
link() {
    if windows; then
        target=`cygpath -w ${2}`
        dest=`cygpath -w ${1}`
        # cmd just cannot work right!!!
        sudo powershell -Command "cmd /C \"mklink /D \"$target\" \"$dest\"\""
    else
        ln -s "$1" "$2"
    fi
}

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for folder in $folders; do
    if [ -d $folder ] ; then
        cd $dir/$folder
        for d in $(find . -maxdepth 1 -path './.*' -prune) ; do
            if [ -L ~/$d ] ; then
                rm ~/$d
            else 
                if [ -e ~/$d ]; then
                    cp -rf ~/$d $olddir
                    rm -rf ~/$d
                fi
            fi

            if [ "${1}" = 'nosymlink' ]; then
                if [ -d ${d} ]; then
                    # Process .dotfolder, currently only .vim, TODO: extend it if there's later needs
                    :
                elif  [[ "$(basename ${d})" =~ ^(.bashrc|.bash_profile|.zshrc)$ ]]; then
                    echo "Create wrapper .dotfiles for ${d}"
                    printf "source \$HOME/.dotfiles/${folder}/${d}" > '__${d}'
                    mv -f '__${d}' ~/${d}
                else
                    echo "Overwrite $d"
                    cat "$HOME/.dotfiles/${folder}/${d}" > $HOME/${d}
                fi
            else
                echo "Creating symlink for $d"
                link $dir/$folder/$d ~/$d
            fi
        done
        cd $dir
    fi
done

# link XDG_CONFIG_HOME related
# Initiate .config if not exists
[ -z $XDG_CONFIG_HOME ] && XDG_CONFIG_HOME="$HOME/.config"
 
__link_xdg_config() {
    [ ! -d $XDG_CONFIG_HOME/$3 ] && mkdir -p -- $XDG_CONFIG_HOME/$3
    [ -L $XDG_CONFIG_HOME/$1 ] && rm $XDG_CONFIG_HOME/$1
    [ -d $XDG_CONFIG_HOME/$1 ] && mv $XDG_CONFIG_HOME/$1 $XDG_CONFIG_HOME/$1.old
    echo "Creating xdg symlink for $1"
    link $dir/$2 $XDG_CONFIG_HOME/$1
}

# Create nvim's symlink
__link_xdg_config 'nvim' 'neovim/nvim' ''
# Create nix's symlink
__link_xdg_config 'nixpkgs' 'nix/nixpkgs' ''
__link_xdg_config 'ranger' 'ranger' ''
# __link_xdg_config 'autokey' 'linux/autokey' ''

