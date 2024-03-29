"" keyboard mappings ##########################################################

"" Remap leader to space (Note: This affects MANY mappings!)
nnoremap <Space> <Nop>
let mapleader = "\<Space>"

"" remap ö and ä in all but insert modes to [ and ]
nmap ö [
xmap ö [
omap ö [
nmap ä ]
xmap ä ]
omap ä ]

function! MakeBracketMaps()
    nnoremap <silent><nowait><buffer> öö :<c-u>exe 'normal '.v:count.'[['<cr>
    nnoremap <silent><nowait><buffer> öä :<c-u>exe 'normal '.v:count.'[]'<cr>
    nnoremap <silent><nowait><buffer> äö :<c-u>exe 'normal '.v:count.']['<cr>
    nnoremap <silent><nowait><buffer> ää :<c-u>exe 'normal '.v:count.']]'<cr>
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType * call MakeBracketMaps()
augroup END


"" unmap <F1> (hard-coded to help, very annoying, does not work in byobu)
map <F1> <nop>
imap <F1> <nop>

"" Remap backspace to Ctrl-caret (i.e. go back to previous buffer)
map <BS> <C-^>

"" Cycle through open buffers easier
"" (aliases for unimpaired mappings)
nnoremap <silent> <C-PageDown> :bnext<cr>
nnoremap <silent> <C-PageUp> :bprevious<cr>
nnoremap <silent> <C-S-PageDown> gt
nnoremap <silent> <C-S-PageUp> gT

"" open named buffer from wildmenu
set wildcharm=<C-Z>
nnoremap <leader>bn :buffer<Space><C-Z>

"" open buffer from buffer list
nnoremap <leader>bo :buffers<cr>:buffer<Space>

"" toggle fold with <leader><space>, i.e. space twice
nnoremap <leader><Space> za

" Add newlines without insert mode.
nnoremap <leader><cr> o<Esc>

" Allow saving of files as root when forgotten to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null % <cr>

" Write and close buffer
function! WriteAndCloseBuffer()
  w
  bd
endfunction

command! WC :call WriteAndCloseBuffer()

" Use %% to specify the directory of the current buffer
"" (source: 'Practical Vim', Tip 41)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'


"" Search for current selection with * when in visual mode
"" (source: 'Practical Vim', Tip 86)
function! s:VSetSearch()
  let temp = @s
  normal! gv"sy
  let @/ = '\V'.substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch()<cr>/<C-R>=@/<cr><cr>
xnoremap # :<C-u>call <SID>VSetSearch()<cr>?<C-R>=@/<cr><cr>


"" Fix the & command: Repeat last substitution command with flags
"" (source: 'Practical Vim', Tip 91)
nnoremap & :&&<cr>
xnoremap & :&&<cr>

"" Fix movement in :wrap buffers (e.g. tex):
"" j and k move on visual lines (i.e. rows) instead of (logical) lines
"" (source: https://blog.sanctum.geek.nz/category/vim/)
nnoremap j gj
nnoremap k gk
"" but use gj, gk for movement based on (logical) lines:
nnoremap gj j
nnoremap gk k

