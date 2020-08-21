let mapleader = ","


" IPython
map <silent> <leader>pr <Plug>(IPy-Run)
map <silent> <leader>p<Tab> <Plug>(IPy-Complete)
map <silent> <leader>p? <Plug>(IPy-WordObjInfo)
map <silent> <leader>ps <Plug>(IPy-Interrupt)
map <silent> <leader>pq <Plug>(IPy-Terminate)
map <silent> <leader>pp :call IPyRun('print(<C-R><C-W>)')<CR>

" Buffer switch
map <silent> <leader>bt :enew<CR>
map <silent> <C-h> :bprevious<CR>
map <silent> <C-l> :bnext<CR>
nmap <silent> H <Plug>(buffer-history-back)
nmap <silent> L <Plug>(buffer-history-forward)
map <silent> <leader>q :bp <BAR> bd # <CR>

" Buf Only
map <silent> <leader>bq :BufOnly <CR>

" Clear swp files
map <silent> <leader>wp :!find . -name ".*.*.swp" <Bar> xargs rm -rf<cr>

"WinManager
" let g:winManagerWindowLayout='TagList'
" map <silent> <leader>wm :WMToggle<CR>
map <silent> <leader>we :NERDTreeCWD <CR><C-W><C-P>:NERDTreeFind<CR>
map <silent> <leader>wd :NERDShowDir .<CR>

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
" nnoremap <silent> <leader>fg :Rgrep<CR>
map <C-f> :Rg <C-r><C-w><CR>
" vim-grepper
nmap <leader>fg :Grepper -stop<CR>:Grepper -tool ag -cword<CR>
vmap <leader>ff <plug>(GrepperOperator)
map <leader>ff :Grepper -stop<CR>:Grepper -tool rg -cword<CR>

" SSH paste
map <silent> <leader>sp :r /tmp/sshclipboard.txt<CR>

" Terminal
" tnoremap <silent> <Esc> <C-\><C-n><bar>:q<CR>
" map <silent> <leader>TT :call TermEnter()<CR> I seldom use it and confusing when using tmux...

" Vim Wiki
imap <C-D> <Plug>VimwikiIncreaseLvlSingleItem
nmap <Space> <Plug>VimwikiToggleListItem
imap <F4> <Esc>:call MyInsertCalDate()<CR>

" Far, find selection in virtual mode
vmap <C-R> y:Farp<CR><C-R>0<CR>

" Ctrl-A/X in mswin
noremap <C-_>= <C-A>
noremap <C-_>- <C-X>

" Tcomment
vmap gb <C-_>b

" AsciiEmoji
nnoremap <leader>em :<C-U>call AsciiEmoji()<CR>:<C-U>Denite menu<CR>
nnoremap <leader>ea :<C-U>%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>
nnoremap <leader>ej :FzfEmoji<CR>


" Emmet bug temp solution http://vim.wikia.com/wiki/Delete_a_pair_of_XML/HTML_tags
noremap <C-Y>k vat<Esc>da>`<da> 

" LanguageClient
" nnoremap <F4> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <C-K> :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Copy to nc
vmap <C-y> :call CopyToNetCat()<CR>

" Eclim, TODO: enable in the future?
" " Jump to definition
" autocmd FileType java map <buffer> <C-]> :JavaSearch<CR>
" autocmd FileType javascript map <buffer> <C-]> :TernDef<CR>
" autocmd FileType python map <buffer> <C-]> :call IPyRun('print(<C-R><C-W>)')<CR>
"
" " Find Refs
" autocmd FileType javascript map <buffer> <leader><C-F> :TernRefs<CR>
" map <silent> <leader>ji :JavaImport<CR>
" map <silent> <leader>jc :JavaDocComment<CR>
" map <silent> <leader>jr<F5>:Java %<CR>
" "map <leader>j<C-]> :JavaSearch<CR>
" map <silent> <leader>jdb :call MyEclimdJavaDebug()<CR>
" map <silent> <leader>j<F9> :JavaDebugBreakpointToggle<CR>:JavaDebugStatus<CR>
" map <silent> <leader>j<F8> :JavaDebugStep over <CR> :JavaDebugStatus<CR>
" map <silent> <leader>j<F7> :JavaDebugStep into <CR> :JavaDebugStatus<CR>

" WSL
if system('uname -r') =~ "Microsoft"
" if has('wsl')
    augroup Yank
        autocmd!
        autocmd TextYankPost * :call system('clip.exe ',@")
    augroup END
endif
