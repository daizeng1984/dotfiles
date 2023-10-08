" Plugin setting

" LSP
if g:use_native_lsp
lua <<EOF
require'lspconfig'.bashls.setup{}
-- require'lspconfig'.pyls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.dockerls.setup{}
EOF
" install pyls conda install -y -c conda-forge python-language-server
endif


" EchoDoc
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'
" Always draw the signcolumn.
set signcolumn=yes

" Deoplete
if has_key(g:plugs, 'deoplete.nvim')
" autocmd FileType java setlocal omnifunc=javacomplete#Complete " Java Complete 2, with eclim enable this can be disabled
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" " Jedi make it easier! autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
" autocmd FileType c setlocal omnifunc=ccomplete#Complete
" autocmd FileType javascript setlocal omnifunc=tern#Complete

let g:deoplete#enable_at_startup = 1

" let g:deoplete#omni_patterns = {}
" " When Eclim is available, we will use eclim!
" let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
" " let g:deoplete#omni_patterns.java = '\%(\h\w*\|)\)\.\w*'
" let g:deoplete#omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" let g:deoplete#omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" let g:deoplete#omni_patterns.scala = '[^. *\t]\.\w*\|: [A-Z]\w*'
" " let g:deoplete#omni_patterns.typescript = '[^. \t0-9]\.([a-zA-Z_]\w*)?'
"
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = []
" let g:deoplete#auto_completion_start_length = 2
" let g:deoplete#file#enable_buffer_path = 1
" let g:deoplete#enable_smart_case = 1

" let g:deoplete#enable_debug = 1
" let g:deoplete#enable_profile = 1
" call deoplete#enable_logging('DEBUG', './deoplete.log')
endif

if has_key(g:plugs, 'ultisnips')
    " Ultisnips
    let g:UltiSnipsExpandTrigger="<C-e>"
    let g:UltiSnipsJumpForwardTrigger="<C-k>"
    let g:UltiSnipsJumpBackwardTrigger="<C-b>"
    let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME."/.config/nvim/my-snippets/UltiSnips"]
endif

if has_key(g:plugs, 'nvim-cmp')
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    completion = {
      autocomplete = true,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['bashls'].setup {
    capabilities = capabilities
  }
  -- require('lspconfig')['pyls'].setup {
  --   capabilities = capabilities
  -- }
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['dockerls'].setup {
    capabilities = capabilities
  }
EOF
endif

" Fuzzy Find for neovim
" TODO: filter file type e.g. binary file
" - down / up / left / right
let g:fzf_layout = { 'up': '~50%' }
" Rely on fd
let $FZF_DEFAULT_COMMAND = '( fd --type f --hidden --follow --exclude .git || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null' 

" In Neovim, you can set up fzf window using a Vim command
" Customize fzf colors to match your color scheme
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.


" BufExplorer
let g:bufExplorerDisableDefaultKeyMapping=1

" TODO: rootcause vim8 fails...
if ! has('nvim')
set laststatus=2
endif

" Color
if (has("termguicolors"))
    set termguicolors
endif
syntax enable
colorscheme seoul256

" Grepper
let g:grepper = {
    \ 'tools': ['ag', 'git', 'rg'],
    \ 'ag': {
    \   'grepprg':    'ag --hidden -p ~/.config/nvim/.agignore --vimgrep',
    \   'grepformat': '%f:%l:%m',
    \   'escape':     '\+*^$()[]',
    \ },
    \ 'rg': {
    \   'grepprg':    'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" ',
    \   'grepformat': '%f:%l:%m',
    \   'escape':     '\+*^$()[]',
    \   'wordanchors': ['', ''],
    \ }
    \}
let g:grepper.quickfix = 0

" Ack
let g:ackprg = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" '

" Auto close the Quickfix list after pressing '<enter>' on a list item
" let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!


" Vim markdown
let g:vim_markdown_fenced_languages = ['html', 'java', 'cpp', 'python=py', 'bash=sh']
let g:vim_markdown_autowrite = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vimwiki_conceallevel=0
let g:taskwiki_disable_concealcursor=1 " Disable the override 

" Vim table mode conflict to vimwiki (https://github.com/dhruvasagar/vim-table-mode/issues/110)
let g:vimwiki_table_mappings = 0

" Commentary
autocmd FileType vimwiki setlocal commentstring=<!--\ %s\ -->
autocmd FileType markdown.mdx setlocal commentstring=<!--\ %s\ -->

" Vim/Task Wiki
let g:vimwiki_list = [{'path': '~/Workspace/vimwiki',
                       \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_folding = 'expr'

" whD
let g:deoplete#sources#whd#learning_texts = ['${HOME}/obama08.txt', '/']

" Far Note ag etc. doesn't support multiline replacement
let g:far#source = 'rg'
let g:far#enable_undo=1

" Ipy
let g:nvim_ipy_perform_mappings = 0

" Rooter
let g:rooter_manual_only = 1

" LargeFile
let g:LargeFile = 5

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=237
hi IndentGuidesEven ctermbg=234


" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_set_quickfix = 1

" CoC
if has_key(g:plugs, 'coc.nvim')
    let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-tsserver',
      \ ]
      " \ 'coc-cfn-lint',
      " \ 'coc-cspell-dicts',
      " \ 'coc-deno',
      " \ 'coc-diagnostic',
      " \ 'coc-docker',
      " \ 'coc-java',
      " \ 'coc-json',
      " \ 'coc-markdownlint',
      " \ 'coc-metals',
      " \ 'coc-prettier',
      " \ 'coc-spell-checker',
      " \ 'coc-vetur',
      " \ 'coc-yaml'
endif

" Github link
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

" Find & Replace
if has_key(g:plugs, 'nvim-spectre')
lua <<EOF
require('spectre').setup({
    replace_engine={
       ['sed']={
            cmd = "sed",
            args = {
                '-i',
                '-E',
            },
            options = {
                ['ignore-case'] = {
                        value= "--ignore-case",
                        icon="[I]",
                        desc="ignore case"
                },
            }
        },
    },
})
EOF
endif

" Fern
let g:fern_disable_startup_warnings = 1

" jupytext
let g:jupytext_to_ipynb_opts = '--to=notebook'

" always use tmux
let g:slime_target = 'tmux'
" fix paste issues in ipython
let g:slime_python_ipython = 1
" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1
