# some code is from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh with slightly modification
dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
folders="bashscript zshscript vim74lua gitconfig screen tmux tern"    # list of folders that have dot files

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
        for d in $(find . -maxdepth 1 -path './.*' -prune) ; do
            if [ -L ~/$d ] ; then
                rm ~/$d
            else 
				if [ -e ~/$d ]; then
					cp -rf ~/$d $olddir
					rm -rf ~/$d
				fi
            fi

			if [[ ${1} == 'nosymlink' ]]; then
				if [[ -d ${d} ]]; then
					# Process .dotfolder, currently only .vim, TODO: extend it if there's later needs
					if [[ ${d} != './.vim' ]]; then
						# Better let gvim handle this
						# printf "if has('win32') || has('win64')\n\tset runtimepath=" + $(cygpath -wa ${dir}/${folder}/${d}) + "\nendif\n" > 
						echo "Cannot support dot folder: ${d}"
					fi
				else
					echo "Create wrapper .dotfiles for ${d}"
					printf "source \$HOME/.dotfiles/${folder}/${d}" > '__${d}'
					mv -f '__${d}' ~/${d}
				fi
			else
				echo "Creating symlink for $d"
				ln -s $dir/$folder/$d ~/$d
			fi
        done
        cd $dir
    fi
done

