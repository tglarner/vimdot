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
let g:rooter_use_lcd = 1
let g:rooter_patterns = ['Makefile', '.git/']
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
let g:airline#extensions#head#enabled = 0
let g:airline#extensions#ale#enabled = 1

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
let test#strategy = "dispatch"
nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
nmap <silent> <leader>tl :TestLast<cr>
nmap <silent> <leader>tv :TestVisit<cr>
nmap <silent> <leader>td :Dispatch python -m doctest %<cr>


" Vim Fugitive: ######################
nmap <leader>gb :Gblame<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gP :Gpush
nmap <leader>gp :Gpull
nmap <leader>gc :Gcommit
nmap <leader>gt :Gtabedit
nmap <leader>ge :Gedit
nmap <leader>gm :Gmove
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
nnoremap <leader>md :Make!<cr>
nnoremap <leader>mt :exec 'Make! ' . GetMakeTarget()<cr>
nnoremap <leader>ma :Make! all<cr>
nnoremap <leader>mc :Make! clean<cr>
nnoremap <leader>Md :Make<cr>
nnoremap <leader>Mt :exec 'Make ' . GetMakeTarget()<cr>
nnoremap <leader>Ma :Make all<cr>
nnoremap <leader>Mc :Make clean<cr>
nnoremap <leader>oq :Copen<cr>

"" ALE:  ######################
" Keymaps to jump to next/prev warning/error
" menmonic: next/prev *e*rror
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)

" pyls can only be activated by using it as a linter source,
" thus ALE is not used as language server client.
let g:ale_completion_enabled = 0        "" let LanguageClient manage completion
let g:ale_linters = {'python': ['pylint']}
let g:ale_fixers = {'python': ['autopep8', 'isort']}
let g:ale_python_pylint_options = '--rcfile='.expand('$HOME/.pylintrc')
let g:ale_lint_on_text_changed = 'never'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'"
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'

let g:ale_sign_error = 'E '
let g:ale_sign_warning = 'W '

"  Deoplete: ######################
" <TAB>: completion.
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
" increase delay to fix race condition resulting in unwanted autocompletion
" see https://github.com/Shougo/deoplete.nvim/issues/440 for details
let g:deoplete#auto_complete_delay=250  "delay in ms

"" LanguageClient: ######################
let g:LanguageClient_serverCommands = {
  \ 'python': ['python', '-m', 'pyls'],
  \ }
let g:LanguageClient_diagnosticsEnable=0
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <silent> <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <silent> <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <silent> <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <silent> <leader>lm :call LanguageClient_contextMenu()<CR>
