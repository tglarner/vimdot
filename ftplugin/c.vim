"" Toggle between .h and .cpp with F4.
function! ToggleBetweenHeaderAndSourceFile()
  let bufname = bufname("%")
  let ext = fnamemodify(bufname, ":e")
  if ext == "hpp"
    let ext = "cpp"
  elseif ext == "cpp"
    let ext = "hpp"
  elseif ext == "h"
    let ext = "c"
  elseif ext == "c"
    let ext = "h"
  else
    return
  endif
  let bufname_new = fnamemodify(bufname, ":r") . "." . ext
  let bufname_alt = bufname("#")
  if bufname_new == bufname_alt
    execute ":e#"
  else
    execute ":e " . bufname_new
  endif
endfunction
map <silent> <F4> :call ToggleBetweenHeaderAndSourceFile()<CR>

"" Make sure == also indents #ifdef etc.
noremap <silent> == IX<ESC>==:.s/X//<CR>:nohlsearch<CR>

"" Toggle encoding with F12.
function! ToggleEncoding()
  if &encoding == "latin1"
    set encoding=utf-8
  elseif &encoding == "utf-8"
    set encoding=latin1
  endif
endfunction
map <silent> <F12> :call ToggleEncoding()<CR>

"" Next / previous error with Tab / Shift+Tab.
map <silent> <Tab> :cn<CR>
map <silent> <S+Tab> :cp<CR>
map <silent> <BS><Tab> :cp<CR>


