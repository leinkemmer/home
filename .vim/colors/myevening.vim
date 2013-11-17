" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2006 Apr 14

" This color scheme uses a dark grey background.

" First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "myevening"

hi Normal ctermbg=DarkGrey ctermfg=None guifg=None guibg=grey20

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg term=none ctermbg=DarkRed ctermfg=None guibg=Red guifg=None
hi IncSearch term=reverse cterm=reverse gui=reverse
hi ModeMsg term=none cterm=none gui=none
hi StatusLine term=reverse,none cterm=reverse,none gui=reverse,none
hi StatusLineNC term=reverse cterm=reverse gui=reverse
hi VertSplit term=reverse cterm=reverse gui=reverse
hi Visual term=reverse ctermbg=black guibg=grey60
hi VisualNOS term=underline,none cterm=underline,none gui=underline,none
hi DiffText term=reverse cterm=none ctermbg=Red gui=none guibg=Red
hi Cursor guibg=Green guifg=Black
hi lCursor guibg=Cyan guifg=Black
hi Directory term=none ctermfg=LightCyan guifg=Cyan
hi LineNr term=underline ctermfg=Yellow guifg=Yellow
hi MoreMsg term=none ctermfg=LightGreen gui=none guifg=SeaGreen
hi NonText term=none ctermfg=LightBlue gui=none guifg=LightBlue guibg=grey30
hi Question term=none ctermfg=LightGreen gui=none guifg=Green
hi Search term=reverse ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi SpecialKey term=none ctermfg=LightBlue guifg=Cyan
hi Title term=none ctermfg=LightMagenta gui=none guifg=Magenta
hi WarningMsg term=none ctermfg=LightRed guifg=Red
hi WildMenu term=none ctermbg=Yellow ctermfg=Black guibg=Yellow guifg=Black
hi Folded term=none ctermbg=LightGrey ctermfg=DarkBlue guibg=LightGrey guifg=DarkBlue
hi FoldColumn term=none ctermbg=LightGrey ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
hi DiffAdd term=none ctermbg=DarkBlue guibg=DarkBlue
hi DiffChange term=none ctermbg=DarkMagenta guibg=DarkMagenta
hi DiffDelete term=none ctermfg=Blue ctermbg=DarkCyan gui=none guifg=Blue guibg=DarkCyan
hi CursorColumn term=reverse ctermbg=Black guibg=grey40
hi CursorLine term=underline cterm=underline guibg=grey40

" Groups for syntax highlighting
hi Constant term=underline ctermfg=Magenta guifg=#ffa0a0 guibg=grey5
hi Special term=none ctermfg=LightRed guifg=Orange guibg=grey5
if &t_Co > 8
  hi Statement term=none cterm=none ctermfg=Yellow guifg=#ffff60 gui=none
endif
hi Ignore ctermfg=DarkGrey guifg=grey20

" vim: sw=2
