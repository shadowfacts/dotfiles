inoremap jk <ESC>

filetype plugin indent on

syntax on
autocmd FileType markdown :syntax off
autocmd BufNewFile,BufRead *.md setlocal ft=markdown