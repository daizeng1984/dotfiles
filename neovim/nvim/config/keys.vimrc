let mapleader = ","

"Insert Date
imap <F3> <C-R>=strftime("%m/%d/%Y")<CR>
imap <F4> <C-R>=strftime("%X")<CR>

" Eclim, TODO: make a switch
map <silent> <leader>ji :JavaImport<CR>
map <silent> <leader>jc :JavaDocComment<CR>
map <F5> :Java %<CR>
map <C-]> :JavaSearch<CR>

" Clear swp files
map <silent> <leader>wp :!find . -name ".*.*.swp" <Bar> xargs rm -rf<cr>

"WinManager
" let g:winManagerWindowLayout='TagList'
" map <silent> <leader>wm :WMToggle<CR>
map <silent> <leader>we :Explore<CR>

"BuffExplorer
map <silent> <leader>wb :BufExplorer<CR>

"FuzzyFinder
"Find file
map <silent> <leader>wf :FZF --reverse<CR>
map <silent> <leader>w, :?<CR>


" Diff
nmap <leader>d :diffupdate<CR>zm
nmap <leader>dp :.diffput<CR>:diffupdate<CR>zm
nmap <leader>dg :diffget<CR>:diffupdate<CR>zm

" Grep
nnoremap <silent> <C-F> :Rgrep<CR>

" SSH paste
map <silent> <leader>p :r /tmp/sshclipboard.txt<CR>

" Terminal
tnoremap <silent> <Esc> <C-\><C-n><bar>:q<CR>
map <silent> <leader>tt :call TermEnter()<CR>
