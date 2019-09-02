"" PLUGIN-specific config and key mappings ####################################
"" Note: plugin config for language-specific plugins is in ftplugin/LANGUAGE.vim

"" latex
let g:tex_flavor='latex'

"" bclose
"" remove default mapping <leader>bd since it forces operator-pending mode
"" for <leader>b, which is backwards subword movement in CamelCaseMotion
let g:bclose_no_plugin_maps = 0
"" use <leader>cb instead, since <leader>c is not used by any plugin.
nnoremap <leader>cb :Bclose<cr>

"" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

"" vim-rooter: Switch to file directory for non-project files
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
let g:rooter_use_lcd = 1
let g:rooter_patterns = ['Makefile', '.git/']
"" set mydir to directory of current buffer to make gf etc work
let $mydir = expand('%:h').'/'

"" fzf mappings ######################
nmap <Leader>fzf :FZF ~<CR>
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
nmap <Leader>/ :Ag<Space>
nmap <Leader>: :History:<CR>
nmap <Leader>fM :Maps<CR>
nmap <Leader>fs :Filetypes<CR>

"" tmux stuff ######################
" This is configured to work with byobu default keybindings

"" vim-tmux-navigator
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

""vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <S-Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <S-Down> :TmuxNavigateDown<cr>
nnoremap <silent> <S-Up>  :TmuxNavigateUp<cr>
nnoremap <silent> <S-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <S-F3>  :TmuxNavigatePrevious<cr>

""vim-tmux-resizer
let g:tmux_resizer_no_mappings = 0
nnoremap <silent> <M-S-Left>  :TmuxResizeLeft<cr>
nnoremap <silent> <M-S-Up>    :TmuxResizeUp<cr>
nnoremap <silent> <M-S-Down>  :TmuxResizeDown<cr>
nnoremap <silent> <M-S-Right> :TmuxResizeRight<cr>

"" #####################

"" airline #####################
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_buffers = 2
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

"" IDE stuff ######################

"" vim-test ######################
nmap <silent> <leader>tv :TestVisit<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>

" vim-fugitive ######################
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

"" vim-dispatch ######################
let g:dispatch_no_maps = 1
let g:make_target = 'all'
function!GetMakeTarget()
  if exists("make_target")
    return make_target
  else
    return g:make_target
  endif
endfunction
nnoremap <leader>mt :exec 'Make! ' . GetMakeTarget()<cr>
nnoremap <leader>ma :Make!<cr>
nnoremap <leader>mc :Make! clean<cr>
nnoremap <leader>Mt :exec 'Make ' . GetMakeTarget()<cr>
nnoremap <leader>Ma :Make<cr>
nnoremap <leader>Mc :Make clean<cr>
nnoremap <leader>oq :Copen<cr>

"" ######################

"" ALE:  ######################

" Keymaps to jump to next/prev warning/error
" menmonic: *a*le next
nmap <silent> <leader>an :ALENext<cr>
nmap <silent> <leader>aN :ALEPrevious<cr>
" menmonic: next/prev *e*rror
nmap <silent> ]e :ALENext<cr>
nmap <silent> [e :ALEPrevious<cr>

" let b:ale_linters = {'python': ['pydocstyle', 'pylint', 'pyls']}
let b:ale_linters = {'python': ['pylint']}
let b:ale_fixers = {'python': ['autopep8', 'isort']}
let b:ale_python_pylint_options = expand('--rcfile $HOME/.pylintrc')
let b:ale_lint_on_text_changed = 'never'
let b:ale_completion_enabled = 0        "" let vim-lsc manage completion

"  deoplete ######################
" <TAB>: completion.
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

"" LanguageClient-neovim ######################
let g:LanguageClient_serverCommands = {
  \ 'python': ['python', '-m', 'pyls'],
  \ }
let g:LanguageClient_diagnosticsEnable=0
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
