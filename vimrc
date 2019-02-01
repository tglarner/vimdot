" auto file type detection
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

"" VIM-PLUG ##############################################################
"" add plugins with vim-plug
"" VimPlug needs to be manually downloaded from
"" https://github.com/junegunn/vim-plug
"" and placed in ~/.vim/autoload in order to work.
call plug#begin('~/.vim/plugged')

"" Molokai Colorscheme (but with ugly ErrorMsg and WarnMsg)
Plug 'tglarner/molokai'

"" Set working dir to project root
""  Automatically switches to the next toplevel dir that contains a .git dir
""  when in a project but can be configured to look e.g. for Makefile, etc...
Plug 'airblade/vim-rooter'

"" NERDTree with git status flags
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'

"" git integration
Plug 'tpope/vim-fugitive'

"" vim-test: Run your tests at the speed of thought
Plug 'janko-m/vim-test'

"" ALE: Asynchronous Lint Engine -> Syntax and style checks
Plug 'w0rp/ale'

"" Jedi: Static code analysis, goto  and autocompletion for python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

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
set expandtab shiftwidth=2
set softtabstop=2
set colorcolumn=80                "" Highlight column 80 to light grey
hi ColorColumn ctermbg=235 guibg=#D0D0D0
hi Normal ctermbg=none
hi NonText ctermbg=none


"" Switch to absolute line number if in insert mode, out-of-focus
"" or if the buffer is left e.g. by switching windows
"" Source: https://jeffkreeftmeijer.com/vim-number/
let toggle_ignore = ['nerdtree', 'help']
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

let g:tex_flavor='latex'
" autocmd Filetype tex set
"     \ tabstop=2
"     \ softtabstop=2
"     \ shiftwidth=2
"     \ expandtab
"     \ autoindent

"" Useful commands and functions #############################################
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

"" But DO Not do this for markdown since three spaces are a linebreak here.
autocmd BufWrite * if &ft!~?'markdown'|:call DeleteTrailingWS()|endif

"" create nice status line ####################################################
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

"" keyboard mappings ##########################################################
"" Remap leader to space (Note: This affects MANY mappings!)
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

"" Cycling through Windows quicker.
map <C-M> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <A-Down>  <C-W><Down><C-W>_
map <A-Up>    <C-W><Up><C-W>_
map <A-Left>  <C-W><Left><C-W>|
map <A-Right> <C-W><Right><C-W>|

" Allow saving of files as sudo when forgotten to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"" PLUGIN-specific config and key mappings ####################################
"" Note: python-specific config is in ftplugin/python.vim

"" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
  \ !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
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
nmap <silent> <F2> :TestVisit<cr>
nmap <silent> <F3> :TestFile<cr>
nmap <silent> <F4> :TestSuite<cr>
