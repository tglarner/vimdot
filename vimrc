" auto file type detection
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

"" Syntax highlighting, but only for color terminals.
if &t_Co > 1
  syntax enable
endif

" set appropriate color schemes
if has("gui_running")
  colorscheme slate
  set guifont=Monospace\ Regular\ 12
  set guifontwide=
  set go=agimrLtT
  "" No blinking cursor in gvim please.
  set guicursor=a:blinkon0
else
  colorscheme industry
endif

"no need to be compatible with vi and lose features.
set nocompatible

"" Set update time to 750 ms , convenient for taglist.vim.
set updatetime=750

"" After this many msecs do not imap.
set timeoutlen=500

"" VIM-PLUG ##############################################################
"" add plugins with vim-plug
"" VimPlug needs to be manually downloaded from
"" https://github.com/junegunn/vim-plug
"" and placed in ~/.vim/autoload in order to work.
call plug#begin('~/.vim/plugged')

"NERDTree with git status flags
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'

"Supprot CamelCase and snake_case motion objects
Plug 'bkad/CamelCaseMotion'

"Set working dir to project root
Plug 'airblade/vim-rooter'

"Easy management of ctags
"" Don't forget to modify the PATH variable
"" if the ctags plugins shall work with universal ctags
Plug 'xolox/vim-misc'
""Plug 'xolox/vim-easytags'    " original does not work with universal-ctags
""Plug 'tglarner/vim-easytags'

"Tagbar displaying ctags content
"Plug 'majutsushi/tagbar'

"git integration
Plug 'tpope/vim-fugitive'

"" syntastic: Syntax checker for vim (Use ALE instead!)
"" note: Check env activation if the syntax checker for python malfunctions
"Plug 'vim-syntastic/syntastic'

"Python IDE environment (Does not work currently)
"Plug 'python-mode/python-mode', { 'branch': 'develop' }

"" Indent objects just right for python
Plug 'michaeljsmith/vim-indent-object'

"" ALE: Asynchronous Lint Engine -> Syntax and style checks
Plug 'w0rp/ale'

"" Jedi: Static code analysis, goto  and autocompletion for python
Plug 'davidhalter/jedi-vim'

"" vim-test: Run your tests at the speed of thought
Plug 'janko-m/vim-test'

Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

"" END VIM-Plug ##########################################################

"" Do not show any line of minimized windows
set wmh=0

"" Natural splits
set splitbelow
set splitright

"" Disable any swap and backup files
set noswapfile
set nobackup
set nowb

" show command info (e.g. leader key)
set showcmd

" nicer search
set hlsearch
set incsearch
set ignorecase

"Adjust colors to be readable on a dark background
set background=dark

"" Set text width to 80, this implies word wrap.
set textwidth=80

"" Do not break long lines.
set nowrap

"" Highlight column 80 to light grey
set colorcolumn=80
hi ColorColumn ctermbg=235 guibg=#D0D0D0

"" Show hybrid line numbers.
set number relativenumber

"" Switch to absolute line number if in insert mode, out-of-focus
"" or if the buffer is left e.g. by switching windows
"" Source: https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END


"" Always show the name of the file being edited.
set ls=2

"" Show the mode (insert,replace,etc.)
set showmode

"" Keep the horizontal cursor position when moving vertically.
set nostartofline

"" Show matching braces.
set showmatch

"" remove trailing whitespace before saving
function! DeleteTrailingWS()
  let l = 1
  for line in getline(1,"$")
      call setline(l, substitute(line, '\s\+$', '', "g"))
      let l = l + 1
  endfor
  %s/\s\+$//e
endfunction

"" But DO Not do this for markdown since three spaces are a linebreak here.
autocmd BufWrite * if &ft!~?'markdown'|:call DeleteTrailingWS()|endif

"" listchars sets replacements for normally invisible characters in list mode
"" set listchars=eol:$,extends: ,trail: ,tab: >

"" Switch to better tab completion
set wildmode=longest,list,full
set wildmenu

"" Automatic C-style indenting.
set autoindent
"" Smart indentation
set smartindent

"" When inserting tabs replace them with the appropriate number of spaces
set expandtab
set shiftwidth=2
set softtabstop=2

"This is for setting Makefiles with tabs not spaces
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

"" git commit messages:
autocmd Filetype gitcommit setlocal spell textwidth=80

let g:tex_flavor='latex'
" autocmd Filetype tex set
"     \ tabstop=2
"     \ softtabstop=2
"     \ shiftwidth=2
"     \ expandtab
"     \ autoindent
"" autocmd Filetype python match BadWhitespace /\s\+$/

"" Set ctags source for c(pp) projects
set tags=./.tags;

" create nice status line
function! HasFugitive()
  return exists('g:loaded_fugitive')&&fugitive#statusline()!=''
endfunction

set laststatus=2
"" add file information
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]
"" add git Branch if fugitive is there
set statusline+=\ [BRANCH=%{HasFugitive()?fugitive#statusline():'NONE'}]
"" add column and line number info
set statusline+=%=[%3v,\ %5l\ /\ %5L\ (%3p%%)]
hi StatusLine term=reverse ctermfg=0 ctermbg=2

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

"" Cycling through Windows quicker.
map <C-M> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <A-Down>  <C-W><Down><C-W>_
map <A-Up>    <C-W><Up><C-W>_
map <A-Left>  <C-W><Left><C-W>|
map <A-Right> <C-W><Right><C-W>|

"" Remap leader to space
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"" Update python ctags
"" PLUGIN config ############################################################
"" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
  \ !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"" Tagbar
"" map <F8> :TagbarToggle<CR>

"" CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

"" vim-rooter: Switch to file directory for non-project files
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 1
let g:rooter_use_lcd = 1
let g:rooter_patterns = ['Makefile', '.git/']


" vim-markdown-preview
let g:vim_markdown_preview_perl = 1


" easytags
" let g:easytags_cmd = '/home/tglarner/bin/ctags'
" let g:easytags_opts = ['--options=$HOME/.vim/ctags/']
" let g:easytags_by_filetype = '$HOME/.vim/tags'
" let g:easytags_asnc = 1
" let g:easytags_on_cursorhold = 0
" let g:easytags_suppress_report = 1
" let g:easytags_event = ['BufWritePost']


" vim-fugitive
nmap <leader>gb :Gblame<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gpl :Git push
nmap <leader>gpu :Git pull
nmap <leader>gc :Gcommit
nmap <leader>gt :Gtabedit
nmap <leader>ge :Gedit
nmap <leader>gm :Gmove
nmap <leader>gr :Gread
nmap <leader>gw :Gwrite
