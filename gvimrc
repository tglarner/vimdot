syntax enable
"" Molokai colorscheme
""  Note: The variables have to be set before setting the colorscheme
""        to take effect
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

set guifont=Noto\ Mono\ Regular\ 12
"" No blinking cursor in gvim please.
set guicursor=a:blinkon0

"" set guioptions
"  a: autoselect
"  i: use vim icon
"  r: right-hand scrollbar is always present
"  L: left-hand scrollbr present when vsplit is there
"  t:
set guioptions=airL
set guioptions-=MT
