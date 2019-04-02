"" auto file type detection
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

"" Set proper vim directory
if (has('win32') || has('win64')) && &shellcmdflag =~ '/'
  let g:vimdir='~/vimfiles/'
else
  let g:vimdir='~/.vim/'
endif
let g:vimrc = g:vimdir.'vimrc'

"" VIM-PLUG ##############################################################
"" add plugins with vim-plug
"" Install new plugins by typing :PlugInstall after sourcing the vimrc file

" Download vim-plug
if empty(glob(g:vimdir.'autoload/plug.vim'))
  let b:plug_github='https://raw.github.com/junegunn/vim-plug'
  let b:plug_url=b:plug_github.'/master/plug.vim'
  let b:plug_destination=g:vimdir.'autoload/plug.vim'

  silent exec '!mkdir -p '.g:vimdir.'/autoload'
  silent exec '!curl -fLo '.b:plug_destination.' '.b:plug_url
  if v:shell_error
    echo 'Automatically installing VimPlug using curl has failed.'
    echo 'VimPlug needs to be manually downloaded from '.b:plug_github
    echo 'and placed in '.g:vimdir.'/autoload in order to work.'
    finish
  endif
endif

call plug#begin(g:vimdir.'plugged')

"" vim session management
Plug 'tpope/vim-obsession'

"" Close buffers without closing windows with Bclose
Plug 'rbgrouleff/bclose.vim'

"" Molokai Colorscheme (but with ugly ErrorMsg and WarnMsg)
Plug 'tglarner/molokai'

"" Improved grepping
Plug 'mhinz/vim-grepper'

"" tmux support
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'

"" Set working dir to project root
""  Automatically switches to the next toplevel dir that contains a .git dir
""  when in a project but can be configured to look e.g. for Makefile, etc...
Plug 'airblade/vim-rooter'

"" NERDTree with git status flags
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'

"" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
"" git integration
Plug 'tpope/vim-fugitive'

"" vim-test: Run your tests at the speed of thought
Plug 'janko-m/vim-test'

"" Debugger support
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'idanarye/vim-vebugger'

"" LaTeX plugins --------------------------------------------------------------

""  LaTeX mode
Plug 'lervag/vimtex', { 'for': 'tex' }

"" Mapping plugins ------------------------------------------------------------

""" Repeat the last compound mapping with .
""  This is useful for plugin mappings and user-defined mappings
Plug 'tpope/vim-repeat'

"" Easily modify surroundings: parentheses, braces, brackets, quotes, tags
""  This provides the verbs cs, ds, ys (change, delete, yank surrounding)
""  and the noun (text object) t for tag
Plug 'tpope/vim-surround'

"" Easily comment out lines with key mapping
Plug 'tpope/vim-commentary'

"" Support CamelCase and snake_case motion objects
""  uses <leader>w as sub-word noun and allows all parts of
""  ThisIdentifierTypicalForJava or this_function_name to be navigable.
Plug 'bkad/CamelCaseMotion'

"" repeatable motions: Repeat last motion with
"" <C-h>: backward / <C-l>: forward
Plug 'vim-scripts/repeatable-motions.vim'

"" Indent objects just right for python
""  provides ii, ai, iI, aI text objects for Indentations
Plug 'michaeljsmith/vim-indent-object'

"" Wrap and unwrap function arguments, lists, dicts, etc... programmatically
"" command defined below: <leader>aw to toggle argument wrapping.
Plug 'FooSoft/vim-argwrap'

"" Use Tab for autocompletion
Plug 'ervandew/supertab'

"" Python plugins -------------------------------------------------------------

"" Improved python indenting
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

"" Text objects for python functions (af, if) and classes (ac, ic)
"" as well as working section movements (for classes)
"" and ]m movements (for methods or functions).
Plug 'jeetsukumaran/vim-pythonsense', {'for': 'python' }

"" Improved folding
Plug 'tmhedberg/SimpylFold', {'for': 'python' }

"" ALE: Asynchronous Lint Engine -> Syntax and style checks
Plug 'w0rp/ale', { 'for': 'python' }

"" Jedi: Static code analysis, goto  and autocompletion for python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

call plug#end()

"" Set environment behavior ###################################################

"" Syntax highlighting, but only for color terminals.
if &t_Co > 1
  syntax enable
  "" Molokai colorscheme
  ""  Note: The variables have to be set before setting the colorscheme
  ""        to take effect
  let g:molokai_original = 1
  let g:rehash256 = 1
  colorscheme molokai
endif

"no need to be compatible with vi and lose features.
set nocompatible

"" Set update time to 750 ms , convenient for taglist.vim.
set updatetime=750

"" After this many msecs do not imap.
set timeoutlen=500

set wmh=0                         "" Do not show any line of minimized windows
set splitbelow splitright         "" Natural splits
set noswapfile nobackup nowb      "" Disable any swap and backup files
set showcmd                       " show command info (e.g. leader key)
set hlsearch incsearch ignorecase " nicer search
set textwidth=80                  "" static text width inc. static wrap
set nowrap                        "" Do not break long lines.
set number relativenumber         "" Show hybrid line numbers.
set ls=2                          "" Always show d$filename edited.
set noshowmode                    "" Not needed with airline: Don't show mode.
set nostartofline                 "" Keep horz cursor pos for vert. movement.
set showmatch                     "" Show matching braces.
set wildmenu                      "" Switch to better tab completion
set wildmode=longest:list,full
set autoindent                    "" Automatic indenting.
set backspace=indent,eol,start    "" Natural backspace in insert mode.
set expandtab shiftwidth=2 softtabstop=2
set signcolumn=yes                "" Always keep the gutter open.

set colorcolumn=80                "" Highlight column 80 to dark grey
hi ColorColumn ctermbg=darkgrey guibg=darkgrey
hi Normal ctermbg=none
hi NonText ctermbg=none

"" Switch to absolute line number if in insert mode, out-of-focus
"" or if the buffer is left e.g. by switching windows.
"" source: https://jeffkreeftmeijer.com/vim-number/
let toggle_ignore = ['nerdtree', 'help', 'fugitiveblame']
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave *
          \ if index(toggle_ignore, &ft) < 0 |set relativenumber|endif
    autocmd BufLeave,FocusLost,InsertEnter *
          \ if index(toggle_ignore, &ft) < 0 |set norelativenumber|endif
augroup END

"" Makefiles use tabs instead of spaces
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

"" git commit messages, email messages, etc.. :
autocmd Filetype gitcommit,mail setlocal spell textwidth=75 colorcolumn=75

"" Map quit to normalmode q in help files
augroup MapQuitInHelp
    autocmd! MapQuitInHelp
    autocmd Filetype help,qf nnoremap <buffer> q :q!<cr>
augroup END

" Taken from $VIMRUNTIME/defaults.vim:
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
augroup vimStartup
  au!

  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup END

"" Use mouse even in terminal. This is neat for split resizing.
set ttymouse=xterm2
set mouse=a

"" Useful commands and functions #############################################

""Source this vimrc file from wherever
command! Sorc :exec 'source '.g:vimrc
command! Edrc :exec 'tabe  '.g:vimrc

"" CDC = Change to directory of current file and print destination
command! CDC cd %:p:h

"" remove trailing whitespace before saving
function! DeleteTrailingWS()
  let l = 1
  for line in getline(1,"$")
      call setline(l, substitute(line, '\s\+$', '', "g"))
      let l = l + 1
  endfor
  %s/\s\+$//e
endfunction

"" But DO NOT do this for markdown since three spaces are a linebreak here.
autocmd BufWrite * if &ft!~?'markdown'|:call DeleteTrailingWS()|endif

"
"" Close all buffers except the current one
command! Bufonly silent :w | %bd | e#
command! Bonly Bufonly

"" keyboard mappings ##########################################################

"" Remap leader to space (Note: This affects MANY mappings!)
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

"" Use gb and gB to cycle through open buffers
nnoremap gb :<C-U>execute v:count1.'bnext'<cr>
nnoremap gB :<C-U>execute v:count1.'bprevious'<cr>
"" open buffer from wildmenu
nnoremap <leader>ob :buffer *
"" close current buffer while keeping the window open
nnoremap <leader>cb :Bclose<cr>

"" toggle fold with <leader><space>, i.e. space twice
nnoremap <leader><Space> za

" Add newlines without insert mode.
nnoremap <leader><cr> o<Esc>

" Toggle search highlight
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Allow saving of files as root when forgotten to start vim using sudo.
cmap w!! w !sudo tee > /dev/null % <cr>

"" PLUGIN-specific config and key mappings ####################################
"" Note: plugin config for language-specific plugins is in ftplugin/LANGUAGE.vim

"" NERDTree
map <leader>N :NERDTreeToggle<CR>
autocmd FileType nerdtree set nonumber norelativenumber

"" tmux stuff: This is configured to work with byobu default keybindings
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


"" airline #####################
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t'

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

"" ######################

" vim-fugitive
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

"" Grepper
nnoremap <leader>Gg :Grepper -tool git<cr>
nnoremap <leader>Ga :Grepper -tool ag<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
let g:grepper = {}
let g:grepper.tools = ['ag', 'git', 'grep']


"" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

"" vim-rooter: Switch to file directory for non-project files
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
let g:rooter_use_lcd = 1
let g:rooter_patterns = ['Makefile', '.git/']

"" vim-test
nmap <silent> <leader>tv :TestVisit<cr>
nmap <silent> <leader>tf :TestFile<cr>
nmap <silent> <leader>ts :TestSuite<cr>
