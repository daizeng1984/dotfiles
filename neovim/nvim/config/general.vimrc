" They said this is not necessary in neovim
set backspace=indent,eol,start
set nocp
set ww=b,s,<,>,[,]
set hlsearch
set ignorecase
set smartcase
set number
set ruler		" show the cursor position all the time
set cursorline
"Set tab == 4spaces
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set smartindent
set so=5 " scroll lines above/below cursor
set sidescrolloff=5
set lazyredraw
set magic " for regular expressions
set autoread
" clipboard
set clipboard=unnamedplus
" set completeopt=longest,menuone,preview

" Add rtp
set runtimepath+=$XDG_CONFIG_HOME/nvim/runtime

"Set textwidth to avoid auto wrapping (insert new line)
set textwidth=0
"set shell=/bin/bash

"Fix ctrl-q
silent !stty -ixon > /dev/null 2>/dev/null

"Display key command
set showcmd

"Make sure switch buffer wont clear undo
set hidden

" Syntax on always
syntax on
syntax enable

" Backup and undo https://www.gregjs.com/vim/2016/do-yourself-a-favor-and-modularize-your-vimrc-init-vim/
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/backup
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup
endif
set undodir=~/.config/nvim/undodir
set undofile
set undolevels=100
set undoreload=1000

" I don't like mouse in VIM
"if has('mouse')
"  set mouse=a
"endif


" Session: Ignore keymapping etc when saving or load session
set ssop-=options " do not store global and local values in a session 
set ssop-=folds " do not store folds

"The theme and font setting
colorscheme desert
"let g:GuiFont="Droid Sans Mono:h13"

"Fold for syntax ( { [
set foldmethod=syntax
set foldlevel=100

set nrformats-=octal

set ttimeout
set ttimeoutlen=100


" Check filetype and apply plugin
filetype plugin on
" Unix as standard file type
set ffs=unix,dos,mac
" Always utf8
set termencoding=utf-8
" set encoding=utf-8
set fileencoding=utf-8

"GLSL syntax
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.frag.glsl,*.vert.glsl set filetype=glsl 
" detect .md as markdown instead of modula-2
autocmd BufNewFile,BufReadPost *.md set filetype=
" stop highlighting of underscores in markdown files
autocmd BufNewFile,BufRead,BufEnter *.md,*.markdown :syntax match markdownIgnore "_"


" TODO?
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif





