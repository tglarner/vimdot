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


"" Condense multiple blank lines into a single one.
"" This is useful if a compy of an Email needs to be reformatted.
function! RemoveMultiBlanks()
  call DeleteTrailingWS()
  %s/\n\{3,}/\r\r/e
endfunction

command! RMMBlanks silent :call RemoveMultiBlanks()
