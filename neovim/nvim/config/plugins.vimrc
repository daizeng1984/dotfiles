"Behave like windows
source $VIMRUNTIME/mswin.vim
behave mswin 
" Check if a cli is there 
function! CliInstalled(cond) 
    return system("if ! type " . a:cond . " > /dev/null 2>&1; then echo '0'; else echo '1'; fi")
endfunction

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim', { 'do': 'pip install typing' }
Plug 'Shougo/echodoc.vim'
Plug 'airblade/vim-rooter' " User :Rooter to do it manually
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Language autocomplete
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Grammars
Plug 'w0rp/ale'

" Disable for languageclient-neovim
" if CliInstalled('eclipse')
" Plug 'dansomething/vim-eclim', { 'for' : ['java', 'scala']} " Annoying 'unable to determine the project ...' for file like html
" else
" Plug 'artur-shaik/vim-javacomplete2', { 'for' : ['java']}
" endif
" Disable for languageclient-neovim

Plug 'junegunn/fzf', { 'dir': $DOTFILE_LOCAL_PREFIX . '/lib/miniconda/share/fzf'} " some time this cause issue if you install fzf in different source e.g. brew install. To solve you need to brew reinstall
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/wombat256.vim'
Plug 'mhinz/vim-grepper'
Plug 'airblade/vim-gitgutter' " Show git diff
Plug 'rhysd/conflict-marker.vim'
set previewheight=20
Plug 'tpope/vim-fugitive' " -, dv, U, cc, cA, p, q
Plug 'gregsexton/gitv' "extension to fugitive
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dadbod' " db, keep it here to try
Plug 'tpope/vim-unimpaired' " [,]q for quickfix and [l for loclist
Plug 'tpope/vim-eunuch' "Rename, Delete, Sudo etc.
Plug 'mattn/emmet-vim' " c-y ,then type this>is>tag ---> <this> <is> <tag> ... </.... or type insert mode and c-y , here's the cheatsheet https://docs.emmet.io/cheat-sheet/
Plug 'tomtom/tcomment_vim' " gc toggle comment
Plug 'mattn/webapi-vim' " Gist dependencies
Plug 'vim-scripts/Gist.vim' "Gist but before git config --global github.user Username
Plug 'vim-scripts/BufOnly.vim' " BufOnly to close all but this
Plug 'sheerun/vim-polyglot' " One to rule them all, one to find them, one to bring them all and in the darkness bind them.
Plug 'vim-scripts/LargeFile' " Load largefile without syntax etc. burden
Plug 'AndrewRadev/linediff.vim' " :Linediff for two blocks
Plug 'brooth/far.vim' " Easier Search&Replace :Far number num <tab>for hint and then vola! Use x to exclude and X to exclude for all, i for include and I for ... Far also works for virtual block!
Plug 'djoshea/vim-autoread' " Auto reload when changed by other app
Plug 'kshenoy/vim-signature' " Added color vis for marks
" Plug 'rking/ag.vim' " Test
Plug 'bronson/vim-visual-star-search' " Case sensitive * in virtual mode
Plug 'tpope/vim-ragtag' " complete words with tag! :help ragtag
Plug 'scrooloose/nerdtree' " NERDtree, even though know it for a while, usually my flow doesn't include much file exploring
Plug 'Xuyuanp/nerdtree-git-plugin' " git flag in NERDTree

" Deplete companions
Plug 'justinj/vim-react-snippets'
Plug 'neomake/neomake'

" Markdown plugins
Plug 'dhruvasagar/vim-table-mode', {'for': ['markdown'] } " for better table in markdown, :TableModeToggle and || to start, you can even tableize the csv style entries and do table formula, delete column localleader=\\
Plug 'daizeng1984/vim-buffer-history' " for better file jump from dhruvasagar/vim-buffer-history
Plug 'mattn/calendar-vim', {'for': ['markdown'] } " Good to have a calendar view
Plug 'vimwiki/vimwiki' " Great tool! I think it's better than org mode I tried
Plug 'vim-scripts/utl.vim', {'for': ['markdown'] } " Utl help open URL in netrw
Plug 'powerman/vim-plugin-AnsiEsc', {'for': ['markdown'] }  " allow colorful chart in taskwiki
Plug 'ap/vim-css-color' " Color for CSS
Plug 'jamessan/vim-gnupg' " Encryptize transparently error informations
" Stop the complaining due to taskwarrior not installed
if CliInstalled('task')
Plug 'tbabej/taskwiki', {'for': ['markdown'], 'on': 'VimwikiIndex', 'do': 'pip install --upgrade git+git://github.com/tbabej/tasklib@develop' }
Plug 'blindFS/vim-taskwarrior', {'for': ['markdown'], 'on': 'VimwikiIndex' }  " For grid view of taskwiki
endif
" Plug 'rhysd/nyaovim-markdown-preview', {'for': ['markdown'] }  " Nayovim GUI preview for markdown
" Plug 'tybenz/vimdeck' " Presentation tool

" Python
Plug 'nathanaelkane/vim-indent-guides' " Indention guide
if CliInstalled('ipython')
Plug 'bfredl/nvim-ipy', { 'do': 'pip install jupyter' } " Jupyter/IPython
endif
if CliInstalled('notedown')
Plug 'goerz/ipynb_notedown.vim', { 'do': 'pip install notedown' } " Install notedown to write ipynb in vim
endif

"Plug 'daizeng1984/my-worddoctor' " My own python plugin currently in test
Plug 'daizeng1984/vim-feeling-lucky', {'do': 'pip install --upgrade google-api-python-client' } " require google api
Plug 'daizeng1984/vim-snip-and-paste'

"Plug 'ramele/agrep'
"Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'itchyny/calendar.vim' " Interesting to try out, Google Calendar in vim!

" Add plugins to &runtimepath
call plug#end()

