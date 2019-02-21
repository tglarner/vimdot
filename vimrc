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

"" Molokai Colorscheme (but with ugly ErrorMsg and WarnMsg)
Plug 'tglarner/molokai'

"" gruvbox colorscheme
Plug 'morhetz/gruvbox'

"" Improved grepping
Plug 'mhinz/vim-grepper'

"" Set working dir to project root
""  Automatically switches to the next toplevel dir that contains a .git dir
""  when in a project but can be configured to look e.g. for Makefile, etc...
Plug 'airblade/vim-rooter'

"" NERDTree with git status flags
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'

"" Powerline: Better status line
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

"" git integration
Plug 'tpope/vim-fugitive'

"" vim-test: Run your tests at the speed of thought
Plug 'janko-m/vim-test'

"" Python plugins -------------------------------------------------------------

"" Improved python indenting
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

"" Improved folding
Plug 'tmhedberg/SimpylFold', {'for': 'python' }

"" ALE: Asynchronous Lint Engine -> Syntax and style checks
Plug 'w0rp/ale', { 'for': 'python' }

"" Jedi: Static code analysis, goto  and autocompletion for python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

"" LaTeX plugins --------------------------------------------------------------

""  LaTeX mode
Plug 'lervag/vimtex', { 'for': 'tex' }

"" Mapping plugins ------------------------------------------------------------

""" Repeat the last compound mapping with . operator
""  This is useful for plugin mappings and user-defined mappings
Plug 'tpope/vim-repeat'

"" Easily modify surroundings: parens, braces, brackets, quotes, tags
""  This provides the verbs cs, ds, ys (change, delete, yank surrounding)
""  and the noun (text object) t for tag
Plug 'tpope/vim-surround'

"" Easily comment out lines with keymapping
Plug 'tpope/vim-commentary'

"" Support CamelCase and snake_case motion objects
""  uses <leader>w as subword noun and allows all parts of
""  ThisIdentifierTypicalForJava or this_function_name to be navigatable.
Plug 'bkad/CamelCaseMotion'

"" Indent objects just right for python
""  provides ii, ai, iI, aI text objects for Indentations
Plug 'michaeljsmith/vim-indent-object'

"" Wrap and unwrap function arguments, lists, dicts, etc... programmatically
Plug 'FooSoft/vim-argwrap'

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
set showmode                      "" Show the mode (insert,replace,etc.)
set nostartofline                 "" Keep horz cursor pos for vert. movement.
set showmatch                     "" Show matching braces.
set wildmode=longest,list,full    "" Switch to better tab completion
set wildmenu
set autoindent                    "" Automatic indenting.
set backspace=indent,eol,start    "" Natural backspace in insert mode.
set expandtab shiftwidth=2 softtabstop=2
set signcolumn=yes                "" Always keep the gutter open.

set colorcolumn=80                "" Highlight column 80 to dark grey
hi ColorColumn ctermbg=darkgrey guibg=darkgrey
hi Normal ctermbg=none
hi NonText ctermbg=none

"" Switch to absolute line number if in insert mode, out-of-focus
"" or if the buffer is left e.g. by switching windows
"" Source: https://jeffkreeftmeijer.com/vim-number/
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

"" git commit messages:
autocmd Filetype gitcommit setlocal spell textwidth=80

"" Map quit to normalmode q in help files
augroup MapQuitInHelp
    autocmd! MapQuitInHelp
    autocmd Filetype help nnoremap <buffer> q :q!<cr>
augroup END

"" Useful commands and functions #############################################

""Source this vimrc file from wherever
command! Sorc :exec 'source '.g:vimrc
command! Edrc :exec 'tabe  '.g:vimrc

"" CDC = Change to directory of current file and print destination
command! CDC cd %:p:h

"" Cycle through completions with TAB (and SHIFT-TAB cycles backwards).
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr>

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

"" keyboard mappings ##########################################################
"" Remap leader to space (Note: This affects MANY mappings!)
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

"" toggle fold with <leader><space>, i.e. space twice
noremap <leader><Space> za

"" Cycling through Windows quicker.
map <C-M> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <A-Down>  <C-W><Down><C-W>_
map <A-Up>    <C-W><Up><C-W>_
map <A-Left>  <C-W><Left><C-W>|
map <A-Right> <C-W><Right><C-W>|

" Add newlines without insert mode.
nmap <cr> o<Esc>

" Allow saving of files as sudo when forgotten to start vim using sudo.
cmap w!! w !sudo tee > /dev/null % <cr>

"" PLUGIN-specific config and key mappings ####################################
"" Note: plugin config for python-specific plugins is in ftplugin/python.vim

"" gruvbox colorscheme
let g:gruvbox_contrast_dark='soft'

"" NERDTree
map <leader>N :NERDTreeToggle<CR>
autocmd FileType nerdtree set nonumber norelativenumber

" vim-fugitive
nmap <leader>gb :Gblame<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gpu :Git push
nmap <leader>gpl :Git pull
nmap <leader>gc :Gcommit
nmap <leader>gt :Gtabedit
nmap <leader>ge :Gedit
nmap <leader>gm :Gmove
nmap <leader>gr :Gread
nmap <leader>gw :Gwrite

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

"" vimtex
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
