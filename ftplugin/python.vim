"" Note:
"" Using anaconda can lead to conflits because vim uses system python per
"" default when started from desktop or nautilus.
"" Check python exec per :!which python if errors occur.

"" Set specific presets for python
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
setlocal autoindent
setlocal fileformat=unix

"" use ytest mapping for vim-test
nmap <silent> <F4> :! clear && pytest .<cr>

"" automatically set a breakpoint in front of the current line with F8
nmap <silent> <F8> Obreakpoint()<Esc>:w <cr>
"" delete all breakpoints in file
nmap <silent> <F9> :g/^\s*breakpoint()$/norm dd<Esc>:noh <cr>

"" PLUGIN config ##############################################################

"" ALE:
let g:ale_linters = {'python': ['pycodestyle', 'pydocstyle', 'pylint']}
let g:ale_fixers = {'python': ['autopep8', 'isort']}
let g:ale_python_pycodestyle_executable = 'pycodestyle'
let g:ale_python_pydocstyle_executable = 'pydocstyle'
let g:ale_python_pylint_executable = 'pylint'
let g:ale_python_autopep8_executable = 'autopep8'
let g:ale_python_isort_executable = 'isort'
let g:ale_python_pylint_options = '--disable no-else-return'
let g:ale_lint_on_text_changed = 'never'

" Keymaps to jump to next/prev warning/error
nmap <silent> <leader>an :ALENext<cr>
nmap <silent> <leader>aN :ALEPrevious<cr>

"" Jedi:
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#smart_auto_mappings = 0

" let g:pymode_python = 'python3'
