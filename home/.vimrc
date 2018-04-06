filetype off
call pathogen#infect()
filetype plugin indent on

syntax on

" Indentation stuff
set tabstop=2
set shiftwidth=2
set expandtab
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
"set autoindent

set number
set hlsearch  " highlight search terms
set incsearch " show search matches as you type
set nocompatible
filetype plugin indent on

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
"set background=light
colorscheme solarized

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

" CtrlP
nmap <leader>t :CtrlP<CR>
let g:ctrlp_working_path_mode = 'a'

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Tagbar
nmap <F6> :TagbarToggle<CR>

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
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

" Paste large amount of text into Vim
set pastetoggle=<F2>

" Clearing highlighted searches
nmap <silent> ,/ :nohlsearch<CR>

" When you forget to run sudo before editing files
cmap w!! w !sudo tee % >/dev/null


set title        " change the terminal's title
set visualbell   " don't beep
set noerrorbells " don't beep

" vim powerline
let g:Powerline_symbols = 'fancy'

" vim turbux
let g:no_turbux_mappings = 1
map <leader>rt <Plug>SendTestToTmux
map <leader>rT <Plug>SendFocusedTestToTmux

" vim cfengine
autocmd BufRead,BufNewFile *.cf normal zR

" vim rust
let g:rustfmt_autosave = 1
let g:ycm_rust_src_path = '/usr/lib/rustlib/src/rust/src'
