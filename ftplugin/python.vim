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

"" use pytest mapping for vim-test
nmap <silent> <leader>ts :! clear && pytest .<cr>

" open all folds on fileopen:
autocmd BufRead *.py silent! normal zR
"" PLUGIN config ##############################################################

"" ALE:
let g:ale_linters = {'python': ['pydocstyle', 'pylint', 'pyls']}
let g:ale_fixers = {'python': ['autopep8', 'isort']}
let g:ale_python_pylint_options = expand('--rcfile $HOME/.pylintrc')
let g:ale_lint_on_text_changed = 'never'
let g:ale_completion_enabled = 1        "" let vim-lsc manage completion

" "" Python-specific ALE airline config
let g:airline#extensions#ale#enabled = 1

"" SimplyFold
let g:SimpylFold_docstring_preview = 1

" argwrap config
nnoremap <silent> <leader>aw :ArgWrap<cr>
let g:argwrap_tail_comma = 1
let g:argwrap_wrap_closing_brace = 0
