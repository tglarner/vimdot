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

"" use pytest mapping for vim-test
nmap <silent> <leader>ts :! clear && pytest .<cr>

"" automatically set a breakpoint in front of the current line with F8
function! python#BreakpointLine()
  let python_version = split(system('python --version'))[1]
  if split(python_version, '\.')[1] >= 7
    let breakpoint_line = 'breakpoint()'
  else
    "" python 3.6.X has no breakpoint() builtin
    let breakpoint_cmd = $PYTHONBREAKPOINT
    if ''.breakpoint_cmd == ''
      let breakpoint_line = 'import pdb; pdb.set_trace()'
    else
      let debugger_lib = 'import '.split(breakpoint_cmd, '\.')[0]
      let breakpoint_line = ''.debugger_lib.'; '.breakpoint_cmd.'()'
    endif
  endif
  return breakpoint_line
endfunction

function! python#DelBreakpointLine()
    let remove_pattern =  '^\s*'.escape(python#BreakpointLine(), '\\/.*$^~[]').'$'
    let del_breakpoint_cmd = 'g/'.remove_pattern.'/d'
    return del_breakpoint_cmd
endfunction

nmap <silent> <leader>bs O<C-r>=python#BreakpointLine()<cr><Esc>:w<bar>:noh<cr>
noremap <leader>bd :exec python#DelBreakpointLine() <bar> noh<cr>
"" PLUGIN config ##############################################################

"" ALE:
let g:ale_linters = {'python': ['pydocstyle', 'pylint']}
let g:ale_fixers = {'python': ['autopep8', 'isort']}
let g:ale_python_pycodestyle_executable = 'pycodestyle'
let g:ale_python_pydocstyle_executable = 'pydocstyle'
let g:ale_python_pylint_executable = 'pylint'
let g:ale_python_autopep8_executable = 'autopep8'
let g:ale_python_isort_executable = 'isort'
let g:ale_python_pylint_options = expand('--rcfile $HOME/.pylintrc')
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
"" disable annoying auto-completion of import in 'from ... import',
"" often resulting in 'from ... import import' due to muscle memory.
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 2

"" SimplyFold
let g:SimpylFold_docstring_preview = 1

" open all folds on fileopen:
autocmd BufWinEnter *.py silent! zR

" argwrap config
nnoremap <silent> <leader>aw :ArgWrap<cr>
let g:argwrap_tail_comma = 1
let g:argwrap_wrap_closing_brace = 0
