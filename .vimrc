"
" plugins (managed via vundle)
" 
set nocompatible
filetype off 
set rtp+=~/.vim/bundle/Vundle.vim
" test
call vundle#begin()
" let Vundle manage Vundle (required!)
Bundle 'gmarik/Vundle.vim'
" my plugins (comments at the end of the line are not allowed by vundle)
" colorscheme (dark)
Bundle 'molokai'
" colorscheme (light and dark)
Bundle 'altercation/vim-colors-solarized'
" autosave edits
Bundle 'vim-scripts/vim-auto-save'
" change between header and source
Bundle 'a.vim'
" easymotion 
Bundle 'Lokaltog/vim-easymotion'
" comment/uncomment lines
Bundle "scrooloose/nerdcommenter"
" fast file search in .
Bundle 'Command-T'
" show definitions in current file
Bundle 'taglist.vim'
" snippet engine
Bundle 'SirVer/ultisnips'
" snippets for ultisnip
Bundle 'honza/vim-snippets'
" sorround plugin
Bundle 'tpope/vim-surround'
" a dependency for what comes below
Bundle 'kana/vim-textobj-user'
" select an entire function/if/.. using vif
Bundle 'kana/vim-textobj-function'
call vundle#end()
filetype plugin indent on     " required!
filetype on
syntax on

"
" modify default behavior
"
" no backup and swap files
set nobackup
set nowritebackup
set noswapfile
" automatically copy to clipboard
" might require gnome-vim or gtk-vim even if vim is run in the terminal
set clipboard=unnamed
" more space for the command line
" among other things gets rid of pressing enter twice after make
set cmdheight=2
" automatically save to disk
let g:auto_save = 1

"
" directory with customized snippets
"
set runtimepath+=~/.vim/after/mysnippets
let g:UltiSnipsSnippetsDir = "~/.vim/after/mysnippets"
let g:UltiSnipsSnippetDirectories=["mysnippets"]

"
" customize appearence
"
colorscheme github
" disable bold fonts (bold fonts are already used in the terminal emulator)
set t_md=
" use the molokai color scheme in the terminal
set t_Co=256
" make fonts a bit larger in the gui
set guifont=Inconsolata\ Bold\ 12
" show more code in the gui version
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
" display linenumbers
set number
" highlight long lines in red
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

"
" vim-latexsuite with pdf as default output
"
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormat='pdf,dvi'
let g:Tex_ViewRule_pdf='okular'
hi comment ctermfg=blue
set conceallevel=0
let g:livepreview_previewer = 'okular'

"
" indentation and programming
"
" indent using spaces
"set autoindent
"set expandtab
"set tabstop=4
"set shiftwidth=4
set autoindent
set noexpandtab
set shiftwidth=2
set tabstop=2

" indent preprocessor directives as normal C code
set cinkeys-=0#
" syntax highlighting for gnuplot and gnu files
au BufRead,BufNewFile *.gnuplot		set filetype=gnuplot
au BufRead,BufNewFile *.gnu			set filetype=gnuplot

"
" customize key bindings
"
let mapleader = "_"
" use space for easy motion
"let g:EasyMotion_leader_key = '<Space>'
nmap <Space> <Plug>(easymotion-bd-w)
" open command-T and taglist 
nmap ct <ESC>:CommandT<CR>
nmap tl <ESC>:TlistOpen<CR>
" compile using F4
autocmd filetype gnuplot nnoremap <F4> :w <bar> exec '!gnuplot '.shellescape('%')<CR>
"autocmd filetype c   nnoremap <F4> :w <bar> make<CR>
autocmd filetype c   nnoremap <F4> :w <bar> exec '!tup upd'<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> make<CR>
autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype tex nnoremap <F4> :!latexmk -pdf %<CR>
autocmd filetype markdown nnoremap <F4> :w <bar> make<CR>
" use Tab to expand snippet and move to next placeholder, C-z jumps back
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" toggle visible tab and newline characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
" gd now gives me a choice to which ctag location I want to go
nnoremap gd g<C-]>
" use ; to toggle comments 
nmap ; <Leader>ci
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } } " also in C we want to use // and not /* */
" run clang-format on the current file
map <C-K> :pyf /usr/share/clang/clang-format.py<cr>
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format.py<cr>

"
" CUDA
"
au BufRead,BufNewFile *.cu set filetype=cpp
au BufRead,BufNewFile *.cuh set filetype=cpp


"
" doxygen support
"
autocmd FileType c,cpp set comments-=://
autocmd FileType c,cpp set comments+=:///
autocmd FileType c,cpp set comments+=://

"
" easymotion colors
"
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search

" test
"
" make a visual selection of the current block va{, make a line selection
" (otherwise surround does not work) V, surround by curles braces S{, go to
" insert mode i
"map , va{VS{i

" make a selection of whatever is currently in visual mode
map , S{i

hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

set wildignore+=tmp
