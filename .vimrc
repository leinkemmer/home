set nocompatible

" vundle
filetype off 
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
"  " required! 
Bundle 'gmarik/vundle'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'altercation/vim-colors-solarized'
Bundle 'molokai'
Bundle 'snipMate'
Bundle 'taglist.vim'
Bundle 'Command-T'
filetype plugin indent on     " required!
filetype on

" set leader
let mapleader = "_"

" easy motion plugin triggered by leader
let g:EasyMotion_leader_key = '<Leader>'

" automatically copy to clipboard
" requires (on Ubuntu) gnome-vim or gtk-vim even if vim is run in the terminal only 
set clipboard=unnamed

" vim-latexsuite with pdf as default output
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormat='pdf,dvi'
let g:Tex_ViewRule_pdf='okular'
hi comment ctermfg=blue
" latex preview (conceal verbose math text)
set conceallevel=2

set foldmethod=syntax

" clang-complete
let g:clang_use_library=1

" no backup files
set nobackup
set nowritebackup
" no swap file
set noswapfile

" more space for the command line
" among other things gets rid of pressing enter twice after make
set cmdheight=2

" indentation with tabs
set shiftwidth=4
set tabstop=4

" colorscheme
colorscheme myevening
" disable bold fonts (since I already use bold fonts in the terminal emulator)
set t_md=

" maps
nmap ct <ESC>:CommandT<CR>
nmap tl <ESC>:TlistOpen<CR>
