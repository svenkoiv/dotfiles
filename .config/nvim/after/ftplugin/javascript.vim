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

let b:ale_fixers = ['eslint']