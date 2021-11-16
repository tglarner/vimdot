" Used for <Plug>(dovish_delete)
function! g:DovishDelete(target) abort
  return 'rm -r ' . a:target
endfunction
