" .vimrc
" Author: Zhou Shengsheng
" Date: 22/04/19

"=============================================================
" Basic
"=============================================================

" General Settings
set nocompatible
set mouse=a
set number
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set title
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.
" set visualbell
set ignorecase
set hlsearch
set incsearch
set autoread
set nobackup
set nowb
set noswapfile
set number
" set relativenumber
set modelines=2
set backspace=indent,eol,start
" set clipboard=unnamed
vnoremap <C-c> "*y"

" Colors
" Needed for Solarized colors to work correctly on local Mac
set background=light
" colorscheme solarized
let g:solarized_termcolors=256

highlight Search ctermfg=White ctermbg=Red
highlight LineNr ctermfg=10
" highlight CursorLineNr ctermfg=1

"=============================================================
" Vundle
"=============================================================

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-commentary.git'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'majutsushi/tagbar.git'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-syntastic/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ryanoasis/vim-devicons'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'jiangmiao/auto-pairs'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession' " Run in terminal: vim -u NONE -c \"helptags vim-obsession/doc\" -c q
" Plugin 'sjl/badwolf'

"=============================================================
" Plugin
"=============================================================

execute pathogen#infect()
syntax on
filetype plugin indent on

" NERDTree
" map <C-n> :NERDTree<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * NERDTree | wincmd p
autocmd StdinReadPre * let s:std_in=1

" miniBufExplorer
let g:miniBufExplMaxSize = 2
" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#CD5907 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#F1266F guibg=fg
hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg

" Tagbar
nnoremap <silent> <F8> :TagbarToggle<CR>

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" let g:syntastic_java_checkers = ['javac']
" let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkers = []
let g:syntastic_java_checkstyle_classpath = '/Users/shengsheng/3rd/checkstyle/checkstyle-8.14-all.jar'
let g:syntastic_java_checkstyle_conf_file = '/Users/shengsheng/3rd/checkstyle/checkstyle.xml'

" airline
set laststatus=2
" set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='bubblegum'
