"" PLUGIN-specific config and key mappings ####################################
"" Note: plugin config for language-specific plugins is in ftplugin/LANGUAGE.vim

"" Latex: #####################
let g:tex_flavor='latex'

"" CamelCaseMotion: #####################
call camelcasemotion#CreateMotionMappings('g')

"" Vim Rooter: #####################
" Switch to file directory for non-project files
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
let g:rooter_cd_cmd ='lcd'
let g:rooter_patterns = ['Makefile', '.git/', 'setup.py']
" set mydir to directory of current buffer to make gf etc work
let $mydir = expand('%:h').'/'

"" FZF Mappings: ######################
nmap <Leader>fzf :FZF
nmap <Leader>fzh :FZF ~<CR>
nmap <Leader>fzw :FZF ~/workspace/<CR>
nmap <Leader>ff :Files<CR>
nmap <Leader>fg :GFiles<CR>
nmap <Leader>fb :Buffers<CR>
nmap <Leader>fh :History<CR>
nmap <Leader>ft :BTags<CR>
nmap <Leader>fT :Tags<CR>
nmap <Leader>fl :BLines<CR>
nmap <Leader>fL :Lines<CR>
nmap <Leader>fm :Marks<CR>
nmap <Leader>fH :Helptags!<CR>
nmap <Leader>fc :Commands<CR>
nmap <Leader>fC :Commits<CR>
nmap <Leader>: :History:<CR>
nmap <Leader>fM :Maps<CR>
nmap <Leader>fs :Filetypes<CR>
" extensions by vim-agriculture
nmap <Leader>/ <Plug>AgRawSearch
vmap <Leader>/ <Plug>AgRawVisualSelection<cr>
nmap <Leader>* <Plug>AgRawWordUnderCursor<cr>

"" Tmux Stuff: ######################
" This is configured to work with byobu default keybindings

" Map Shift-Function key to nothing. This should fix weird behaviour when
" working that causes vim to switch in ex mode when pressed.
map <S-F1> <Nop>
map <S-F2> <Nop>
map <S-F3> <Nop>
map <S-F4> <Nop>
map <S-F5> <Nop>
map <S-F6> <Nop>
map <S-F7> <Nop>
map <S-F8> <Nop>
map <S-F9> <Nop>
map <S-F10> <Nop>
map <S-F11> <Nop>
map <S-F12> <Nop>

""Vim Tmux Navigator: #####################
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <S-Up>  :TmuxNavigateUp<cr>
nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <S-F3>  :TmuxNavigatePrevious<cr>

""Vim Tmux Resizer: #####################
let g:tmux_resizer_no_mappings = 0
nnoremap <silent> <M-S-Left>  :TmuxResizeLeft<cr>
nnoremap <silent> <M-S-Up>    :TmuxResizeUp<cr>
nnoremap <silent> <M-S-Down>  :TmuxResizeDown<cr>
nnoremap <silent> <M-S-Right> :TmuxResizeRight<cr>

"" #####################

"" Airline: #####################
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0

let g:airline#extensions#ale#enabled = 1

let g:airline#extensions#fugitiveline#enabled = 1

let g:airline#extensions#fzf#enabled = 1

let g:airline#extensions#head#enabled = 0

" unicode symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = 'Ξ'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'P'
let g:airline_symbols.spell = 'S'
let g:airline_symbols.whitespace = '☲'

"" IDE Stuff: ######################

"" Vim Test: ######################
" test strategy needs vim-dispatch
let test#strategy = "dispatch"
nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
nmap <silent> <leader>tl :TestLast<cr>
nmap <silent> <leader>tv :TestVisit<cr>
" Refer to ftplugin/python*.vim for more mappings

" Vim Fugitive: ######################
nmap <leader>gb :Git blame<cr>
nmap <leader>gs :Git<cr>
nmap <leader>gl :Gclog<cr>
nmap <leader>gP :Git push
nmap <leader>gp :Git pull
nmap <leader>gc :Git commit
nmap <leader>gt :Gtabedit
nmap <leader>ge :Gedit
nmap <leader>gm :GMove
nmap <leader>gR :Gread
nmap <leader>gw :Gwrite
"  Rewiew command:  https://stackoverflow.com/a/29454450
command! Greview :Git! diff --staged
nmap <leader>gr :Greview

"" Vim Dispatch: ######################
let g:dispatch_no_maps = 1
let g:make_target = 'all'
function!GetMakeTarget()
  if exists("make_target")
    return make_target
  else
    return g:make_target
  endif
endfunction
nnoremap <leader>mm :Make!<cr>
nnoremap <leader>mt :exec 'Make! ' . GetMakeTarget()<cr>
nnoremap <leader>ma :Make! all<cr>
nnoremap <leader>mc :Make! clean<cr>
nnoremap <leader>MM :Make<cr>
nnoremap <leader>MT :exec 'Make ' . GetMakeTarget()<cr>
nnoremap <leader>MA :Make all<cr>
nnoremap <leader>MC :Make clean<cr>
nnoremap <leader>oq :Copen<cr>
nnoremap <leader>ol :lopen<cr>

"" Vim Vebugger: ######################
"  If you set|g:vebugger_leader| in your vimrc you'll get keymaps for the
"  Vebugger commands. The keymaps all start with the leader you set, following
"  with:
"
"  i      |:VBGstepIn|
"  o      |:VBGstepOver|
"  O      |:VBGstepOut|
"  c      |:VBGcontinue|
"
"  b      |:VBGtoggleBreakpointThisLine|
"  B      |:VBGclearBreakpints|
"
"  e      |:VBGevalWordUnderCursor| in normal mode
"         |:VBGevalSelectedText| in select mode
"  E      Prompt for an argument for |:VBGeval|
"
"  x      |:VBGexecute| current line in normal mode.
"         |:VBGexecuteSelectedText| in select mode
"  X      Prompt for an argument for |:VBGexecute|
"
"  t      |:VBGtoggleTerminalBuffer|
"  r      Select mode only - |:VBGrawWriteSelectedText|
"  R      Prompt for an argument for |:VBGrawWrite|
let g:vebugger_leader = '<leader>d'
" kill Vebugger and close Shell buffer
nnoremap <silent> <leader>dk :VBGkill<CR><C-w>j:q!<CR>

" map to launch appropriate debugger
" <leader>dl   is for debugger launch
" <leader>da   is for debugger launch with args
augroup VebuggerLaunch
  autocmd! VebuggerLaunch
  autocmd Filetype python nmap <buffer> <leader>dl :VBGstartPDB %<CR>
  autocmd Filetype python nmap <buffer> <leader>da :VBGstartPDB % [ARGS]

  autocmd Filetype c,cpp nmap <buffer> <leader>dl :VBGstartGDB %<CR>
  autocmd Filetype c,cpp nmap <buffer> <leader>da :VBGstartGDB % [ARGS]

  autocmd Filetype d nmap <buffer> <leader>dl :VBGstartGDBforD %<CR>
  autocmd Filetype d nmap <buffer> <leader>da :VBGstartGDBforD % [ARGS]
augroup END

augroup MapQuitInVebuggerShell
  autocmd! MapQuitInVebuggerShell
  autocmd BufEnter Vebugger:Shell
    \ nnoremap <buffer><silent> gq :q!<cr>
augroup END


"" ALE:  ######################
" Keymaps to jump to next/prev warning/error
" menmonic: next/prev *e*rror
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" pyls can only be activated by using it as a linter source,
" thus ALE is not used as language server client.
let g:ale_completion_enabled = 0        "" let LanguageClient manage completion
let g:ale_linters = {
\  'python': ['pylint', 'vim-lsp'],
\  'markdown': ['mdl'],
\}
let g:ale_fixers = {
\  'python': ['black', 'isort'],
\}
" Notes about pylint to avoid being driven crazy in the Future:
"     - Assumes that a .pylintrc file is present in the home directory.
"       If ALEInfo shows exit code 1 / NO OUTPUT RETURNED!,
"       this might be the reason.
"       When in  doubt create a default one with
"       $> pylint --generate-rcfile > $HOME/.pylintrc
"     - pylint is not smart enough to respect venvs.
"       If pylint reports import errors for custom installed packages,
"       it most likely runs in the global environment. In this case,
"       make sure that the desired environment is activated and perform
"       $> python -m pip install --force pylint
"       to explicitly install pylint in the current environment
let g:ale_python_black_options = '-S'
let g:ale_python_isort_options= '--use-parentheses --force-grid-wrap 3 --force-sort-within-sections'
let g:ale_python_pylint_options = '--rcfile='.expand('$HOME/.pylintrc')
let g:ale_lint_on_text_changed = 'never'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'"
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'

let g:ale_sign_error = 'E '
let g:ale_sign_warning = 'W '

"" LanguageClient: vim-lsp and ALE ######################
" If the language server commands do not work, pyls and/or the extensions
" might not be installed properly. A working installation was:
"   $> python -m pip install mypy black
"   $> python -m pip install --force 'python-language-server[all]'
" source:
"   https://github.com/palantir/python-language-server/issues/359#issuecomment-527247569

if executable('pyls')
    " pip install python-language-server
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>ld <plug>(lsp-definition)
    nmap <buffer> <leader>lt <plug>(lsp-type-definition)
    nmap <buffer> <leader>li <plug>(lsp-implementation)
    nmap <buffer> <leader>ls <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>lS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>lx <plug>(lsp-references)
    nmap <buffer> <leader>lr <plug>(lsp-rename)
    nmap <buffer> <leader>[l <plug>(lsp-previous-diagnostic)
    nmap <buffer> <leader>]l <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " inoremap <buffer> <expr><leader><c-f> lsp#scroll(+4)
    " inoremap <buffer> <expr><leader><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that have the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 0

"  Deoplete: ######################
" <TAB>: completion.
" needs neovim package for python3:
"   $> pip install neovim
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
" increase delay to fix race condition resulting in unwanted autocompletion
" see https://github.com/Shougo/deoplete.nvim/issues/440 for details
" Pass a dictionary to set multiple options
call deoplete#custom#option({
\ 'auto_complete_delay': 250,
\ 'smart_case': v:true,
\ })

