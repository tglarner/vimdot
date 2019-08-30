"" Useful commands and functions #############################################

""Source/Edit this vimrc file from wherever
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

"" Close all buffers except the current one
command! Bufonly silent :w | %bd | e#
command! Bonly Bufonly
