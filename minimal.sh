# vim/neovim
source $HOME/.dotfiles/neovim/configNeovim.sh

# tmux
source $HOME/.dotfiles/tmux/configTmux.sh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# TODO: fzf recipe is not complete
mkdir -p $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin
wget https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim -P $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin

# gnupg
echo "max-cache-ttl 34560000\ndefault-cache-ttl 34560000" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
# gpg-agent --daemon
