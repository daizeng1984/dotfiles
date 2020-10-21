set backspace=indent,eol,start
set nocp
set ww=b,s,<,>,[,]
"set shell=/bin/bash

" Undo
set undodir=~/.vim/.undodir
set undofile
set undolevels=100
set undoreload=1000
set backupdir=~/.vim/backup

"Help stupid windows vim to get the path
if has('win32') || has('win64') || has('win32unix')
    set runtimepath=$VIM/vimfiles,$HOME/.dotfiles/vim74lua/.vim,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.dotfiles/vim74lua/.vim/after
    set shell=$COMSPEC " Sorry, Windows Users
    set backupdir=$HOME/.dotfiles/vim74lua/.vim/tmp " Sorry, Windows User has to create their own folder
    set undodir=$HOME/.dotfiles/vim74lua/.vim/tmp
else
    "Backup
endif

"Fix ctrl-q
silent !stty -ixon > /dev/null 2>/dev/null

"Display key command
set showcmd

"Make sure switch buffer wont clear undo
set hidden

"Disable scratch preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"Taghighlight set for external library
"Map f10 to update the lib highlight
"map <C-F10> :Pushd .<CR> :cd ~/.vim/tags/ <CR> :UpdateTypesFile <CR> :Popd <CR> :!cp ~/.vim/tags/taghl_config.txt . <CR>

"Easytags configuration
"let g:easytags_always_enabled = 1
let g:easytags_on_cursorhold = 0

"Easy select and replace
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction
" Start the find and replace command across the entire file
let mapleader = ","
vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/

"Check filetype and apply plugin
filetype plugin on
"Syntax highlight on
syntax on

"Line number
set number

"Set tab == 4spaces
set expandtab
set tabstop=4
set shiftwidth=4


"Set textwidth to avoid auto wrapping (insert new line)
set textwidth=0


"Ignore keymapping etc when saving or load session
set ssop-=options " do not store global and local values in a session 
set ssop-=folds " do not store folds

"Search case insensitive and highlight them
set hlsearch
set ignorecase
set smartcase

"Clean swp files for current folder
"The theme and font setting
colorscheme wombat256mod

set t_Co=256
" let g:airline_powerline_fonts = 0
let g:airline_theme='wombat'
set laststatus=2



"VIMRC editing and autoupdate
"Set mapleader
let mapleader = ","
"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

"Fold for syntax ( { [
set foldmethod=syntax
set foldlevel=100

"WinManager
" let g:winManagerWindowLayout='TagList'
" map <silent> <leader>wm :WMToggle<CR>
map <silent> <leader>we :Explore<CR>

"BuffExplorer
nmap <unique> <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
map <silent> <leader>wb :BufExplorer<CR>
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavVim = 1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='mru'
let g:bufExplorerSplitRight=0
let g:bufExplorerSplitVertical=0
let g:bufExplorerSplitVertSize = 30
"let g:bufExplorerUseCurrentWindow=1
"autocmd BufWinEnter \[Buf\ List\] setl

"FuzzyFinder
"Find file
function! CliInstalled(cond) 
    return system("if ! type " . a:cond . " > /dev/null 2>&1; then echo '0'; else echo '1'; fi")
endfunction

if CliInstalled('fzf') 
    let g:fzf_layout = { 'up': '~50%' }
    map <silent> <leader>wf :FZF<CR>
    if CliInstalled('ag')
        let $FZF_DEFAULT_COMMAND = 'ag --hidden -p ~/.dotfile/neovim/nvim/.agignore -l -g ""'
    else
        let $FZF_DEFAULT_COMMAND = 'find . -type f'
    endif
else
    map <silent> <leader>wf :FufCoverageFile<CR>
    map <silent> <leader>w, :FufRenewCache<CR>
    "Ignore binary files
    " let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|class|cache)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
    "Grab to ignore .gitignore mostly from http://stackoverflow.com/questions/4132955/is-there-an-easy-way-to-exclude-files-for-which-fuzzyfinder-searches#answer-17322862
    let ignorefiles = [ $HOME . "/.vim/.gitignore", ".gitignore" ]
    let exclude_vcs = '\.(o|exe|dll|bak|orig|swp|class|cache)$|(^|[/\\])\.(hg|git|bzr|svn|cvs)($|[/\\])'
    let ignore = '\v\~$'
    for ignorefile in ignorefiles

        if filereadable(ignorefile)
            for line in readfile(ignorefile)
                " Rmove empty lines and comment lines
                if match(line, '^\s*$') == -2 && match(line, '^\s*#') == -1
                    let line = substitute(line, '^/', '', '')
                    let line = substitute(line, '\.', '\\.', 'g')
                    let line = substitute(line, '\*', '.*', 'g')
                    let ignore .= '|' . line
                endif
            endfor
        endif

        " Local will override the home folder's .gitignore
        let ignore .= '|' . exclude_vcs
        let g:fuf_coveragefile_exclude = ignore
        let g:fuf_file_exclude = ignore
        let g:fuf_dir_exclude = ignore

    endfor

endif
"Grep
let Grep_Default_Options = '-i -I'
nnoremap <silent> <C-F> :Rgrep<CR>
" Fix Mac issue: xargs illegal options
let s:os = system('uname')
if  s:os =~ 'Darwin'
    let g:Grep_Xargs_Options='-0' 
endif 

"Insert Date
"nmap <F3> "=strftime("%m/%d/%Y")<CR>P
imap <F3> <C-R>=strftime("%m/%d/%Y")<CR>
imap <F4> <C-R>=strftime("%X")<CR>

"Big E
"http://stackoverflow.com/questions/10394707/create-file-inside-new-directory-in-vim-in-one-step
command -nargs=1 E execute('silent! !mkdir -p "$(dirname "<args>")"') <Bar> e <args>

"A switcher for h/cpp file
nnoremap <silent> <A-o> :A<CR>

"Build and run! (only apply for my project)
map <C-F5> :silent! !./build.sh<CR>

"Ctags, create tags in current work directory
"map <C-F12> :silent! !ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .<CR> :UpdateTypesFile <CR>

"Set ctrl j so that it can work with clewn better
let g:C_Ctrl_j='off'

"This is for latex
"set for win32
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'

"Load the example configure file.
"source $VIMRUNTIME/vimrc_example.vim
"Behave like windows
source $VIMRUNTIME/mswin.vim
behave mswin

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType c,cc setlocal omnifunc=ccomplete#Complete
" Turn on default omnifunc for Eclimd
filetype plugin on 
setlocal omnifunc=syntaxcomplete#Complete


" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" Add eclimd support
let g:EclimCompletionMethod = 'omnifunc'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.java = '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

map <silent> <leader>ji :JavaImport<CR>
map <silent> <leader>jc :JavaDocComment<CR>
map <F5> :Java %<CR>
map <C-]> :JavaSearch<CR>

nmap <leader>d :diffupdate<CR>zm
nmap <leader>dp :.diffput<CR>:diffupdate<CR>zm
nmap <leader>dg :diffget<CR>:diffupdate<CR>zm

" SSH paste
map <silent> <leader>p :r /tmp/sshclipboard.txt<CR>

function! Get_Escaped_Selection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - 2]
    let lines[0] = lines[0][column_start - 1:]
    let newlines = []
    for row in lines
        call add(newlines, row)
    endfor
    return join(newlines, "\n")
endfunction

function CopyToNetCat() range
    let selected_lines = Get_Escaped_Selection()
    echo system('printf "%s" '.shellescape(selected_lines).' | nc localhost 2000')
endfunction

" Copy to nc
unmap <C-y>
vnoremap <C-y> :call CopyToNetCat()<CR>
