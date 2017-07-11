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
Plugin 'scrooloose/nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'Chiel92/vim-autoformat'
"Plugin 'Shougo/vimproc.vim'
"Plugin 'Shougo/unite.vim'
if v:version > 703
    Plugin 'Valloric/YouCompleteMe'
end

Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()  
filetype plugin indent on

"==== basic settings
let mapleader=","

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

command Pdb :call append('.', 'import pdb;pdb.set_trace()')
command Ipdb :call append('.', 'import ipdb;ipdb.set_trace()')

nmap ;p :Ipdb<CR>

nnoremap ;q :q!<CR>

au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
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
let g:syntastic_python_python_exec='python'

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
let g:ycm_python_binary_path = 'python'
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
let Tlist_Ctags_Cmd="$(which ctags)" 
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


"==== powerline
let g:powerline_pycmd='py'
let g:powerline_pyeval='pyeval'

"set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h15
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set t_Co=256
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
set term=xterm-256color
