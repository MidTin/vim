"=======================================
" Base Settings
"=======================================
set nocompatible
filetype on

set autoindent
set background=light
set backspace=indent,eol,start
set expandtab
set fileencoding=utf-8
set fileencodings=utf-8
set history=20
set ignorecase
set incsearch
set nobackup
set nu
set ruler
set showmatch
set tabstop=4
syntax on

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg = 9
endif

"=======================================
" Commands
"=======================================
augroup ft
    autocmd!
    autocmd FileType python setlocal
      \ shiftwidth=4
      \ softtabstop=4
      \ tabstop=8

    autocmd FileType html setlocal
      \ shiftwidth=2
      \ softtabstop=2

    autocmd FileType yaml,yml setlocal
      \ shiftwidth=2
      \ softtabstop=2
augroup END

command! Pdb :call append('.', 'import pdb;pdb.set_trace()')
command! Ipdb :call append('.', 'import ipdb;ipdb.set_trace()')

augroup unset_folding_in_insert_mode
    autocmd!
    autocmd InsertEnter *.py setlocal foldmethod=marker
    autocmd InsertLeave *.py setlocal foldmethod=expr
augroup END


"=======================================
" Common Key Bindings
"=======================================
let mapleader = ","

nnoremap ;q :q!<CR>
nnoremap ;n :lnext<CR>
nnoremap ;N :lprevious<CR>
nnoremap <F5> :set hlsearch! hlsearch?<CR>
command! InsertUTF8 :call <SID>InsertPyEncoding('utf-8')
nmap ;8 :InsertUTF8<CR>
nmap ;p :Ipdb<CR>

" switch tabline
nnoremap ;<Tab> :bn<CR>
nnoremap ;<S-Tab> :bp<CR>



"=======================================
" Custom Functions
"=======================================

" insert encoding header
function! s:InsertPyEncoding(encode)
    let s:cursor_pos = getcurpos()[1:]
    call cursor(1, 1)
    put! = '# -*- coding: ' . a:encode . ' -*-'
    call cursor(s:cursor_pos)
endfunction





"=======================================
" vim-plug
" https://github.com/junegunn/vim-plug
"=======================================
call plug#begin('~/.vim/plugged')

" completion: https://github.com/ycm-core/YouCompleteMe
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer --js-completer' }

" syntastic checker https://github.com/scrooloose/syntastic
Plug 'scrooloose/syntastic'

" statusline: https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" file search: https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" themes: https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'

" file tree: https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree'

" outline viewer: https://github.com/majutsushi/tagbar
Plug 'majutsushi/tagbar'

" full text search: https://github.com/mileszs/ack.vim
Plug 'mileszs/ack.vim'

" code format: https://github.com/chiel92/vim-autoformat
Plug 'chiel92/vim-autoformat'

call plug#end()



"=======================================
" YouCompleteMe
"=======================================
" Python

pythonx << EOF
import vim
import json

sys_path_str = vim.eval('system("python -c \'import sys; print(sys.path)\'")')
vim.command('let g:ycm_python_sys_path=%s' % sys_path_str)

EOF

let g:ycm_python_interpreter_path = trim(system('which python'))
let g:ycm_extra_conf_vim_data = [
    \  'g:ycm_python_interpreter_path',
    \  'g:ycm_python_sys_path',
    \]
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'gitcommit': 1
    \}
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0

nnoremap <leader>g :YcmCompleter GoToDefinition<CR>
nnoremap <leader>f :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>



"=======================================
" vim-airline
"=======================================
set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h13.5

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
set noshowmode


"=======================================
" vim-ctrlp
"=======================================
let g:ctrlp_map='<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|(__pycache__)$',
  \ 'file': '\v\.(exe|so|dll|swp|pyc)$',
  \ }


"=======================================
" Color
"=======================================
colorscheme gruvbox


"=======================================
" vim-syntastic
"=======================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylama']
let g:syntastic_python_pylama_args='-l pyflakes,pep8,mccabe,pylint -i E403,W0311,E111,E121,E114,C901,E501,W0401'

let g:syntastic_yaml_checkers = ['yamlxs', 'jsyaml']


"=======================================
" NERDTreee
"=======================================
let NERDTreeIgnore=['.idea', '.git$', '\.swp', '__pycache__', '.vscode', '\.pyc$', '\.orig$', '.python-version']
let NERDTreeShowHidden=1
let NERDTreeNodeDelimiter="\u00a0"

nmap <leader>cf :NERDTreeFind<CR>
nnoremap <F7> :NERDTreeToggle<CR>


"=======================================
" vim-tagbar
"=======================================
nnoremap <silent> <F8> :TagbarToggle<CR>


"=======================================
" vim-tagbar
"=======================================
noremap <F3> :Autoformat<CR>

let g:autoformat_autoindent = 1
let g:formatdef_custom_yapf = "'yapf --style=\"{based_on_style: pep8, ALLOW_SPLIT_BEFORE_DICT_VALUE: false, BLANK_LINE_BEFORE_NESTED_CLASS_OR_DEF: 1, COLUMN_LIMIT: 80, SPACES_BEFORE_COMMENT: (15,20), }\"'"
let g:formatters_python = ['custom_yapf']
