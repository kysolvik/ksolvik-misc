" Vimrc
" Kylen Solvik
" Mostly from: https://dougblack.io/words/a-good-vimrc.html

" Set leader --------------------------------------------------
let mapleader=","                             " leader is comma
let maplocalleader="]"                             " localleader is ]

" Colors ------------------------------------------------------
syntax enable                        " enable syntax processing

" Spaces/Tabs -------------------------------------------------
set tabstop=4                 " number of visual spaces per TAB
set softtabstop=4        " number of spaces in tab when editing
set expandtab                                 " tabs are spaces
set shiftwidth=4                         " set indent size to 4

" UI Config ---------------------------------------------------
set relativenumber                 " show relative line numbers
set number                           " show current line number
set ruler                                   " show clumn number
set showcmd                        " show command in bottom bar
set cursorline                         " highlight current line
filetype indent on        " load filetype-specific indent files
set wildmenu             " visual autocomplete for command menu
set lazyredraw                        " redraw only when needed
set showmatch                       " highlight matching [{()}]

" Comment -----------------------------------------------------
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Searching ---------------------------------------------------
set incsearch                " search as characters are entered
set hlsearch                                " highlight matches

" Movement ----------------------------------------------------
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" new commands for moving to beginning/end of line
nnoremap B ^
nnoremap E $

" Folding -----------------------------------------------------
nnoremap <leader><tab> za

" Fancy keybindings -------------------------------------------
" jk is escape
inoremap jk <esc>
"space saves
nnoremap <space> :w<CR>
nnoremap <leader><space> :q<CR>
" Copy and paste modes (Copy/Paste Mode, Copy/Paste Off)
nnoremap <leader>cm :set nonu norelativenumber<CR>
nnoremap <leader>co :set nu relativenumber<CR>
nnoremap <leader>pm :set paste<CR>
nnoremap <leader>po :set nopaste <CR>


" Vim-Plug ----------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Syntastic
Plug 'vim-syntastic/syntastic'

" VimCompletesMe
Plug 'ajh17/VimCompletesMe'

" vimtex
Plug 'lervag/vimtex'

" Python-mode
Plug 'python-mode/python-mode'
let g:pymode_python = 'python3'
set completeopt=menu " Prevent annoying doc popup.
let g:pymode_rope_complete_on_dot = 0 " Only autocomplete on tab.

" Vim Airline
Plug 'vim-airline/vim-airline'

" Initialize plugin system
call plug#end()
