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

" Map Shift-Function key to nothing. Tis should fix weird behaviour when
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

augroup LatexDispatch
  au!
  autocmd Filetype tex
    \ if empty(glob("./Makefile"))
    \ |   let b:dispatch = 'latexmk -pdf'
    \ | endif
augroup END

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
nnoremap <leader>MF :Make %:t:r<cr>
nnoremap <leader>mf :Make! %:t:r<cr>
nnoremap <leader>MR :!./%:t:r<cr>

"" Vim Test: ######################
" test strategy needs vim-dispatch
let test#strategy = "dispatch"
nmap <silent> <leader>tn :TestNearest<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
nmap <silent> <leader>tl :TestLast<cr>
nmap <silent> <leader>tv :TestVisit<cr>
" Refer to ftplugin/python*.vim for more mappings

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


if has('nvim')
  let g:pylintrcpath = '--rcfile='.expand('$HOME/.pylintrc')
lua << EOC
  --  nvim-lsp: ######################
  -- config details: https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed
  -- more info: https://coffeeandcontemplation.dev/2021/01/10/language-server-in-vim/
  require('lspconfig').pylsp.setup{ settings = { pylsp = {
    plugins = {
      pyflakes = { enabled = false, },
      pycodestyle = { enabled = false, },
      pydocstyle = { enabled = true, },
      pylint = {
        enabled = true,
        args = { vim.api.nvim_eval('g:pylintrcpath'), }
      },
    }
  } } }

  require('lspconfig').ccls.setup{}

  -- display diagnostics as tooltip instead of virtual text:
  vim.o.updatetime = 250
  vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false,
  })
  -- vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  -- ALE-like jump to next/prev linter warning
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

  -- lsp keymaps ported from vim-lsp config
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>lx', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', '<leader>lS', vim.lsp.buf.workspace_symbol, bufopts)
  vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>lA', vim.lsp.buf.range_code_action, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

  --  nvim-lint: #####################
EOC
  " " Notes about pylint to avoid being driven crazy in the Future:
  " "     - Assumes that a .pylintrc file is present in the home directory.
  " "       If ALEInfo shows exit code 1 / NO OUTPUT RETURNED!,
  " "       this might be the reason.
  " "       When in  doubt create a default one with
  " "       $> pylint --generate-rcfile > $HOME/.pylintrc
  " "     - pylint is not smart enough to respect venvs.
  " "       If pylint reports import errors for custom installed packages,
  " "       it most likely runs in the global environment. In this case,
  " "       make sure that the desired environment is activated and perform
  " "       $> python -m pip install --force pylint
  " "       to explicitly install pylint in the current environment
  autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
  au BufWritePost lua require('lint').try_lint()

  sign define LspDiagnosticsSignError text=🔴
  sign define LspDiagnosticsSignWarning text=🟠
  sign define LspDiagnosticsSignInformation text=🔵
  sign define LspDiagnosticsSignHint text=🟢

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


  "  Deoplete-Cpp
  " source: https://github.com/kiddos/deoplete-cpp
  let g:deoplete#sources#cpp#standard = 17

endif

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1

" vim-json
let g:vim_json_syntax_conceal = 0
