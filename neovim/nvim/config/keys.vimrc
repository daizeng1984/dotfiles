let mapleader = ","

" Sudo
nnoremap <silent> <leader>W :w !sudo tee > /dev/null %<CR>

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
map <silent> <leader>we :Fern . -drawer -reveal=%<CR>

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

" Ctrl-e for ultisnips or neosnippet
if has_key(g:plugs, 'coc.nvim')
    imap <C-e> <Plug>(coc-snippets-expand)
elseif has_key(g:plugs, 'neosnippet.vim')
    imap <C-e> <Plug>(neosnippet_expand_or_jump)
endif

" Ctrl-A/X in mswin
noremap <C-_>= <C-A>
noremap <C-_>- <C-X>

" AsciiEmoji
nnoremap <leader>em :AsciiEmoji()<CR>
nnoremap <leader>ej :FzfEmoji<CR>


" Emmet bug temp solution http://vim.wikia.com/wiki/Delete_a_pair_of_XML/HTML_tags
noremap <C-Y>k vat<Esc>da>`<da> 

" Copy to nc
unmap <C-y>
vnoremap <C-y> :call CopyToNetCat()<CR>
if !has('clipboard')
    " if display available?
    " vnoremap <C-c> :w !xsel -i -b<CR>
    " nnoremap <C-v> :r!xsel -b<CR>
    " TODO: select mode
    vnoremap <C-c> :call CopyToTmpBuffer()<CR>
    nnoremap <C-v> :call PasteFromTmpBuffer()<CR>
    inoremap <C-v> <Esc>:call PasteFromTmpBuffer()<CR>a
endif

" LSP
if g:use_native_lsp
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
elseif has_key(g:plugs, 'coc.nvim')
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
endif

" WSL
if system('uname -r') =~ "Microsoft"
" if has('wsl')
    augroup Yank
        autocmd!
        autocmd TextYankPost * :call system('clip.exe ',@")
    augroup END
endif

" Fugitive
nnoremap <expr> D &buftype ==# 'quickfix' ? "yaw:cclose\<CR>:Gvdiffsplit \<C-R>0\<CR>" : 'D'
nnoremap <leader>gl :0Gclog -- %<CR>
nnoremap <leader>D :call DiffCurrentQuickfixEntry()<CR>
autocmd BufReadPost fugitive://* set bufhidden=delete

" switch
nmap <leader>wo :call CurtineIncSw()<CR>

" format json
if g:has_jq
    nnoremap <leader>jj :%!jq .<CR>
    nnoremap <leader>jr :%!jq -c . <CR>
else
    nnoremap <leader>jj :%!python -m json.tool<CR>
    nnoremap <leader>jr :%delete \| 0put =json_encode(json_decode(@@))<CR>
endif
