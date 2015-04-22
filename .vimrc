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
Bundle 'a.vim'
Bundle 'vim-scripts/vim-auto-save'
Bundle 'Rip-Rip/clang_complete'
filetype plugin indent on     " required!
filetype on
syntax on

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

" set foldmethod=syntax

" clang-complete
let g:clang_use_library=1
inoremap <C-@> <C-x><C-u>
set completeopt=menu,preview

" no backup files
set nobackup
set nowritebackup
" no swap file
set noswapfile

" more space for the command line
" among other things gets rid of pressing enter twice after make
set cmdheight=2

" indentation with tabs
set autoindent
set noexpandtab
set shiftwidth=4
set tabstop=4

" colorscheme
colorscheme github
" disable bold fonts (since I already use bold fonts in the terminal emulator)
set t_md=

" maps
nmap ct <ESC>:CommandT<CR>
nmap tl <ESC>:TlistOpen<CR>

"set spell

" not so trivial does not consider if but mathches the } in the next line
"set foldmethod=expr foldexpr=GetFoldLevel(v:lnum)
"function! GetFoldLevel(line) 
"   let line_text = getline(a:line) 
"   if (line_text =~ 'for\|if')
"	   return '='
"   elseif (line_text =~ '\%({.*}\)\|\%(}.*{\)') 
"      return '=' 
"   elseif (line_text =~ '{') 
"      return "a1" 
"   elseif (line_text =~ '}') 
"      return "s1" 
"   endif 
"   return '=' 
"endfunction 

" autoamtically save to disk
let g:auto_save = 1

au BufRead,BufNewFile *.gnuplot		set filetype=gnuplot
au BufRead,BufNewFile *.gnu			set filetype=gnuplot

autocmd filetype gnuplot nnoremap <F4> :w <bar> exec '!gnuplot '.shellescape('%')<CR>
autocmd filetype c   nnoremap <F4> :w <bar> make<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> make<CR>
autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype tex nnoremap <F4> :LLPStartPreview<CR>

