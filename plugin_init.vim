"" VIM-PLUG ##############################################################
"" add plugins with vim-plug
"" Install new plugins by typing :PlugInstall after sourcing the vimrc file

"" This fucntion allows loading conditioned on variables.
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Download vim-plug
if empty(glob(g:vimdir.'autoload/plug.vim'))
  let b:plug_github='https://raw.github.com/junegunn/vim-plug'
  let b:plug_url=b:plug_github.'/master/plug.vim'
  let b:plug_destination=g:vimdir.'autoload/plug.vim'

  silent exec '!mkdir -p '.g:vimdir.'/autoload'
  silent exec '!curl -fLo '.b:plug_destination.' '.b:plug_url
  if v:shell_error
    echo 'Automatically installing VimPlug using curl has failed.'
    echo 'VimPlug needs to be manually downloaded from '.b:plug_github
    echo 'and placed in '.g:vimdir.'/autoload in order to work.'
    finish
  endif
endif

call plug#begin(g:vimdir.'plugged')

"" vim-dirvish: non-buggy alternative to netrw and '-' binding works
Plug 'justinmk/vim-dirvish'

"" vim unix command improvements
Plug 'tpope/vim-eunuch'

"" vim session management
Plug 'tpope/vim-obsession'

"" Close buffers without closing windows with Bclose
Plug 'rbgrouleff/bclose.vim'

"" Molokai Colorscheme (but with ugly ErrorMsg and WarnMsg)
Plug 'tglarner/molokai'

"" fzf: the fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"" imporve fzf handling of ag command
Plug 'jesseleite/vim-agriculture'

"" tmux support
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'

"" Set working dir to project root
""  Automatically switches to the next toplevel dir that contains a .git dir
""  when in a project but can be configured to look e.g. for Makefile, etc...
Plug 'airblade/vim-rooter'

"" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" IDE features ---------------------------------------------------------------
"" git integration
Plug 'tpope/vim-fugitive'
"" github integration, needs fugitive
Plug 'tpope/vim-rhubarb'

"" vim-test: Run your tests at the speed of thought
Plug 'janko-m/vim-test'

"" Debugger support
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'idanarye/vim-vebugger'

"" Asynchronous invocation of make with :Make[!]
Plug 'tpope/vim-dispatch'


"" LANGUAGESERVER STUFF:
"" ALE: Asynchronous Lint Engine -> Syntax and style checks, language server
Plug 'dense-analysis/ale'

"" Non-Annoying Language Client
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
"" Use ALE and vim-lsp with a single pyls instance
Plug 'rhysd/vim-lsp-ale'

if has('nvim')
"" deoplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
  Plug 'deathlyfrantic/deoplete-spell'
endif



"" Mapping plugins ------------------------------------------------------------

""" Repeat the last compound mapping with .
""  This is useful for plugin mappings and user-defined mappings
Plug 'tpope/vim-repeat'

"" Easily modify surroundings: parentheses, braces, brackets, quotes, tags
""  This provides the verbs cs, ds, ys (change, delete, yank surrounding)
""  and the noun (text object) t for tag
Plug 'tpope/vim-surround'

"" Easily comment out lines with key mapping
Plug 'tpope/vim-commentary'

"" Paired mappings, mostly []-based
Plug 'tpope/vim-unimpaired'

"" Support CamelCase and snake_case motion objects
""  uses <leader>w as sub-word noun and allows all parts of
""  ThisIdentifierTypicalForJava or this_function_name to be navigable.
Plug 'bkad/CamelCaseMotion'

"" repeatable motions: Repeat last motion with
"" <C-h>: backward / <C-l>: forward
Plug 'vim-scripts/repeatable-motions.vim'

"" Indent objects just right for python
""  provides ii, ai, iI, aI text objects for Indentations
Plug 'michaeljsmith/vim-indent-object'

"" Wrap and unwrap function arguments, lists, dicts, etc... programmatically
"" command defined below: <leader>aw to toggle argument wrapping.
Plug 'FooSoft/vim-argwrap'

Plug 'PeterRincker/vim-argumentative'

"" Python plugins -------------------------------------------------------------

"" Improved python indenting
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

"" Text objects for python functions (af, if) and classes (ac, ic)
"" as well as working section movements (for classes)
"" and ]m movements (for methods or functions).
Plug 'jeetsukumaran/vim-pythonsense', {'for': 'python' }

"" Improved folding
Plug 'tmhedberg/SimpylFold', {'for': 'python' }

"" LaTeX plugins --------------------------------------------------------------

""  LaTeX mode
Plug 'lervag/vimtex', { 'for': 'tex' }

"" Writing Style plugins ------------------------------------------------------

"" Improve technical writing.
"" See http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/
Plug 'davidbeckingsale/writegood.vim', { 'for': [ 'tex', 'rst', 'markdown' ] }

"" Todo Lists  ----------------------------------------------------------------
Plug 'aserebryakov/vim-todo-lists'

call plug#end()
