" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim
"
"-----------------------------------------------
"  => Appearance
"-----------------------------------------------
set nu
set rnu
set ruler
set clipboard=unnamed	" share clipboard with windows
set cursorline			" 游標底線
syntax enable			" 打開語法高亮
set noeb
set autochdir			" 自動到目前資料夾
set wrap				" 摺行
set linebreak			" 以字為單位摺行
set showcmd				" 右下角顯示指令
set tabstop=4
"set scrolloff=3
set smartcase
"
"------------------------------------------------
"  => Filetype
"------------------------------------------------
filetype on
filetype indent on
filetype plugin on
"
"------------------------------------------------
"  => Color configuration
"------------------------------------------------
syntax on
set bg=dark
set t_Co=256
try
	color  hybrid
catch
	color evening  " Same as :colorscheme evening
	hi CursorLineNr cterm=bold ctermfg=Green ctermbg=NONE
	hi LineNr cterm=bold ctermfg=DarkGrey ctermbg=NONE		"數字行
	hi CursorLine cterm=none ctermbg=DarkMagenta ctermfg=White	"游標行
endtry
"
"===============================================
"  => Vim-pulg
"===============================================
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Windows): '~/vimfiles/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'w0ng/vim-hybrid'
Plug 'scrooloose/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'neoclide/coc.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tomtom/tcomment_vim'
"
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"
Plug 'vim-scripts/taglist.vim'
"
"Plug 'bfrg/vim-cpp-modern'
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
"
"-----------------------------------------------
"  => vim-airline
"-----------------------------------------------
let g:airline_powerline_fonts = 1		" 顯示造型需要 powerline funts 字體
let g:airline#extensions#tabline#enabled = 1	" tab line
"
"-----------------------------------------------
"  => key-remap
"-----------------------------------------------
nnoremap <silent> <F2> :NERDTreeToggle<Enter>
"
"-----------------------------------------------
"  => vim-cpp-modern
"-----------------------------------------------
" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 1
" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1
" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1
" Put all standard C and C++ keywords under Vim's highlight group 'Statement' " (affects both C and C++ files)
let g:cpp_simple_highlight = 1
"Highlighting of class scope is disabled by default. To enable set
let g:cpp_class_scope_highlight = 1
"Highlighting of member variables is disabled by default. To enable set
let g:cpp_member_variable_highlight = 1
"
"-----------------------------------------------
"  => coc.nvim
"-----------------------------------------------
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
"
"-----------------------------------------------
"  => grep
"-----------------------------------------------
:set grepprg=grep\ -nH\ $*
:set grepformat=%f:%l:%c:%m
"
"
"
"-----------------------------------------------
"  => Taglist 
"-----------------------------------------------
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
nnoremap <F8> :TlistToggle<CR>
"
"
"
"-----------------------------------------------
"-----------------------------------------------
"-----------------------------------------------
" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

