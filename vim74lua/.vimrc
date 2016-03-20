set backspace=indent,eol,start
set nocp
set ww=b,s,<,>,[,]

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


"Ctags folder
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpptag
set tags+=~/.vim/tags/gltag
set tags+=~/.vim/tags/iglutag

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
"Set mapleader
let mapleader = ","
map <silent> <leader>wp :!find . -name ".*.*.swp" <Bar> xargs rm -rf<cr>

"The theme and font setting
colorscheme desert
set guifont=Monospace\ 11

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

"GLSL syntax
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.frag.glsl,*.vert.glsl set filetype=glsl 

"Taglist
let Tlist_Show_One_File=1
let TList_Exit_OnlyWindow=1

"CScope
"map <C-F11> :silent! !mkdir -p ./cscopeTmp/ <Bar> cscope -Rbq -f ./cscopeTmp/cscope.out <CR> :cs kill -1<CR> :cs add ./cscopeTmp/cscope.out <CR>
"map <C-F10> :cs add ./cscopeTmp/cscope.out <CR>
"set cscopequickfix=s-,c-,d-,i-,t-,e-

"Autoopen quickfix window
"nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR> :cw<CR>
"nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR> :cw<CR>
"nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR> :cw<CR>
"nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR> :cw<CR>
"nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR> :cw<CR>
"nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR> :cw<CR>
"nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR> :cw<CR>
"nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR> :cw<CR>

"WinManager
let g:winManagerWindowLayout='TagList'
map <silent> <leader>wm :WMToggle<CR>

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
map <silent> <leader>wf :FufCoverageFile<CR>
map <silent> <leader>w, :FufRenewCache<CR>
"Ignore binary files
" let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp|class|cache)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
"Grab to ignore .gitignore mostly from http://stackoverflow.com/questions/4132956/is-there-an-easy-way-to-exclude-files-for-which-fuzzyfinder-searches#answer-17322862
let ignorefiles = [ $HOME . "/.vim/.gitignore", ".gitignore" ]
let exclude_vcs = '\.(o|exe|dll|bak|orig|swp|class|cache)$|(^|[/\\])\.(hg|git|bzr|svn|cvs)($|[/\\])'
let ignore = '\v\~$'
for ignorefile in ignorefiles

    if filereadable(ignorefile)
        for line in readfile(ignorefile)
            " Rmove empty lines and comment lines
            if match(line, '^\s*$') == -1 && match(line, '^\s*#') == -1
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

"A switcher for h/cpp file
nnoremap <silent> <A-o> :A<CR>

"Backup
set backupdir=~/.vim/backup

"Build and run! (only apply for my project)
map <C-F5> :silent! !./build.sh<CR>

"Ctags, create tags in current work directory
map <C-F12> :silent! !ctags -R --c++-kinds=+p --fields=+ialS --extra=+q .<CR> :UpdateTypesFile <CR>

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

map <silent> <leader>j :JavaImport<CR>
map <silent> <leader>d :JavaDocComment<CR>
map <F5> :Java %<CR>

