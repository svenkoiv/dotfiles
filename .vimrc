call plug#begin('~/.vim/plugged')

set rtp+=~/.fzf

Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-vinegar'
Plug 'honza/vim-snippets'
Plug 'morhetz/gruvbox'

call plug#end()

" COLORS
"----------------------------------------
set background=dark
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_bold=1
let g:gruvbox_invert_selection=0
colorscheme gruvbox

" Gutter has design which is not same as default background
"highlight clear SignColumn
highlight Normal ctermbg=NONE
" Display different cursors when in insert mode
" Autocommands should be groupped, because sourcing .vimrc duplicates
" autocommadns and makes vim slower
augroup cursorStyle
  autocmd!
  autocmd InsertEnter * silent execute "!echo -en \<esc>[5 q"
  autocmd InsertLeave * silent execute "!echo -en \<esc>[2 q"
augroup END

" CONFIGURATION
"----------------------------------------
" When 'wildmenu' is on, command-line completion operates in an enhanced
" mode.  On pressing 'wildchar' to invoke completion,
set wildmenu
set wildcharm=<C-z>
set wildmode=full
set wildignore+=**/node_modules/** 
set encoding=utf8
let mapleader = ","
set autoindent
" set listchars=tab:â–¸\ ,eol:Â¬
set relativenumber
set number
set timeoutlen=500
" Fix noticable delay when pressing 'O'.
set ttimeoutlen=0
" Make search case sensitive.
set smartcase
" Highlight search results
set hlsearch
" Amount of commands which are stored in history table.
set history=350
" Scroll offset determines the number of context lines you would like to see
" above and below the cursor. 
set scrolloff=5
" It should be possible to open buffers without saving current buffer. (E37: No write since last change).
set hidden
" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
set autoread
" Determines the maximum number of items to show in the popup menu for
" Insert mode completion.  When zero as much space as available is used.
set pumheight=7
"	When this option is set, the screen will not be redrawn while
"	executing macros, registers and other commands that have not been typed.
set lazyredraw
set colorcolumn=100
" Discourage the use of arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" 'Q' command starts Ex mode, but you will not need it.
map Q <nop>
" Resize window width
nnoremap <silent> <Leader>+ :exe "vert resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "vert resize " . (winwidth(0) * 2/3)<CR>

" Should be possible to write commands without exectue
function Translate()
  let @f = expand("%")
  execute "e " . "translations/translations.json"

  execute "normal! }?}\<cr>\<esc>"
  execute "mark t"
  execute "r!grep -o \"translate('.*')\" " . @f
  execute "'t"
  execute "'t,$g/translate('.*')/call TranslateLine()"
  execute "'t"
  execute ".,$norm =="
endfunction

function TranslateLine()
  execute "write"
  execute "normal! f'lvt'\"ay"
  let @t = '0df(cs''"f)DA: {}€ýai€ýaO"et": " TODO","en": " (en) TODO","ru": " (ru) TODO€ýaA"€ýa€ýa'
  let translationOccurrance = substitute(system('grep -o "\"' . @a . '\"" translations/translations.json | wc -l'), '\n\+$', '', '')
   if translationOccurrance > 0
    execute "normal! dd"
   elseif translationOccurrance == 0
     execute "normal! ?}\<cr>a,\<esc>j"
     execute "normal! @t"
   endif
endfunction

function Token()
  silent execute "!node /home/skoiv/Personal/auth/index.js"
  silent execute "normal \<c-l>"
  silent execute "!pm2 restart impulss"
endfunction

command! -bang -nargs=? -complete=function Translate
      \ call Translate()
command! -bang -nargs=? -complete=function Token
      \ call Token()

" PLUGIN CONFIGURATIONS
"----------------------------------------
" FZF
"----------------------------------------
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>B :Buffers!<CR>
nnoremap <silent> <leader>l :Lines<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>h/ :History/<CR>
nnoremap <silent> <leader>c :Commands<CR>
nnoremap <silent> <leader>m :Marks<CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" COC
"----------------------------------------
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>[g <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>]g <Plug>(coc-diagnostic-next)
nmap <leader>ac <Plug>(coc-codeaction)
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-prettier',
      \ 'coc-eslint',
      \ 'coc-tslint',
      \ 'coc-marketplace',
      \ 'coc-snippets',
      \ 'coc-java',
      \ 'coc-lua',
      \ ]

" ALE
"----------------------------------------
let g:ale_set_highlights = 0

" NETRW
"----------------------------------------
" The default listing style I like, one file per line with file size and time stamp
let g:netrw_liststyle=0
" Directories on the top, files below
let g:netrw_sort_sequence='[\/]$,*'
" Keep the cursor in the netrw window
let g:netrw_preview=1
" Remove the banner
let g:netrw_banner=0
nnoremap <silent> <leader>nt :Ntree<CR>
" Open file tree on current file
nnoremap <silent> <leader>nf :Explore<CR>

" COC SNIPPETS
"----------------------------------------
" <c-j> jump to next placeholder
" <c-k> jump to previous placeholder
" <c-y> to select and expand
" <c-e> to expand immediately
imap <C-e> <Plug>(coc-snippets-expand)
