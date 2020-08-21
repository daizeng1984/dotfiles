" terminal from https://github.com/jasonrsmith/dotfiles/blob/master/.vimrc#L268
" set switchbuf+=useopen
function! TermEnter()
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, "term://") > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
        break
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
" TODO: allow configuration of size and vertical/horizontal
  if(nummatches >= 1)
    execute ":belowright sbuffer ". firstmatchingbufnr
    startinsert
  else
    execute ":belowright sp | :terminal"
  endif
endfunction

" http://stackoverflow.com/questions/10394707/create-file-inside-new-directory-in-vim-in-one-step
function s:MKDir(...)
    if         !a:0 
           \|| stridx('`+', a:1[0])!=-1
           \|| a:1=~#'\v\\@<![ *?[%#]'
           \|| isdirectory(a:1)
           \|| filereadable(a:1)
           \|| isdirectory(fnamemodify(a:1, ':p:h'))
        return
    endif
    return mkdir(fnamemodify(a:1, ':p:h'), 'p')
endfunction
command -bang -bar -nargs=? -complete=file E :call s:MKDir(<f-args>) | e<bang> <args>


" From FZF's author https://github.com/junegunn/fzf/wiki/Examples-(vim)#narrow-ag-results-within-vim
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
  endif
endfunction

" https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -nargs=* Rg call fzf#run({
\ 'source':  printf('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

function! s:getemoji()
    let keys = emoji#list()
    let retval = []
    for e in keys
        let v = emoji#for(e)
        call add(retval, e . '=' . v)
    endfor
    return retval
endfunction

function! s:addemoji(line)
    let arr = split(a:line, '=')
    execute "normal! a" . arr[1] . "\<Esc>"
endfunction

command! -nargs=* FzfEmoji call fzf#run({
            \ 'source': <sid>getemoji(),
            \ 'sink': function('<sid>addemoji'),
            \ 'down':    '50%'
            \})


" Find a file to diff
command! -nargs=* FzfDiff call fzf#run({
            \ 'sink': 'vertical diffsplit',
            \ 'down':    '50%'
            \})

" if executable("rg")
"     set grepprg=rg\ --vimgrep\ --no-heading\ --no-ignore\ --hidden
"     set grepformat=%f:%l:%c:%m,%f:%l:%m
" endif

" Our Vim function
fu! MyEclimdJavaDebug()
    let filename = expand("%")
    let filename = substitute(filename, "\.java$", "", "")
    let dir = getcwd() . "/" . filename
    let dir = substitute(dir, "^.*\/src\/", "", "")
    let dir = substitute(dir, "\/[^\/]*$", "", "")
    let dir = substitute(dir, "\/", ".", "g")
    let filename = substitute(filename, "^.*\/", "", "")
    execute ":! java  -Xdebug -agentlib:jdwp=transport=dt_socket,address=9999,server=y,suspend=y -classpath ./bin ".dir.".".filename." & sleep 1.5"
    let g:server_addr = serverstart('EclimdDebug')
    execute ":JavaDebugStart localhost 9999"
endfunction

" Delete current file http://vim.wikia.com/wiki/Delete_files_with_a_Vim_command
command! -complete=file -nargs=1 Remove :echo 'Remove: '.'<f-args>'.' '.(delete(<f-args>) == 0 ? 'SUCCEEDED' : 'FAILED')


" Calendar action some stolen from 
let g:my#calendar_action#backup = ''
fun MyCalAction(day, month, year, week, dir)
    let datetime_date = printf("%d-%d-%d", a:year, a:month, a:day)
	exe "q"
    exe "normal! a".datetime_date."\el"
    let g:calendar_action = g:my#calendar_action#backup
    if col('.') == col('$') - 1
        startinsert! " `A`
    else
        normal l     " `l`
        startinsert  " `i`
    end
endf
fun MyInsertCalDate()
    let g:my#calendar_action#backup = g:calendar_action
    let g:calendar_action = 'MyCalAction'
    if !exists(':Calendar')
        echo "Please install plugin Calendar.vim"
    endif

    " call calendar
    echo "Open Calendar..."
    exe ":Calendar"
endf

" Use NERDTree to open the directory https://github.com/junegunn/fzf.vim/issues/251
command! -nargs=* -complete=dir NERDShowDir call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'NERDTree'}))

function CopyToNetCat() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| nc localhost 2000')
endfunction

source $HOME/.config/nvim/config/functions/asciiemoji.vimrc
