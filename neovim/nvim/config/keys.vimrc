let mapleader = ","

" Eclim, TODO: make a switch
map <silent> <leader>ji :JavaImport<CR>
map <silent> <leader>jc :JavaDocComment<CR>
map <F5> :Java %<CR>
map <C-]> :JavaSearch<CR>
map <silent> <leader>jdb :call MyEclimdJavaDebug()<CR>
map <F9> :JavaDebugBreakpointToggle<CR>:JavaDebugStatus<CR>
map <F8> :JavaDebugStep over <CR> :JavaDebugStatus<CR>
map <F7> :JavaDebugStep into <CR> :JavaDebugStatus<CR>

" Buffer switch
map <silent> <leader>bt :enew<CR>
map <silent> <C-h> :bprevious<CR>
map <silent> <C-l> :bnext<CR>
map <silent> <leader>q :bp <BAR> bd # <CR>

" Buf Only
map <silent> <leader>bq :BufOnly <CR>

" Clear swp files
map <silent> <leader>wp :!find . -name ".*.*.swp" <Bar> xargs rm -rf<cr>

"WinManager
" let g:winManagerWindowLayout='TagList'
" map <silent> <leader>wm :WMToggle<CR>
map <silent> <leader>we :Explore<CR>

"BuffExplorer
" map <silent> <leader>wb :BufExplorer<CR>

"FuzzyFinder
"Find file
imap <C-L> <plug>(fzf-complete-line)
imap <C-T> <plug>(fzf-complete-file)
map <silent> <leader>fd :FzfDiff<CR>
map <silent> <leader>fo :call fzf#vim#history()<CR>
map <silent> <leader>wf :FZF --reverse<CR>
map <silent> <leader>w, :?<CR>
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction
map <silent> <leader>wb :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2,
\   'up': '~50%'
\ })<CR>


" Diff
nmap <leader>d :diffupdate<CR>zm
nmap <leader>dp :.diffput<CR>:diffupdate<CR>zm
nmap <leader>dg :diffget<CR>:diffupdate<CR>zm

" Grep
nnoremap <silent> <leader>fg :Rgrep<CR>
map <C-f> :Rg <C-r><C-w>
" Esearch
" Start esearch prompt autofilled with one of g:esearch.use initial patterns
call esearch#map('<leader>ff', 'esearch')
" Start esearch autofilled with a word under the cursor
call esearch#map('<leader>fw', 'esearch-word-under-cursor')

call esearch#out#win#map('t',       'tab')
call esearch#out#win#map('i',       'split')
call esearch#out#win#map('s',       'vsplit')
call esearch#out#win#map('<Enter>', 'open')
call esearch#out#win#map('o',       'open')

"    Open silently (keep focus on the results window)
call esearch#out#win#map('T', 'tab-silent')
call esearch#out#win#map('I', 'split-silent')
call esearch#out#win#map('S', 'vsplit-silent')

"    Move cursor with snapping
call esearch#out#win#map('<C-n>', 'next')
call esearch#out#win#map('<C-j>', 'next-file')
call esearch#out#win#map('<C-p>', 'prev')
call esearch#out#win#map('<C-k>', 'prev-file')

call esearch#cmdline#map('<C-o><C-r>', 'toggle-regex')
call esearch#cmdline#map('<C-o><C-s>', 'toggle-case')
call esearch#cmdline#map('<C-o><C-w>', 'toggle-word')
call esearch#cmdline#map('<C-o><C-h>', 'cmdline-help')

" SSH paste
map <silent> <leader>sp :r /tmp/sshclipboard.txt<CR>

" Terminal
tnoremap <silent> <Esc> <C-\><C-n><bar>:q<CR>
map <silent> <leader>tt :call TermEnter()<CR>

" Vim Wiki
imap <C-D> <Plug>VimwikiIncreaseLvlSingleItem
nmap <Space> <Plug>VimwikiToggleListItem
imap <F4> <Esc>:call MyInsertCalDate()<CR>
