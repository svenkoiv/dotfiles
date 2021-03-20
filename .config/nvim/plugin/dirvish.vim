augroup OverrideDirvish
  autocmd!
  autocmd FileType dirvish
        \ silent! nnoremap <nowait><buffer><silent> o :<C-U>.call dirvish#open('edit', 0)<CR>
  autocmd FileType dirvish
        \ silent! nnoremap <nowait><buffer><silent> <c-p> <up>
  autocmd FileType dirvish
        \ silent! nnoremap <nowait><buffer><silent> <c-n> <down>

augroup END
