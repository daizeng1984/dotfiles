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
