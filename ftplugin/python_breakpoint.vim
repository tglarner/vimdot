
"" automatically set a breakpoint in front of the current line with F8
function! python_breakpoint#BreakpointLine()
  let python_version = split(system('python --version'))[1]
  if split(python_version, '\.')[1] >= 7
    let breakpoint_line = 'breakpoint()'
  else
    "" python 3.6.X has no breakpoint() builtin
    let breakpoint_cmd = $PYTHONBREAKPOINT
    if ''.breakpoint_cmd == ''
      let breakpoint_line = 'import pdb; pdb.set_trace()'
    else
      let debugger_lib = 'import '.split(breakpoint_cmd, '\.')[0]
      let breakpoint_line = ''.debugger_lib.'; '.breakpoint_cmd.'()'
    endif
  endif
  return breakpoint_line
endfunction

function! python_breakpoint#DelBreakpointLine()
    let remove_pattern =  '^\s*'.escape(python_breakpoint#BreakpointLine(), '\\/.*$^~[]').'$'
    let del_breakpoint_cmd = 'g/'.remove_pattern.'/d'
    return del_breakpoint_cmd
endfunction

nmap <silent> <leader>bs O<C-r>=python_breakpoint#BreakpointLine()<cr><Esc>:w<bar>:noh<cr>
noremap <leader>bd :exec python_breakpoint#DelBreakpointLine() <bar> noh<cr>
"" PLUGIN config ##############################################################
