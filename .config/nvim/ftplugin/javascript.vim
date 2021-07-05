" Javascript
setlocal suffixesadd+=.js,.ts,.tsx,.jsx
" Tabs
setlocal smarttab
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
" Wild
setlocal wildignore+=*/node_modules/*
setlocal wildignore+=*/dist/*
setlocal wildignore+=*/build/*


" let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all --printWidth 100'
" let g:ale_fix_on_save = 1
let b:ale_fixers = ['eslint']

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
