"Behave like windows
source $VIMRUNTIME/mswin.vim
behave mswin


" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-rooter'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dansomething/vim-eclim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " some time this cause issue if you install fzf in different source e.g. brew install. To solve you need to brew reinstall
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jlanzarotta/bufexplorer'
Plug 'wombat256.vim'
" Plug 'mhinz/vim-grepper'
Plug 'danro/rename.vim'
Plug 'grep.vim'
Plug 'airblade/vim-gitgutter' " Show git diff
Plug 'rhysd/conflict-marker.vim'

" Deplete companions
Plug 'zchee/deoplete-jedi' " Python
Plug 'artur-shaik/vim-javacomplete2' "Java
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' } "Javascript
Plug 'mhartington/nvim-typescript' " should do npm install -g typescript
" Plug 'Quramy/tsuquyomi'
Plug 'HerringtonDarkholme/yats.vim' " typescript syntax

Plug 'daizeng1984/my-worddoctor' " My own python plugin currently in test
"Plug 'ramele/agrep'
"Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
"Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }

" Add plugins to &runtimepath
call plug#end()

" Plugin setting

" Deoplete

autocmd FileType java setlocal omnifunc=javacomplete#Complete " Java Complete 2, with eclim enable this can be disabled
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" Jedi make it easier! autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType javascript setlocal omnifunc=tern#Complete

let g:deoplete#enable_at_startup = 1

let g:deoplete#omni_patterns = {}
" When Eclim is available, we will use eclim!
" let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#omni_patterns.java = '\%(\h\w*\|)\)\.\w*'
let g:deoplete#omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:deoplete#omni_patterns.scala = '[^. *\t]\.\w*\|: [A-Z]\w*'
" let g:deoplete#omni_patterns.typescript = '[^. \t0-9]\.([a-zA-Z_]\w*)?'

let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#auto_completion_start_length = 2
let g:deoplete#file#enable_buffer_path = 1


" let g:deoplete#enable_debug = 1
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', './deoplete.log')

" Add eclimd support
let g:EclimCompletionMethod = 'omnifunc'

" Fuzzy Find for neovim
" TODO: filter file type e.g. binary file

" - down / up / left / right
let g:fzf_layout = { 'up': '~50%' }
let $FZF_DEFAULT_COMMAND = 'ag --hidden --path-to-ignore ~/.config/nvim/.agignore -l -g ""'

" In Neovim, you can set up fzf window using a Vim command

" Customize fzf colors to match your color scheme

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.


" BufExplorer
let g:bufExplorerDisableDefaultKeyMapping=1

" VimAirline
set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Wombat!
colorscheme wombat256mod

" Grepper, hard to config for my use search(pattern, folder, filepattern), and a few segment fault suspects
" let g:grepper = {
"       \ 'tools': ['grep', 'git', 'ag', 'vimgrep'] }


" Deoplete companion Language
" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ ]

" Scala
let g:scala_scaladoc_indent = 1

" whD
let g:deoplete#sources#whd#learning_texts = ['${HOME}/obama08.txt', '/']
