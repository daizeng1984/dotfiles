"Behave like windows
source $VIMRUNTIME/mswin.vim
" behave mswin 
" behave is removed. see https://neovim.io/doc/user/news-0.10.html
set selection=exclusive
set selectmode=mouse,key
set mousemodel=popup
set keymodel=startsel,stopsel

" Check if a cli is there 
function! CliInstalled(cond) 
    return system("if ! type " . a:cond . " > /dev/null 2>&1; then echo '0'; else echo '1'; fi")
endfunction

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/nvim/plugged')

" color scheme
" https://colorswat.ch/vim/list?p=3&bg=dark&cat=all
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'KeitaNakamura/neodark.vim'
if !has('nvim')
Plug 'junegunn/seoul256.vim'
else
Plug 'daizeng1984/seoul256.nvim'
"Plug 'folke/tokyonight.nvim'
"Plug 'ellisonleao/gruvbox.nvim'
endif


" Whether to use deoplete + lsp or coc.nvim
let g:use_native_lsp = 0 " :(WIP and requries higher neovim version 0.6.1 etc.
let g:use_python3_plugins = 1
let g:has_jq = 0

if CliInstalled('jq')
    let g:has_jq = 1
endif

if !has('nvim')
    let g:use_native_lsp = 0
endif


" Complete plugins only for nvim
if g:use_native_lsp
    Plug 'neovim/nvim-lspconfig'
    " Grammars
    Plug 'w0rp/ale'
    " Autocomplete
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'
else
    let g:coc_disable_startup_warning = 1
    if CliInstalled('node')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif
endif


Plug 'ap/vim-buftabline'


" Python plugins
if has('python3') && g:use_python3_plugins
    " ipython
    if CliInstalled('ipython')
        Plug 'jpalardy/vim-slime', { 'for': ['python', 'markdown'] }
        Plug 'hanschen/vim-ipython-cell', { 'for': ['python', 'markdown'] }
        " jupyter notebook
        if CliInstalled('jupytext')
            Plug 'goerz/jupytext.vim' " conda install jupytext Install notedown to write ipynb in vim
        endif
    endif

    " snippet
    Plug 'SirVer/ultisnips'

    " Stop the complaining due to taskwarrior not installed
    if CliInstalled('task')
        Plug 'tbabej/taskwiki', {'for': ['markdown'], 'on': 'VimwikiIndex', 'do': 'pip install --upgrade git+git://github.com/tbabej/tasklib@develop' }
        Plug 'blindFS/vim-taskwarrior', {'for': ['markdown'], 'on': 'VimwikiIndex' }  " For grid view of taskwiki
    endif
    
    " My own stuff
    " Plug 'daizeng1984/my-worddoctor' " My own python plugin currently in test
    " Plug 'daizeng1984/vim-snip-and-paste'
endif


Plug 'Shougo/echodoc.vim'
Plug 'airblade/vim-rooter' " User :Rooter to do it manually
Plug 'honza/vim-snippets'
" Disable for languageclient-neovim
" if CliInstalled('eclipse')
" Plug 'dansomething/vim-eclim', { 'for' : ['java', 'scala']} " Annoying 'unable to determine the project ...' for file like html
" else
" Plug 'artur-shaik/vim-javacomplete2', { 'for' : ['java']}
" endif
" Disable for languageclient-neovim

Plug 'junegunn/fzf', { 'dir': $DOTFILE_LOCAL_PREFIX . '/lib/miniconda/share/fzf'} " some time this cause issue if you install fzf in different source e.g. brew install. To solve you need to brew reinstall
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-emoji'
" Plug 'jlanzarotta/bufexplorer'
Plug 'vim-scripts/wombat256.vim'
" Plug 'mhinz/vim-grepper'
Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive' " -, dv, U, cc, cA, p, q
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dadbod' " db, keep it here to try
" Plug 'tpope/vim-unimpaired' " [,]q for quickfix and [l for loclist
Plug 'tpope/vim-eunuch' "Rename, Delete, Sudo etc.
Plug 'tpope/vim-commentary' " replace tcomment
" Plug 'mattn/emmet-vim' " c-y ,then type this>is>tag ---> <this> <is> <tag> ... </.... or type insert mode and c-y , here's the cheatsheet https://docs.emmet.io/cheat-sheet/
Plug 'mattn/webapi-vim' " Gist dependencies
" Plug 'vim-scripts/Gist.vim' "Gist but before git config --global github.user Username
Plug 'ruanyl/vim-gh-line' " get github links
Plug 'vim-scripts/BufOnly.vim' " BufOnly to close all but this
"SLOW! Plug 'sheerun/vim-polyglot' " One to rule them all, one to find them, one to bring them all and in the darkness bind them.
Plug 'vim-scripts/LargeFile' " Load largefile without syntax etc. burden
Plug 'AndrewRadev/linediff.vim' " :Linediff for two blocks
Plug 'will133/vim-dirdiff' "DirDiff
Plug 'djoshea/vim-autoread' " Auto reload when changed by other app
"SLOW! Plug 'kshenoy/vim-signature' " Added color vis for marks
Plug 'bronson/vim-visual-star-search' " Case sensitive * in virtual mode
" Plug 'tpope/vim-ragtag' " complete words with tag! :help ragtag
Plug 'alvan/vim-closetag'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'antoinemadec/FixCursorHold.nvim' " https://github.com/antoinemadec/FixCursorHold.nvim
" nerdtree is too slow!!!

" Deplete companions
Plug 'justinj/vim-react-snippets'
" Plug 'neomake/neomake'

" Markdown plugins
Plug 'dhruvasagar/vim-table-mode', {'for': ['markdown'] } " for better table in markdown, :TableModeToggle and || to start, you can even tableize the csv style entries and do table formula, delete column localleader=\\
Plug 'daizeng1984/vim-buffer-history' " for better file jump from dhruvasagar/vim-buffer-history
Plug 'mattn/calendar-vim', {'for': ['markdown'] } " Good to have a calendar view
" Plug 'vimwiki/vimwiki', {'for': ['markdown'] }  " Great tool! I think it's better than org mode I tried
Plug 'vim-scripts/utl.vim', {'for': ['markdown'] } " Utl help open URL in netrw
Plug 'powerman/vim-plugin-AnsiEsc', {'for': ['markdown'] }  " allow colorful chart in taskwiki
Plug 'jxnblk/vim-mdx-js' " MDX syntax
Plug 'jamessan/vim-gnupg' " Encryptize transparently error informations
" Plug 'rhysd/nyaovim-markdown-preview', {'for': ['markdown'] }  " Nayovim GUI preview for markdown
" Plug 'tybenz/vimdeck' " Presentation tool

" Python
Plug 'nathanaelkane/vim-indent-guides' " Indention guide

Plug 'drmikehenry/vim-headerguard'
Plug 'ericcurtin/CurtineIncSw.vim'
"Plug 'ramele/agrep'
"Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
" Plug 'itchyny/calendar.vim' " Interesting to try out, Google Calendar in vim!
" Plug 'github/copilot.vim'

" Find & Replace
" if has('nvim')
"     Plug 'nvim-lua/plenary.nvim'
"     Plug 'windwp/nvim-spectre'
" else
Plug 'brooth/far.vim'
" endif
" Add plugins to &runtimepath
call plug#end()

