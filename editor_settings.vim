"" Set environment behavior ###################################################

"" Syntax highlighting, but only for color terminals.
if &t_Co > 1
  syntax enable
  "" Molokai color scheme
  ""  Note: The variables have to be set before setting the color scheme
  ""        to take effect
  let g:molokai_original = 1
  let g:rehash256 = 1
  colorscheme molokai
endif

"" Remove vi backwards compatibility (enables some vim features)
set nocompatible

"" Set update time to 750 ms, convenient for taglist.vim.
set updatetime=750

"" Set wait times between...
set timeoutlen=500                "" keys of a mapping
set ttimeoutlen=10                "" key code parts of terminal key transmission

set encoding=utf-8                "" This is the display encoding
set wmh=0                         "" Do not show any line of minimized windows
set splitbelow splitright         "" Natural splits
set noswapfile nobackup nowb      "" Disable any swap and backup files
set showcmd                       "" show command info (e.g. leader key)
set hlsearch incsearch ignorecase "" nicer search
set textwidth=80                  "" static text width inc. static wrap
set nowrap                        "" Do not break long lines.
set number relativenumber         "" Show hybrid line numbers.
set ls=2                          "" Always show status line.
set noshowmode                    "" Not needed with airline: Don't show mode.
set nostartofline                 "" Keep horz cursor pos for vert. movement.
set showmatch                     "" Show matching braces.
set wildmenu                      "" Switch to better tab completion
set wildmode=longest:list,full
set completeopt=longest,menuone   "" Improve completion menu behaviour
set autoindent                    "" Automatic indenting.
set backspace=indent,eol,start    "" Natural backspace in insert mode.
set expandtab shiftwidth=2 softtabstop=2
set signcolumn=yes                "" Always keep the gutter open.

set colorcolumn=80                "" Highlight column 80 to dark grey
hi ColorColumn ctermbg=darkgrey guibg=darkgrey
hi Normal ctermbg=none
hi NonText ctermbg=none

set hidden                        "" Allow modified buffers without window

"" Switch to absolute line number if in insert mode, out-of-focus
"" or if the buffer is left e.g. by switching windows.
"" source: https://jeffkreeftmeijer.com/vim-number/
let toggle_ignore = ['nerdtree', 'help', 'fugitiveblame']
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave *
          \ if &number && index(toggle_ignore, &ft) < 0 |
          \   set relativenumber|endif
    autocmd BufLeave,FocusLost,InsertEnter *
          \ if &number && index(toggle_ignore, &ft) < 0 |
          \   set norelativenumber|endif
augroup END

"" Makefiles use tabs instead of spaces
augroup makesettings
  autocmd!
  autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
augroup END

"" git commit messages, email messages, etc.. :
augroup spellft
  autocmd!
  autocmd Filetype gitcommit,mail setlocal spell spelllang=en_us,de_de
    \ textwidth=75 colorcolumn=75
augroup END

"" Map quit to normalmode q in help files
augroup MapQuitInHelp
    autocmd! MapQuitInHelp
    autocmd Filetype help,qf,vim nnoremap <buffer> qq :q!<cr>
augroup END

augroup MapQuitInNetrw
    autocmd! MapQuitInNetrw
    autocmd Filetype netrw nnoremap <buffer> qq <C-^>
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
if !has('nvim')
  set ttymouse=xterm2
endif
set mouse=a

