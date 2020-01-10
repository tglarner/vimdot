"" Note:
"" Using anaconda can lead to conflits because vim uses system python per
"" default when started from desktop or nautilus.
"" Check python exec per :!which python if errors occur.

"" Set specific presets for python
setlocal textwidth=79
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal expandtab
setlocal nosmartindent
setlocal autoindent
setlocal fileformat=unix
setlocal encoding=utf-8

"" Set colorcolumn on line 80
set colorcolumn=80                "" Highlight column 80 to dark grey
hi ColorColumn ctermbg=darkgrey guibg=darkgrey
hi Normal ctermbg=none
hi NonText ctermbg=none

"" use pytest for vim-test
let test#python#runner = 'pytest'
nmap <silent> <leader>ts :! clear && pytest .<cr>
nmap <silent> <leader>td :w<cr>:Dispatch python -m pytest %<cr>

" open all folds on fileopen:
augroup openFolds
  autocmd!
  autocmd BufReadPost *.py silent! exec "normal zR"
augroup END

"" PLUGIN config ##############################################################

"" SimplyFold
let g:SimpylFold_docstring_preview = 1

" argwrap config
nnoremap <silent> <leader>aw :ArgWrap<cr>
let g:argwrap_tail_comma = 1
let g:argwrap_wrap_closing_brace = 0
