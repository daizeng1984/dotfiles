function! RagtagFix()
    call RagtagInit()
    " Just to get rid of the C-V for myself
    iunmap <buffer> <C-V>&
    iunmap <buffer> <C-V>%
endfunction
augroup ragtag
  autocmd FileType *html*,wml,jsp,gsp,mustache,smarty         call RagtagFix()
  autocmd FileType php,asp*,cf,mason,eruby,liquid,jst,eelixir call RagtagFix()
  autocmd FileType xml,xslt,xsd,docbk                         call RagtagFix()
  autocmd FileType javascript.jsx,jsx,handlebars              call RagtagFix()
augroup END


