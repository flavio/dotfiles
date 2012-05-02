filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

syntax on
set tabstop=2
set shiftwidth=2
set expandtab 
set number
set hlsearch
"set smartindent
set nocompatible

if exists("g:btm_rainbow_color") && g:btm_rainbow_color
  call rainbow_parenthsis#LoadSquare ()
  call rainbow_parenthsis#LoadRound ()
  call rainbow_parenthsis#Activate ()
endif

" hidden chars
set list
set listchars=tab:▸\ ,eol:¬,trail:~,extends:>,precedes:< 

"Theming stuff
set background=dark
colorscheme solarized
set t_Co=256

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

"Highlight long lines
:au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

" Yankring
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" Restore cursor position
 autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Changelog
let g:changelog_username = "Flavio Castelli <flavio@castelli.name>"
let g:changelog_dateformat = "%a %b %d %H:%M:%S %Z %Y"

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Highlight current word
" autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

"statusline setup
set statusline=%f "tail of the filename
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*
"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h "help file flag
set statusline+=%y "filetype
set statusline+=%r "read only flag
set statusline+=%m "modified flag
" show Sytntastics warnings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"always show status line
set laststatus=2

" Syntastics
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1