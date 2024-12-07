# vim/neovim
source $HOME/.dotfiles/neovim/configNeovim.sh

# tmux
source $HOME/.dotfiles/tmux/configTmux.sh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# TODO: fzf recipe is not complete
mkdir -p $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin
wget https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim -P $HOME/.dotfiles/.local/lib/miniconda/share/fzf/plugin

# gnupg (use x11 pinentry for https://github.com/jamessan/vim-gnupg/issues/32)
echo "max-cache-ttl 34560000\ndefault-cache-ttl 34560000\npinentry-program /bin/pinentry-x11" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent # which automatically restart in wsl
# gpg-agent --daemon
