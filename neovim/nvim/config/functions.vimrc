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

