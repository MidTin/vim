"==== Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'taglist.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'Shougo/vimproc.vim'
"Plugin 'Shougo/unite.vim'
if v:version > 703
    Plugin 'Valloric/YouCompleteMe'
end

call vundle#end()  
filetype plugin indent on

"==== Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"==== SimpylFold
let g:SimpylFold_docstring_preview = 1
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<

"==== basic settings
set nu
set backspace=indent,eol,start
set nobackup
set history=10
set ruler	"Always display the current cursor position in the lower right corner of the
            "Vim window.

set incsearch	"Display the match for a search pattern when halfway typing it.
set fileencoding=utf-8
set fileencodings=utf-8

set expandtab
set autoindent

set showmatch
set syntax=on
set background=dark
set ignorecase
set tabstop=4
set softtabstop=4
set shiftwidth=4

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

nnoremap ;q :q!<CR>

au BufNewFile,BufRead *.py
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |
\ set textwidth=80 |
\ set fileformat=unix |

au BufNewFile,BufRead *.js,*.html,*.css
\ set tabstop=2 |
\ set softtabstop=2 |
\ set shiftwidth=2 |

nnoremap <F5> :set hlsearch! hlsearch?<CR>

"==== NERDTree
map <F7> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\.orig$', '\~$'] "ignore files in NERDTree

"==== syntastic settings
let g:syntastic_python_checkers=['pylama']
let g:syntastic_python_pylama_args='-l pep8,mccabe,pylint'
let g:syntastic_python_pylama_args='-i W0311,E111,E121,E114,C901,E501'
let g:syntastic_python_python_exec='/usr/bin/python'

"PHP
let g:syntastic_php_checkers=['php']
let g:syntastic_check_on_open=1

"==== YouCompleteMe
"let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_autoclose_preview_window_after_insertion=1
"let g:ycm_add_preview_to_completeopt=0
set completeopt-=preview
let g:ycm_echo_current_diagnostic = 0
let g:ycm_key_detailed_diagnostics = 0
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"==== taglist
let Tlist_Auto_Highlight_Tag=1  
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1  
let Tlist_Display_Tag_Scope=1  
let Tlist_Exit_OnlyWindow=1  
let Tlist_Enable_Dold_Column=1  
let Tlist_File_Fold_Auto_Close=1  
let Tlist_Show_One_File=1  
let Tlist_Use_Right_Window=1  
let Tlist_Use_SingleClick=1  
let Tlist_Ctags_Cmd="/usr/local/Cellar/ctags/5.8/bin/ctags" 
nnoremap <silent> <F8> :TlistToggle<CR>

"==== Auto Reload
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

"==== Color Scheme
if has('gui_running')
   set background=dark
   colorscheme solarized
endif

"==== ctrlp
let g:ctrlp_map='<c-p>'
