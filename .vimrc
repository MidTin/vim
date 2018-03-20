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
Plugin 'vim-scripts/DrawIt'
Plugin 'rking/ag.vim'

if v:version > 703
    Plugin 'Valloric/YouCompleteMe'
end

Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}


"=== Plugin for markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'iamcco/markdown-preview.vim'

"=== Plugin for ReStructuredText
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'

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

if has("gui_macvim")
    set noimd
    set imi=2
    set ims=2
endif

filetype plugin on

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

command Pdb :call append('.', 'import pdb;pdb.set_trace()')
command Ipdb :call append('.', 'import ipdb;ipdb.set_trace()')

nmap ;p :Ipdb<CR>

nnoremap ;q :q!<CR>
nnoremap ;n :lnext<CR>
nnoremap ;N :lprevious<CR>
nmap ;di :DIstart<CR>
nmap ;ds :DIstop<CR>

"====== Custom functions

function! s:InsertPyEncoding(encode)
    let s:cursor_pos = getcurpos()[1:]
    call cursor(1, 1)
    put! = '# -*- coding: ' . a:encode . ' -*-'
    call cursor(s:cursor_pos)
endfunction

"==== end

command! InsertUTF8 :call <SID>InsertPyEncoding('utf-8')
nmap ;8 :InsertUTF8<CR>

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
let NERDTreeIgnore=['.idea', '.git$', '\.swp', '__pycache__', '\.pyc$', '\.orig$', '.python-version']
let NERDTreeShowHidden=1

"==== syntastic settings
let g:syntastic_python_checkers=['pylama']
let g:syntastic_python_pylama_args='-l pep8,mccabe,pylint'
let g:syntastic_python_pylama_args='-i E402,W0311,E111,E121,E114,C901,E501,W0401'
let g:syntastic_python_python_exec='python'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"PHP
let g:syntastic_php_checkers=['php']
let g:syntastic_check_on_open=1

"ReStructuredText
let g:syntastic_rst_checkers=['rstcheck']
let g:syntastic_rst_sphinx_source_dir='.'

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

"==== Color Scheme
if has('gui_running')
   set background=dark
   colorscheme solarized
endif

"==== ctrlp
let g:ctrlp_map='<c-p>'


"==== powerline
let g:powerline_pycmd='py'

"set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h15
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set t_Co=256
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
set term=xterm-256color
set laststatus=2 " Always display the statusline in all windows
"set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

"==== autoformat
noremap <F3> :Autoformat<CR>
let g:autoformat_autoindent=0
let g:formatdef_custom_yapf="'yapf --style=\"{based_on_style: pep8, ALLOW_SPLIT_BEFORE_DICT_VALUE: false, BLANK_LINE_BEFORE_NESTED_CLASS_OR_DEF: 1, COLUMN_LIMIT: 80}\"'"
let g:formatters_python=['custom_yapf']


"==== vim-markdown
"let g:vim_markdown_new_list_item_indent = 2
nmap <silent> <F9> :Toc<CR>
let g:vim_markdown_folding_disabled = 1


"=== vim-table-mode
let g:table_mode_corner='|'


"=== vim-markdown-toc
"let g:vmt_dont_insert_fence = 1
nmap <leader>cto :GenTocGFM<CR>


"=== markdown-preview
let g:mkdp_auto_open = 0
let g:mkdp_auto_close = 1
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
let g:mkdp_auto_start = 0


"=== InstantRst
let g:instant_rst_localhost_only=1


"=== ag.vim
let g:ag_highlight=1
