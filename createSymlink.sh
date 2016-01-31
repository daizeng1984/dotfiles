# some code is from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh with slightly modification
dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
folders="bashscript zshscript vim74lua"    # list of folders that have dot files

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
[ ! -d $olddir ] && mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for folder in $folders; do
    if [ -d $folder ] ; then
        cd $dir/$folder
        for d in $(find . -maxdepth 1 -path './*' -prune) ; do
            if [ -L ~/$d ] ; then
                rm ~/$d
            else
                mv -f ~/$d $olddir
            fi

            echo "Creating symlink for $d"
            ln -s $dir/$folder/$d ~/$d
        done
        cd $dir
    fi
done
