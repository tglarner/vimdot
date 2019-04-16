"" Set specific presets for latex

set wrap 			" Most people use dynamic word wrap for latex
set linebreak
set textwidth=0
set wrapmargin=0
set colorcolumn= 		" colorcolumn is not useful here
set spell
set spelllang=en_us,de_de

set expandtab shiftwidth=2 softtabstop=2
"" PLUGIN config ##############################################################

"" vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'

let g:vimtex_fold_manually = 1
let g:vimtex_fold_enabled = 0
