"" auto file type detection
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

"" Set proper vim directory
if (has('win32') || has('win64')) && &shellcmdflag =~ '/'
  let g:vimdir='~/vimfiles/'
else
  let g:vimdir='~/.vim/'
endif
let g:vimrc = g:vimdir.'vimrc'

exec 'source '.g:vimdir.'plugin_init.vim'
exec 'source '.g:vimdir.'editor_settings.vim'
exec 'source '.g:vimdir.'commands.vim'
exec 'source '.g:vimdir.'keymaps.vim'
exec 'source '.g:vimdir.'plugin_config.vim'
