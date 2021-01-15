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

"" Important: If neovim is used and reports that no python provider was found,
"" install the neovim python package with
"" $> python -m pip install pynvim
"" Make sure that the desired environment is activated!
runtime plugin_init.vim
runtime editor_settings.vim
runtime commands.vim
runtime keymaps.vim
runtime plugin_config.vim
